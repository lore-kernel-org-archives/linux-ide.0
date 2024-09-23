Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C93749649;
	Mon, 23 Sep 2024 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081372; cv=none; b=BI/WBMAAHB7FMfbFhEbzBuKotFVll3v026NZ1tNFMQh5RVrKGQwFCrGGH39I92W9gcN9kno2mGMu7otEqAG8L9eyJ3XlY+PUq7QRUH4SoGs1NRqu50rfkdwamJdwECoiD7YUFREE90EZjqwa2ivxhQxYEPNEQeHVD1ya6LpIV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081372; c=relaxed/simple;
	bh=EqNWYPmG4PZO52qTitEkJ2r/WsrLm1uo5s9ceoEw/+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSNFg33GYVabkiylijIVLKsZ+jUjPQXePXJg4FtpamPVl2SkjJHyMJEFmDfDgDQjWYGqbjpBS2z7xjhumkOub8Aq53wib4N2QIB7eWVypjZsOapffMhN5hgAjRZ3KlImWsaDgmufMlHXY232Ywx0/4EQ6y6FJ3jzXMmxsh6Bm3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfbQWNRQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfbQWNRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D3FC4CEC4;
	Mon, 23 Sep 2024 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727081372;
	bh=EqNWYPmG4PZO52qTitEkJ2r/WsrLm1uo5s9ceoEw/+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DfbQWNRQ8wfGebljbEL/mOziyWtv70gsdpbGBWqQHc8dsFvQY4dCX7pjVzFWSPV7c
	 ZACU33Fg8uielVUXceX+HJO6aKrZOI8RnAVdyFFxZNi/ug0DJE2fFfnThadQw0Gky6
	 nocoyG18IViI6Qo0SnnuWdHArjBQQ3f5NwBalt7ooX/9ub5XdLJNn3dOtjaOp9Eg96
	 +LtmxkAs30vzhVOvoPpRaAxiG8TeMDNvADiY5q8zzrNVzrHT2Mgcy8PEquMz8QUn71
	 vuxUP0FaNMGmO6+HLcAfhLAm9WO6ky/DZEDfVFudKv5K2d+ZJsNg9+5UKZIpvkvnAe
	 i+2tPtCDwZTdQ==
Message-ID: <f70ee386-d8eb-4d28-99fd-9d40e5d93ca8@kernel.org>
Date: Mon, 23 Sep 2024 10:49:29 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: fix ALL_SUB_MPAGES not to be performed when
 CDL is not supported
To: Jeongjun Park <aha310510@gmail.com>, cassel@kernel.org
Cc: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240921124117.82156-1-aha310510@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240921124117.82156-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/21 14:41, Jeongjun Park wrote:
> In the previous commit 602bcf212637 ("ata: libata: Improve CDL resource
> management"), the ata_cdl structure was added and the ata_cdl structure
> memory was allocated with kzalloc(). Because of this, if CDL is not 
> supported, dev->cdl is a NULL pointer, so additional work should never 
> be done.
> 
> However, even if CDL is not supported now, if spg is ALL_SUB_MPAGES,
> dereferencing dev->cdl will result in a NULL pointer dereference.
> 
> Therefore, I think it is appropriate to check dev->flags in 
> ata_scsiop_mode_sense() if spg is ALL_SUB_MPAGES to see if CDL is supported.
> 
> Reported-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> Tested-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
> Fixes: 602bcf212637 ("ata: libata: Improve CDL resource management")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  drivers/ata/libata-scsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 3328a6febc13..6f5527f12b0e 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2442,7 +2442,9 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
>  	if (spg) {
>  		switch (spg) {
>  		case ALL_SUB_MPAGES:
> -			break;
> +			if (dev->flags & ATA_DFLAG_CDL)
> +				break;
> +			fallthrough;

I do not think this is correct at all. If the user request all sub mpages, we
need to give that list regardless of CDL support. What needs to be fixed is that
if CDL is NOT supported, we should not try to add the information for the T2A
and T2B sub pages. So the fix should be this:

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3328a6febc13..6ffa975746a6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2256,10 +2256,15 @@ static inline u16 ata_xlat_cdl_limit(u8 *buf)
 static unsigned int ata_msense_control_spgt2(struct ata_device *dev, u8 *buf,
                                             u8 spg)
 {
-       u8 *b, *cdl = dev->cdl->desc_log_buf, *desc;
+       u8 *b, *cdl, *desc;
        u32 policy;
        int i;

+       if (!(dev->flags & ATA_DFLAG_CDL) || !dev->cdl)
+               return 0;
+
+       cdl = dev->cdl->desc_log_buf;
+
        /*
         * Fill the subpage. The first four bytes of the T2A/T2B mode pages
         * are a header. The PAGE LENGTH field is the size of the page


>  		case CDL_T2A_SUB_MPAGE:
>  		case CDL_T2B_SUB_MPAGE:
>  		case ATA_FEATURE_SUB_MPAGE:
> --

-- 
Damien Le Moal
Western Digital Research

