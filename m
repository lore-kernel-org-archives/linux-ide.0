Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC2DC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 20 Apr 2022 22:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382844AbiDTWgp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 20 Apr 2022 18:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbiDTWgo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 20 Apr 2022 18:36:44 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8ED3BF9D
        for <linux-ide@vger.kernel.org>; Wed, 20 Apr 2022 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650494036; x=1682030036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4lgTYp4beWNQQ0PzTvH+WAeDNBZ25X0ElX3e2wBoqyY=;
  b=nif5FWf56Ivi5QkCcUi32Ztc6rjGVL8+WVRgO/VrpQQ3Ljf2klBnO9MZ
   R4nhTVbAxeJ4W2ZdFFT/HGBF5UBzE1E7OZ6wJrD6bZjGmtTquBA3gZGXe
   Av/oFgRQYXrH5iDFLbplkKPvhU8injrjl7IV3zkpBUCA/UX34696WRxbh
   J9XRllTEwwJLtc6t8/zmfeBuJqgfPUW5COGxfQatr4eYc+tgQrjDWSI0q
   LK8i4PW2rhten4Kdi6H2//lcrx+w4Mydo8ZOJBIZK3vflc1PsrHLxli68
   DJQRH5BVqdEyFPyPyT/rbIRR7h88uuZQAb4CDH8rQkqFqtdPGNTvnrm2r
   w==;
X-IronPort-AV: E=Sophos;i="5.90,276,1643644800"; 
   d="scan'208";a="203273500"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2022 06:33:55 +0800
IronPort-SDR: lJAdnxgb/s9petKsfJFIrHjqbuYKlIYnPmNxvxydE3WaNFFISf9tGnw8kq6c2GC7trA1b0QU9+
 OZu1UlxjyXjObryOQQ+v4JWbRzoHfU6m7E2FwHeypsUqY7igLNS+X8p0LuvdNRIqo9ciU7IoXR
 oiZSTYX+Ypjco+xG7HLDJ34KzaZwph0XvGij6QvhBw2HQLThlPEocBy7nmYlKm/mAMiGgH8JR+
 Dgeun73yDjjYos5aNlmpkjL0TnlMap8cWSwUuM6ic5Wejbvp/8bolJN6hbaVVUGikyFHeaBU+i
 ThMKTrVYVNfbUJ2nKVM4m1I6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2022 15:04:13 -0700
IronPort-SDR: SBgQc+wObF4LOZ/tkdIp2LnVmuS8pvMvnHjB4eKKua3/i9BFU248gQJq2OZGf7/ei1d6vtD1rR
 9e3BQjD/ofClDCXMcrDzTc26pPVVelWtxGGtpHBxgO8dMrIRqOUfZLpZYRc0UqIOOvNyHbJNNa
 W9ya7xS2tpyfk6om3qieSIe8iQclGFs6LBxMCJHORZdwy6jMAVNCDNg4UE4nkPj+0HAKTP0bpy
 5wwxFXkcIn+8ybPCFOkxgPcjO8rD4+7TsyEobVGprPGXbvJTE1aERhM/UdNFKS0EpxpPnS3eO5
 FhQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2022 15:33:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkFnv3C0cz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed, 20 Apr 2022 15:33:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650494034; x=1653086035; bh=4lgTYp4beWNQQ0PzTvH+WAeDNBZ25X0ElX3
        e2wBoqyY=; b=bWDY651T5piuKIZEzu/pqHevDlQF+nH8LEBqH2TmRoyOgMo7Mtv
        mdE1WtVPjY4+58pFJ8s0bZHkjev4DCi80eppn/nR++1lLNwz7My0rqNaAspZHL9p
        oTeiEMeuekE3GnnbRgolbpuzBESk/9zZwE+k08EfbTZUWTCGeqXygwSFkL2GgCgp
        /To7SBNQ8PszPzPYSWnNlWe2gaolErwce1ccHuzaTQhSz+XpOPPgSvuW1/u5Nx0T
        QullpKAPdB7DR53MAsufyYgacsRJM+y1cBF5+vXWx9hPE7WurC5cTWgvNQnpb4cC
        MKrHguBvPVjWQx3WMHm+eCaj0W/BZ5hSFRQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id f9QqDbHuTicA for <linux-ide@vger.kernel.org>;
        Wed, 20 Apr 2022 15:33:54 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkFns6zfRz1Rvlx;
        Wed, 20 Apr 2022 15:33:53 -0700 (PDT)
Message-ID: <da32482a-a38c-091d-ae28-aecb56fe1e7a@opensource.wdc.com>
Date:   Thu, 21 Apr 2022 07:33:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ata: pata_marvell: Check the 'bmdma_addr' beforing
 reading
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220420122134.430997-1-zheyuma97@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220420122134.430997-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/20/22 21:21, Zheyu Ma wrote:
> Before detecting the cable type on the dma bar, the driver should check
> whether the 'bmdma_addr' is zero, which means the adapter does not
> support DMA, otherwise we will get the following error:
> 
> [    5.146634] Bad IO access at port 0x1 (return inb(port))
> [    5.147206] WARNING: CPU: 2 PID: 303 at lib/iomap.c:44 ioread8+0x4a/0x60
> [    5.150856] RIP: 0010:ioread8+0x4a/0x60
> [    5.160238] Call Trace:
> [    5.160470]  <TASK>
> [    5.160674]  marvell_cable_detect+0x6e/0xc0 [pata_marvell]
> [    5.161728]  ata_eh_recover+0x3520/0x6cc0
> [    5.168075]  ata_do_eh+0x49/0x3c0
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/ata/pata_marvell.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
> index 0c5a51970fbf..d2922699be5e 100644
> --- a/drivers/ata/pata_marvell.c
> +++ b/drivers/ata/pata_marvell.c
> @@ -77,7 +77,9 @@ static int marvell_cable_detect(struct ata_port *ap)
>  	switch(ap->port_no)
>  	{
>  	case 0:
> -		if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)
> +		if (!ap->ioaddr.bmdma_addr)
> +			return ATA_CBL_PATA_UNK;
> +		else if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)

No need for the "else" here.

>  			return ATA_CBL_PATA40;
>  		return ATA_CBL_PATA80;
>  	case 1: /* Legacy SATA port */


-- 
Damien Le Moal
Western Digital Research
