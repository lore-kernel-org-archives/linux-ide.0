From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] [libata] beautify module parameters
Date: Sun, 21 Jun 2009 23:08:35 -0400
Message-ID: <4A3EF5B3.1040500@pobox.com>
References: <1245617000-23868-1-git-send-email-sargentd@die-welt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59692 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbZFVDIJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Jun 2009 23:08:09 -0400
In-Reply-To: <1245617000-23868-1-git-send-email-sargentd@die-welt.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Evgeni Golov <sargentd@die-welt.net>
Cc: linux-ide@vger.kernel.org

Evgeni Golov wrote:
> 1. add defaults to description where possible
> 2. add value definition (off=0, on=1) where missing
> 
> Signed-off-by: Evgeni Golov <sargentd@die-welt.net>
> ---
>  drivers/ata/libata-core.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index ca4d208..da27a3c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -125,11 +125,11 @@ MODULE_PARM_DESC(force, "Force ATA configurations including cable type, link spe
>  
>  static int atapi_enabled = 1;
>  module_param(atapi_enabled, int, 0444);
> -MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
> +MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices; on by default (0=off, 1=on)");
>  
>  static int atapi_dmadir = 0;
>  module_param(atapi_dmadir, int, 0444);
> -MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off, 1=on)");
> +MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support; off by default (0=off, 1=on)");

I would prefer a more concise

	"Enable ATAPI DMADIR bridge support (0=off [default], 1=on)"

Regards,

	Jeff



