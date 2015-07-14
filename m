From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] libata: add ATA_HORKAGE_NOTRIM
Date: Tue, 14 Jul 2015 14:43:04 +0300
Message-ID: <55A4F5C8.3010908@cogentembedded.com>
References: <1436873314-22563-1-git-send-email-arne_f@ipfire.org>
 <1436873314-22563-2-git-send-email-arne_f@ipfire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35768 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbbGNLnH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2015 07:43:07 -0400
Received: by lblf12 with SMTP id f12so4453237lbl.2
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2015 04:43:06 -0700 (PDT)
In-Reply-To: <1436873314-22563-2-git-send-email-arne_f@ipfire.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arne Fitzenreiter <arne_f@ipfire.org>, tj@kernel.org
Cc: linux-ide@vger.kernel.org

Hello.

On 7/14/2015 2:28 PM, Arne Fitzenreiter wrote:

> sone disks lose data at trim also with disabled ncq
> so this add a switch to force disable trim.

    You forgot to sign off on the patch, so it can't be applied.

[...]
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index d6c37bc..3a13c7d 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -569,6 +569,8 @@ show_ata_dev_trim(struct device *dev,
>
>   	if (!ata_id_has_trim(ata_dev->id))
>   		mode = "unsupported";
> +	else if (ata_dev->horkage & ATA_HORKAGE_NOTRIM)
> +			mode = "forced_unsupported";

    Indented too much.

>   	else if (ata_dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
>   			mode = "forced_unqueued";

    Hm, I see where this comes from...

[...]

MBR, Sergei

