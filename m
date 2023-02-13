Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C211C05027
	for <linux-ide@archiver.kernel.org>; Mon, 13 Feb 2023 01:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBMB26 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Feb 2023 20:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMB25 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2023 20:28:57 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34D5CDE2
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 17:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676251735; x=1707787735;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F5UBfMTx3xxjZwFuZStDP7IlD19natH5+Jj5uJx8H84=;
  b=WZjEU0LKLaNYQMj3c/ez3+/Qa13bDmu6e6CTJ7Hq6BOZGeF+CRhLty+1
   ri9O4uj0ruqnIYWUU1l+Bokh0E39SYwDWBTtDTSlG2ZNRNioaNWfdE+H2
   vwaQ4zd7fJZsIUGklsDCpc2pq6krfA9Yz+YeKmS6ZLHjnvhKRrecsD4gB
   LmJAMfASYGvo6JuuzOs59fChCut2uSMCJWLoVhcqqMKbaoZ9jnplAH6Vk
   aLcabMUma8/PLcrIz2MoRGPUjSr7YgWlU0KgTVoti0oOlX+oh72AxJiSr
   kp+xJ3udDqAh4HkLQ/ivuTfLtndLE1gdEdfQV0hTp3H2k/7FDDvk+nt7o
   w==;
X-IronPort-AV: E=Sophos;i="5.97,291,1669046400"; 
   d="scan'208";a="223161940"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2023 09:28:54 +0800
IronPort-SDR: SlqigfDXrV/437oInEmBUF7vfB1T4Q479eqII1GkC01harkECswP/iqiAgwLK0MMszTCuLU/ZI
 aTkUulTOJEQqjNmd8AkyKh5l/3oYu7aRqK5z6F3KTqWTrDUbEBVaFlCsQ/ft0CIxBsZHsn+cVw
 xPM4gd59Z594gnhOg6tCXl2nI9dzJcA2EdE8oaaLum91A+sFthVKnkXvQw3zLDiHTahUUGtmWb
 Bm6Ewklf7LPquspMUQRWwOSDMnRIWcL1j460/XrnyjQFwDnykuu767e9pUAx12nn01VYPjzYkO
 syc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 16:46:04 -0800
IronPort-SDR: V4ymE8cCUt1pdaXw4zchkiplcnQnX+mI7XRIz27gd+ds8zY6qQ2oQIhCy38Y4iStdBjW9iEbe3
 7GEhYDde3VvnQuuQUhUy2PGWAGBOtoW/SqprtOaIaWqcmrBwOLUsE6I8CDsC/I+EKbcOycvLwB
 ukWKKoJ80uPFu2x2t8wVB5+Npo1ddUOmTaxcy65SPUmLHevApeOS3gadCcWNt+GomyWYpDCog4
 5IPli7KJyiX436LT6Oqxi05/ytv+k86utPK9W3DI4SDENVgbAyxSiWGVd/4HQbSY6ahUEYKqlG
 vOk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 17:28:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PFRZG4kp6z1RvTr
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 17:28:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676251733; x=1678843734; bh=F5UBfMTx3xxjZwFuZStDP7IlD19natH5+Jj
        5uJx8H84=; b=dc1Vkbd7KHMyvJxPfrgEMJ/uxDdzFhoUT2673gXMA2bxcROhGMU
        PnlfGBbCpRJP/wGWSWfB4pdgC5IhU8yj+ewfbCevVZ5eTfWStNxjSsP5dcmOL1oj
        ZOjtOPtFwsPJ9aLPN0qsa6e6DbWw08acS98PFSTtGVU6d29sysJemID4VqORut7y
        Sh1Fl4HKARkVH4zZCmWQm6TE5yn8k3Eqvfulat3Jd+FNU29XdG8KD3J/whLGseOr
        7j8zJMplcBcjOljYF0h6mW63ExUFb6kiZXonvcCf9tb+8qTn+KsUmsZC5JAekIbt
        6vuYpKySpiOl0+jNyyLSPRpwF32mVTLJF3A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lRPVWJefJH0f for <linux-ide@vger.kernel.org>;
        Sun, 12 Feb 2023 17:28:53 -0800 (PST)
Received: from [10.225.163.110] (unknown [10.225.163.110])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PFRZF0bBXz1RvLy;
        Sun, 12 Feb 2023 17:28:52 -0800 (PST)
Message-ID: <b02e3814-16a0-9bc6-01be-d53fa81d99c2@opensource.wdc.com>
Date:   Mon, 13 Feb 2023 10:28:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Marvel 88SE6121 fails with SATA-2/3 HDDs
Content-Language: en-US
To:     Hajo Noerenberg <hajo-linux-ide@noerenberg.de>,
        linux-ide@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, risc4all@yahoo.com
References: <db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de>
 <930a0685-c741-110e-40c2-660754301e5a@opensource.wdc.com>
 <a248857e-991c-16d7-496c-9dc692186ead@noerenberg.de>
 <b4a515f6-e11c-756b-ff90-114836f919f9@noerenberg.de>
 <341397a1-9da5-466d-a738-cad79e8d2390@opensource.wdc.com>
 <53372f11-1d97-5310-32e7-6368a653115f@noerenberg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <53372f11-1d97-5310-32e7-6368a653115f@noerenberg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/1/23 19:02, Hajo Noerenberg wrote:
