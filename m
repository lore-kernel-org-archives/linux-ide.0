From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] [SCSI] esas2r: Fix comment
Date: Tue, 22 Apr 2014 16:19:39 +0400
Message-ID: <53565E5B.8070008@cogentembedded.com>
References: <1398113749-7491-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:37150 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845AbaDVMTo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2014 08:19:44 -0400
Received: by mail-la0-f44.google.com with SMTP id b8so662899lan.31
        for <linux-ide@vger.kernel.org>; Tue, 22 Apr 2014 05:19:43 -0700 (PDT)
In-Reply-To: <1398113749-7491-1-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>, linux-ide@vger.kernel.org
Cc: James Bottomley <JBottomley@Parallels.com>, Bradley Grove <bgrove@attotech.com>

Hello.

On 22-04-2014 0:55, Marek Vasut wrote:

    Shouldn't this patch have been posted to linux-scsi instead of linux-ide?

> Minor fix for a comment in the driver so that it matches the function name.

    It's a message, not a comment.

> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: James Bottomley <JBottomley@Parallels.com>
> Cc: Bradley Grove <bgrove@attotech.com>
> ---
>   drivers/scsi/esas2r/esas2r_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
> index f37f3e3..6504a19 100644
> --- a/drivers/scsi/esas2r/esas2r_main.c
> +++ b/drivers/scsi/esas2r/esas2r_main.c
> @@ -390,7 +390,7 @@ static int esas2r_probe(struct pci_dev *pcid,
>   	esas2r_log_dev(ESAS2R_LOG_INFO, &(pcid->dev),
>   		       "pci_enable_device() OK");
>   	esas2r_log_dev(ESAS2R_LOG_INFO, &(pcid->dev),
> -		       "after pci_device_enable() enable_cnt: %d",
> +		       "after pci_enable_device() enable_cnt: %d",
>   		       pcid->enable_cnt.counter);

WBR, Sergei

