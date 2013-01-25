From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v3] ata: libata-core: initialize native_sectors in ata_hpa_resize()
Date: Fri, 25 Jan 2013 15:21:53 +0400
Message-ID: <51026AD1.7070202@mvista.com>
References: <1359057478-3920-1-git-send-email-sque@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:47335 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618Ab3AYLWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2013 06:22:11 -0500
Received: by mail-lb0-f175.google.com with SMTP id n3so515181lbo.34
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2013 03:22:09 -0800 (PST)
In-Reply-To: <1359057478-3920-1-git-send-email-sque@chromium.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Que <sque@chromium.org>
Cc: linux-ide@vger.kernel.org, msb@chromium.org

Hello.

On 24-01-2013 23:57, Simon Que wrote:

> Eliminates a compiler warning about uninitialized variable.
> "warning: 'native_sectors' may be used uninitialized in this function"

> Signed-off-by: Simon Que <sque@chromium.org>
> ---
>   drivers/ata/libata-core.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d2b18ea..b185db1 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1324,7 +1324,7 @@ static int ata_hpa_resize(struct ata_device *dev)
>   	int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
>   	bool unlock_hpa = ata_ignore_hpa || dev->flags & ATA_DFLAG_UNLOCK_HPA;
>   	u64 sectors = ata_id_n_sectors(dev->id);
> -	u64 native_sectors;
> +	u64 native_sectors = 0;

    Isn't it wiser to set it to 'sectors'? And frankly speaking I don't see 
how this variable may indeed be used unitialized. What version of gcc are you 
using?

MBR, Sergei

