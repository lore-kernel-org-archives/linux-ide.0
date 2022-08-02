Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67141C00140
	for <linux-ide@archiver.kernel.org>; Tue,  2 Aug 2022 22:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiHBW5V (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiHBW5U (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Aug 2022 18:57:20 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DAC1FCC2
        for <linux-ide@vger.kernel.org>; Tue,  2 Aug 2022 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659481038; x=1691017038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jpafNtRdbTcTyfxoHa3gVGFq8NXao9oqi1tHEufvpus=;
  b=gpgqr3jtIuYSw9DtiGpdvE+5YDjzBTg3HwHl4uTUtRA2Xcimiuqrckhj
   +e7xKmgCnEVRTAcNFAWoeC660FcGUv3x6iJ9eEiCbdw4ZDyv1v0qr8h6g
   Jv2/kphcWfrccVNTGkS3WX452PwJRPehWYx3wuXLnD31288mDFsE+7fFA
   u+vK9Ei610XjfxSriWtgRbZQiphl4VqaWk8fC2nJQZdexkCFX0vzorYwy
   s7XXGlE1JYoOXy4lporZgLH+vQ2XQAV5zYIajQ5QYrGbZArxF2mNOByjZ
   quSNdKgnjG0XDE/ojZih6Yjd3IY7WW5FYVb1Z1sxMaR8rZ52X19jj7y6T
   w==;
X-IronPort-AV: E=Sophos;i="5.93,212,1654531200"; 
   d="scan'208";a="207633755"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2022 06:57:18 +0800
IronPort-SDR: AqIoNuheLk/VGPO61MDJYK3P7gF2VG7leXsAazRJ1JmZ/ZQm2N+T2qtLglhBq7OcJ7dIBSDRMu
 aYLGDAuYvvAK06cy3DwMRdMq+lcqQ0AHRF3nWb17kTr3lTKOQaupxBblDhu13JuuUzp0275R19
 6QZw3vqkZ16Dh+LzVb2CEwwqS7jv+G91Kw6UjdMZo//UrQnEiMzMkfC8E3X4m3eK3+nHe/V/5O
 TTESXsbEKw9zhsNOVIBBagl/tNhdCHzAwa7E9PYdHANnG3XEYViH/QN5mTUCGBlrPzaLnZ9v0B
 9Rd9gPLhX35sgDdu9yPU9/8+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2022 15:18:23 -0700
IronPort-SDR: rB7m/TC4fp6pGzPlGZuct6wpfvbr5UXoSQIHwhRkB01eepZ9hJDPqAfSJs29aX19mDO1atwP16
 rMy9Vs5esUf10B5FYa5/DOcdrOHPX2ukJBlql8bc7bbVEWHr3eDHSQt65IIRUdlk3taMs34dUW
 zXoT4EYaTvR2aeSLZ2FH3bfzPGpISpx/wd4Z+59KbmoU6OtB7kK0q9Z2DoVhBTYrEqirM2lirN
 O5H3f9tktG7HVNNBqzvNxO9o5ztAjkNf7eqN4pWc+GqsHYgD2J2k0Hsi5ZbXkC971cj3OjR0ur
 DC4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2022 15:57:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ly9Nt4Sv5z1Rw4L
        for <linux-ide@vger.kernel.org>; Tue,  2 Aug 2022 15:57:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1659481038; x=1662073039; bh=jpafNtRdbTcTyfxoHa3gVGFq8NXao9oqi1t
        HEufvpus=; b=fH6gID2oRo5GuO584RRijW2vUQVw+v2uUvxXp/bxwvG9TieYIwk
        m9tZzXAsFMbzI14ppWlRM4brA7FZE5psuj64CmOQQIvvaikICWR1Zs8pkDSHCrKQ
        586Px+tab6+Z2hTXFq0Z0No+T5/dB+dfuvwI1eCAEkpZWlXtqjbMCpyHYLCfuxGu
        UQ4ILLcVV2mx++zR7DZq9xRpYsMsy07qt84Vx3n/cDqb9M0w1iNorId7Li8UBsOZ
        tlNTCA02V3v/BxSvDY3vPy8lSEor9iZUQnl7d4Ny1WF3i4c8FFb8l1I4YpeCc2d0
        YGMG0idNss16QffwBKRACXL+Q0M1N9Lz24g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3xH_dUHSvS1J for <linux-ide@vger.kernel.org>;
        Tue,  2 Aug 2022 15:57:18 -0700 (PDT)
Received: from [10.225.163.22] (unknown [10.225.163.22])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ly9Ns5DwHz1RtVk;
        Tue,  2 Aug 2022 15:57:17 -0700 (PDT)
Message-ID: <6991c97b-7bd2-8bab-dcc1-3c58550b0441@opensource.wdc.com>
Date:   Wed, 3 Aug 2022 07:57:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] libata: specify timeout value when internal command
 times out.
Content-Language: en-US
To:     Tomas Henzl <thenzl@redhat.com>, linux-ide@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com
References: <20220730181444.6420-1-thenzl@redhat.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220730181444.6420-1-thenzl@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/31/22 03:14, Tomas Henzl wrote:
> Specifying timeout value may help in troubleshooting failures.

s/Specify/Print the

And in the patch title too. I.e.:

ata: libata: Print timeout value when internal command times out

No period at the end of the patch title.

And please use get_maintainer.pl: ata patches should be addressed to me
too otherwise, there's a high chance they will be ignored.

> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
> ---
> 
> V2: timeout changed to unsigned int as in for-next
> 
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 826d41f341e4..0fc4782ef4f8 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1578,8 +1578,8 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>  			else
>  				ata_qc_complete(qc);
>  
> -			ata_dev_warn(dev, "qc timeout (cmd 0x%x)\n",
> -				     command);
> +			ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
> +				timeout, command);
>  		}
>  
>  		spin_unlock_irqrestore(ap->lock, flags);
> 


-- 
Damien Le Moal
Western Digital Research
