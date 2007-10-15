From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: prevent devices with blank model names from being
 DMA blacklisted
Date: Mon, 15 Oct 2007 15:41:50 -0400
Message-ID: <4713C27E.70808@garzik.org>
References: <76366b180710141353q781a4928t4a7282976c9c3329@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35124 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069AbXJOTly (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Oct 2007 15:41:54 -0400
In-Reply-To: <76366b180710141353q781a4928t4a7282976c9c3329@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Andrew Paprocki wrote:
> The strn_pattern_cmp routine does not handle a blank name parameter
> properly. The only patterns which should match a blank name are "*"
> and an explicit "". If the function is passed a blank name in current
> code, it will always match against the patt parameter. The bug manifests
> itself as the device with the empty model name always matching the first
> device in the DMA blacklist, forcing it to revert to PIO mode.
> 
> Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
> ---
>  drivers/ata/libata-core.c |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4e11e39..e73b7b4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4013,8 +4013,19 @@ int strn_pattern_cmp(const char *patt, const
> char *name, int wildchar)
>         p = strchr(patt, wildchar);
>         if (p && ((*(p + 1)) == 0))
>                 len = p - patt;
> -       else
> +       else {
>                 len = strlen(name);
> +               /* If the model name parameter is empty, it should not match
> +                * against anything other than "*" or "".
> +                */
> +               if (unlikely(len == 0)) {
> +                       /* In the rare case your pattern is "". */
> +                       if (strlen(patt) == 0)
> +                               return 0;
> +                       else
> +                               return -1;
> +               }
> +       }

applied manually, patch was corrupted


