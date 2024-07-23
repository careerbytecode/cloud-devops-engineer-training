"""Azure Function App to redirect requests to the correct domain."""
import json
import os
from urllib.parse import urlparse

import azure.functions as func


def main(req: func.HttpRequest) -> func.HttpResponse:
    """Main function entrypoint for Azure Function App."""
    redirect_mappings = json.loads(os.environ["redirect_mappings"])
    http_redirect_code = int(os.environ["http_redirect_code"])

    domain_name = urlparse(req.url).netloc

    if domain_name in redirect_mappings:
        return func.HttpResponse(
            body=f"Redirecting to {redirect_mappings[domain_name]}",
            status_code=http_redirect_code,
            headers={"Location": redirect_mappings[domain_name]},
        )

    return func.HttpResponse(
        body=f'"Could not find redirect mapping for {domain_name}"', status_code=500
    )
