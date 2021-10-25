Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496B2C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 25 Oct 2021 00:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A74D60FDA
	for <linux-ide@archiver.kernel.org>; Mon, 25 Oct 2021 00:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhJYADQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Oct 2021 20:03:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51343 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJYADQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Oct 2021 20:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635120055; x=1666656055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hc5PEPI7BUMGCztrsv2fuMCX9yzlqOPTN+3m/SEpSLg=;
  b=Q+g/g1bBm0GIYe5YWqJcOtT0QIujDDteBRJBcYp5zymXap5W+roHtobJ
   A5XkMzQpLnoNkyUZoEq2gm2tu6b/+lZ3YnTtO7/H//P4K0fEvo+nfNph9
   v0dLapDwBZhYuG1Fw1li3Ukb2z24zXi4oLhhcnmhWakRIFxw+8CqaicuG
   4A08cJfwZBwt0YzS/ZA9F/9NxEQ70JRP3rCs8qNaDXKwwH0l8vWvq2x6q
   YEZjoENJAAAc3wJ3FpvqJ5GCmwnPMqXebdnckmrl7Z7rkeXKA2D7Bvmig
   wy5LK3VwLSQlJRXiLH+TBoZtRhPUiyOK3tZWPLP971enyWddWFUwGy4gb
   A==;
X-IronPort-AV: E=Sophos;i="5.87,179,1631548800"; 
   d="scan'208";a="184661652"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2021 08:00:55 +0800
IronPort-SDR: nL1xDL4Eb/KJTfHvraBiKMvho2kbar0fPgUso8wsHawr5hofVLJQregFA/pxnb3GjU7RUCFxXI
 qm5GWLxa9mMAgc+USTmLI3Q/6nllMOac2cOgFa3NoGQJLYw+BxiFr2u1ZZYlsaS7WRzR9egJpw
 nWuIjd2RlLn+Vod4QzGzVWOp7oNCWNXF39U01hd5TYoD8iCs/1ecJ0cEEbYyHJI9kcshWWzEP7
 ustcaigm2sFAsAPIAF0328vcl4J+sntaGFQOkSOh4V/U4SvmJX4kin9PvJveAwDvKMqjLU0d94
 9pHCvDROcVK5lSOP/+iBaBGu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 16:34:53 -0700
IronPort-SDR: 7qz0jweLnwTazTk/UpgBs5Z08FTeBPCNqF46g0zKRSi/xm4GI/3jqgRk+GlhzCG3Y76cITvt+C
 gHa0AdZjpcvF8BoFZ1x/rv6I1nR0gHWT54ODy7L/+k6q/3pUyvAg2gCO0aBGT1d+G4aN7gtMp+
 7sqeDlSEzNw3iQuTOBEHzVGqRxJu8Ulv5GPXdEwSRApf9qYymbn7ecpdTqWk7ofNhUB3i3glxS
 UY0aPu0YPZXqhPWBO5TSO3yQAxxLJUDZgPlt4P2RiRtl3qxHbkn8PbJLxMSxqC3H1UJ9JtGore
 6ks=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 17:00:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hcw8Q2Rl9z1RtVm
        for <linux-ide@vger.kernel.org>; Sun, 24 Oct 2021 17:00:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1635120054; x=1637712055; bh=Hc5PEPI7BUMGCztrsv2fuMCX9yzlqOPTN+3
        m/SEpSLg=; b=TGpQ+nw/pgigLu6Zz87cyR660u+8FYu73e2VKbSYXRyo9cd6E2M
        25yuEhlEHS6HNTqKY3MxCDaZs9G+BoJGc9o9vJ7JkldcQPMINOVki9IySQjnD3tN
        DQKVGC3//dSn+ZSFXSLaIEK2p5vYjusEsxpIGPWvSUSyBSQ0XteaIZfCizIGnsYf
        8sKkAB7648KBiyFgkpmvO0OugerPr1P6Athn6BKJTsZJRWIQK5rs2nsRaMSizU16
        25onF8yT9Gc5O4ORheoMl1WqK6umuEDjdxpbOvJK+nBCnodV2Xnhqeb86Q9nVZWb
        Avi2Esq7KHKrIqX+mPosNOX9U/PGD6qk1zQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NV39ULLmueAG for <linux-ide@vger.kernel.org>;
        Sun, 24 Oct 2021 17:00:54 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hcw8P4Zryz1RtVl;
        Sun, 24 Oct 2021 17:00:53 -0700 (PDT)
Message-ID: <3a3083f5-4843-5258-31ca-61a50cebbc1f@opensource.wdc.com>
Date:   Mon, 25 Oct 2021 09:00:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v2] ata: sata_mv: Fix the error handling of mv_chip_id()
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     linux-ide@vger.kernel.org
References: <1634893946-16195-1-git-send-email-zheyuma97@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <1634893946-16195-1-git-send-email-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/10/22 18:12, Zheyu Ma wrote:
> mv_init_host() propagates the value returned by mv_chip_id() which in turn
> gets propagated by mv_pci_init_one() and hits local_pci_probe().
> 
> During the process of driver probing, the probe function should return < 0
> for failure, otherwise, the kernel will treat value > 0 as success.
> 
> Since this is a bug rather than a recoverable runtime error we should
> use dev_alert() instead of dev_err().
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v2:
>     - Change the error code
>     - Change the logging function
> ---
>  drivers/ata/sata_mv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 9d86203e1e7a..c53633d47bfb 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -3896,8 +3896,8 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
>  		break;
>  
>  	default:
> -		dev_err(host->dev, "BUG: invalid board index %u\n", board_idx);
> -		return 1;
> +		dev_alert(host->dev, "BUG: invalid board index %u\n", board_idx);
> +		return -EINVAL;
>  	}
>  
>  	hpriv->hp_flags = hp_flags;
> 

Applied to for-5.15-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
