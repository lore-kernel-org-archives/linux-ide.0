From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH resend v2 3/5] libata-scsi: use u8 array to store mode
 page copy
Date: Fri, 22 Jul 2016 12:59:01 +0300
Message-ID: <65ee2deb-200c-a467-1eb8-ed2eb5f14a70@cogentembedded.com>
References: <20160721214202.GG23759@htj.duckdns.org>
 <accc8ca07073cd0292b62903acac956f5f5eff74.1469143747.git.tom.ty89@gmail.com>
 <9bbf2b818f9ca1bb48f1eae31a0f3924a4fe0d9a.1469143747.git.tom.ty89@gmail.com>
 <8d3cb878e86e0e4be2212f05ce47ff60cbfd3e10.1469143747.git.tom.ty89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34278 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbcGVJ7G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jul 2016 05:59:06 -0400
Received: by mail-lf0-f48.google.com with SMTP id l69so81977429lfg.1
        for <linux-ide@vger.kernel.org>; Fri, 22 Jul 2016 02:59:05 -0700 (PDT)
In-Reply-To: <8d3cb878e86e0e4be2212f05ce47ff60cbfd3e10.1469143747.git.tom.ty89@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tom.ty89@gmail.com, tj@kernel.org, hare@suse.de, arnd@arndb.de
Cc: sfr@canb.auug.org.au, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org

Hello.

On 7/22/2016 2:29 AM, tom.ty89@gmail.com wrote:

> From: Tom Yan <tom.ty89@gmail.com>
>
> ata_mselect_*() would initialize a char array for storing a copy of
> the current mode page. However, char could be signed char. In that
> case, bytes larger than 127 would be converted to negative number.
>
> For example, 0xff from def_control_mpage[] would become -1. This
> prevented ata_mselect_control() from working at all, since when it
> did the read-only bits check, there would always be a mismatch.
>
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 4a4e6f1..a28e2ea94 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3610,7 +3610,7 @@ static int ata_mselect_caching(struct ata_queued_cmd *qc,
>  {
>  	struct ata_taskfile *tf = &qc->tf;
>  	struct ata_device *dev = qc->dev;
> -	char mpage[CACHE_MPAGE_LEN];
> +	u8 mpage[CACHE_MPAGE_LEN];
>  	u8 wce, mask;
>  	int i;
>
> @@ -3668,7 +3668,7 @@ static int ata_mselect_control(struct ata_queued_cmd *qc,
>  			       const u8 *buf, int len, u16 *fp)
>  {
>  	struct ata_device *dev = qc->dev;
> -	char mpage[CONTROL_MPAGE_LEN];
> +        u8 mpage[CONTROL_MPAGE_LEN];

    Indent with tabs please, as above.

[...]

MBR, Sergei

