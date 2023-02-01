Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BB8C38142
	for <linux-ide@archiver.kernel.org>; Wed,  1 Feb 2023 10:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjBAKCV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Feb 2023 05:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjBAKCU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2023 05:02:20 -0500
Received: from mx.bauer-kirch.de (mx.bauer-kirch.de [87.230.111.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D184A211
        for <linux-ide@vger.kernel.org>; Wed,  1 Feb 2023 02:02:18 -0800 (PST)
Received: by mail.bauer-kirch.de with ESMTPSA id 1pN9wW-000883-DC
        authenticated id <420001312>
        (TLS1.2:ECDHE_RSA_SECP256R1__AES_128_GCM:128); Wed, 01 Feb 2023 11:02:16 +0100
Message-ID: <53372f11-1d97-5310-32e7-6368a653115f@noerenberg.de>
Date:   Wed, 1 Feb 2023 11:02:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Marvel 88SE6121 fails with SATA-2/3 HDDs
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, risc4all@yahoo.com
References: <db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de>
 <930a0685-c741-110e-40c2-660754301e5a@opensource.wdc.com>
 <a248857e-991c-16d7-496c-9dc692186ead@noerenberg.de>
 <b4a515f6-e11c-756b-ff90-114836f919f9@noerenberg.de>
 <341397a1-9da5-466d-a738-cad79e8d2390@opensource.wdc.com>
From:   Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
In-Reply-To: <341397a1-9da5-466d-a738-cad79e8d2390@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Am 31.01.2023 um 03:34 schrieb Damien Le Moal:
> On 1/30/23 22:40, Hajo Noerenberg wrote
>> Summary: With U-Boot and kernels <3.16 the drives work, even without jumper.
>> I wonder if there is a way to get the drives working with up to date kernels.
>> This would have the benefit of a.) no need to set jumpers and b.) getting
>> bigger/newer drives like the WD30EFRX to work which probably do not have a
>> downgrade-jumper.
> 

I forgot to mention the main benefit: Without the "downgrade-jumper" the drives are able to run at SATA-2 speed (the 88SE6121 is a SATA-2 controller). At least with kernel 2.6.x (ahci module) one can see the ST3500418AS running at 3Gbps:

[  151.957573] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  151.958713] ata1.00: ATA-8: ST3500418AS, CC38, max UDMA/133
[  151.958726] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[  151.960062] ata1.00: configured for UDMA/133
[  151.960397] scsi 0:0:0:0: Direct-Access     ATA      ST3500418AS      CC38 PQ: 0 ANSI: 5

And with kernel 2.6.x even the SATA-3 WD30EFRX runs at 3Gbps as well (no jumper, no kernel option) and has full 3TB accessible:

[  100.497589] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  100.498145] ata1.00: HPA detected: current 5860531055, native 5860533168
[  100.498165] ata1.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133
[  100.498177] ata1.00: 5860531055 sectors, multi 0: LBA48 NCQ (depth 0/32)
[  100.498853] ata1.00: configured for UDMA/133
[  100.499187] scsi 0:0:0:0: Direct-Access     ATA      WDC WD30EFRX-68E 80.0 PQ: 0 ANSI: 5



> Can you try with libata.force=nolpm ? A lot of old WD drives have broken LPM.
> 

libata.force=nolpm slightly changes the kernel log: the drive is basically detected (the model name and drive geometry show up), but in the end it fails:

[   64.796687] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   69.857963] ata3.00: qc timeout after 5000 msecs (cmd 0xec)
[   69.863648] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   70.184453] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   70.191202] ata3.00: FORCE: horkage modified (nolpm)
[   70.196248] ata3.00: LPM support broken, forcing max_power
[   70.204387] ata3.00: HPA detected: current 5860531055, native 5860533168
[   70.211203] ata3.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133
[   70.218000] ata3.00: 5860531055 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   80.354002] ata3.00: qc timeout after 10000 msecs (cmd 0xec)
[   80.359772] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   80.365924] ata3.00: revalidation failed (errno=-5)
[   80.370851] ata3: limiting SATA link speed to 1.5 Gbps
[   80.376037] ata3.00: limiting speed to UDMA/133:PIO3
[   80.696310] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  111.586110] ata3.00: qc timeout after 30000 msecs (cmd 0xec)
[  111.591884] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  111.598028] ata3.00: revalidation failed (errno=-5)
[  111.602961] ata3.00: disable device

Without libata.force=nolpm the model name does not show up, only "failed to IDENTIFY":

[  121.877545] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  127.063106] ata3.00: qc timeout after 5000 msecs (cmd 0xec)
[  127.068801] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  127.389453] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  137.558996] ata3.00: qc timeout after 10000 msecs (cmd 0xec)
[  137.564772] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  137.570930] ata3: limiting SATA link speed to 1.5 Gbps
[  137.889346] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)


I also checked with another drive, a WD5000AADS. With this drive the "nolpm" flag does not change the kernel log at all.

> Also, did you try with the pata_marvell driver instead of AHCI driver ?
> 

Yes, but no disks show up. Please see https://marc.info/?l=linux-ide&m=167474771722812&w=2

Hajo