> Am 31.01.2023 um 03:34 schrieb Damien Le Moal:
>> On 1/30/23 22:40, Hajo Noerenberg wrote
>>> Summary: With U-Boot and kernels <3.16 the drives work, even without jumper.
>>> I wonder if there is a way to get the drives working with up to date kernels.
>>> This would have the benefit of a.) no need to set jumpers and b.) getting
>>> bigger/newer drives like the WD30EFRX to work which probably do not have a
>>> downgrade-jumper.
>>
> 
> I forgot to mention the main benefit: Without the "downgrade-jumper" the drives are able to run at SATA-2 speed (the 88SE6121 is a SATA-2 controller). At least with kernel 2.6.x (ahci module) one can see the ST3500418AS running at 3Gbps:
> 
> [  151.957573] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  151.958713] ata1.00: ATA-8: ST3500418AS, CC38, max UDMA/133
> [  151.958726] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
> [  151.960062] ata1.00: configured for UDMA/133
> [  151.960397] scsi 0:0:0:0: Direct-Access     ATA      ST3500418AS      CC38 PQ: 0 ANSI: 5
> 
> And with kernel 2.6.x even the SATA-3 WD30EFRX runs at 3Gbps as well (no jumper, no kernel option) and has full 3TB accessible:
> 
> [  100.497589] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  100.498145] ata1.00: HPA detected: current 5860531055, native 5860533168
> [  100.498165] ata1.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133
> [  100.498177] ata1.00: 5860531055 sectors, multi 0: LBA48 NCQ (depth 0/32)
> [  100.498853] ata1.00: configured for UDMA/133
> [  100.499187] scsi 0:0:0:0: Direct-Access     ATA      WDC WD30EFRX-68E 80.0 PQ: 0 ANSI: 5
> 
> 
> 
>> Can you try with libata.force=nolpm ? A lot of old WD drives have broken LPM.
>>
> 
> libata.force=nolpm slightly changes the kernel log: the drive is basically detected (the model name and drive geometry show up), but in the end it fails:
> 
> [   64.796687] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

The max 3gbps speed of the adapter is being detected/negotiated as can be
seen here.

> [   69.857963] ata3.00: qc timeout after 5000 msecs (cmd 0xec)
> [   69.863648] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   70.184453] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   70.191202] ata3.00: FORCE: horkage modified (nolpm)
> [   70.196248] ata3.00: LPM support broken, forcing max_power
> [   70.204387] ata3.00: HPA detected: current 5860531055, native 5860533168
> [   70.211203] ata3.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133

So this means that after forcing max power (nolpm), IDENTIFY works.

> [   70.218000] ata3.00: 5860531055 sectors, multi 0: LBA48 NCQ (depth 0/32)
> [   80.354002] ata3.00: qc timeout after 10000 msecs (cmd 0xec)
> [   80.359772] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [   80.365924] ata3.00: revalidation failed (errno=-5)

But then fails again here on a timeout, so the drive seems to be stuck
again... Given that this drive has HPA, can you try this patch:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 36c1aca310e9..27ccb765e464 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3985,6 +3985,7 @@ static const struct ata_blacklist_entry
ata_device_blacklist [] = {
        { "HDS724040KLSA80",    "KFAOA20N",     ATA_HORKAGE_BROKEN_HPA },
        { "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
        { "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_HORKAGE_BROKEN_HPA },
+       { "WDC WD30EFRX-68EUZN0", NULL, ATA_HORKAGE_BROKEN_HPA |
ATA_HORKAGE_NOLPM},
        { "MAXTOR 6L080L4",     "A93.0500",     ATA_HORKAGE_BROKEN_HPA },

        /* this one allows HPA unlocking but fails IOs on the area */

Just to check if it is another drive with a broken HPA. You can also try
with libata.ignore_hpa=0 together with nolpm option.

> [   80.370851] ata3: limiting SATA link speed to 1.5 Gbps
> [   80.376037] ata3.00: limiting speed to UDMA/133:PIO3
> [   80.696310] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [  111.586110] ata3.00: qc timeout after 30000 msecs (cmd 0xec)
> [  111.591884] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [  111.598028] ata3.00: revalidation failed (errno=-5)
> [  111.602961] ata3.00: disable device
> 
> Without libata.force=nolpm the model name does not show up, only "failed to IDENTIFY":
> 
> [  121.877545] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  127.063106] ata3.00: qc timeout after 5000 msecs (cmd 0xec)
> [  127.068801] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [  127.389453] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [  137.558996] ata3.00: qc timeout after 10000 msecs (cmd 0xec)
> [  137.564772] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [  137.570930] ata3: limiting SATA link speed to 1.5 Gbps
> [  137.889346] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> 
> 
> I also checked with another drive, a WD5000AADS. With this drive the "nolpm" flag does not change the kernel log at all.
> 
>> Also, did you try with the pata_marvell driver instead of AHCI driver ?
>>
> 
> Yes, but no disks show up. Please see https://marc.info/?l=linux-ide&m=167474771722812&w=2
> 
> Hajo
> 
> 

-- 
Damien Le Moal
Western Digital Research

