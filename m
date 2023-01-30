Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2B1C54EAA
	for <linux-ide@archiver.kernel.org>; Mon, 30 Jan 2023 13:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjA3Nkh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Jan 2023 08:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjA3Nkh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2023 08:40:37 -0500
Received: from mx.bauer-kirch.de (mx.bauer-kirch.de [87.230.111.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3E42F794
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 05:40:34 -0800 (PST)
Received: by mail.bauer-kirch.de with ESMTPSA id 1pMUOe-0003Yn-48
        authenticated id <420001312>
        (TLS1.2:ECDHE_RSA_SECP256R1__AES_128_GCM:128); Mon, 30 Jan 2023 14:40:32 +0100
Message-ID: <b4a515f6-e11c-756b-ff90-114836f919f9@noerenberg.de>
Date:   Mon, 30 Jan 2023 14:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Marvel 88SE6121 fails with SATA-2/3 HDDs
To:     linux-ide@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        risc4all@yahoo.com
References: <db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de>
 <930a0685-c741-110e-40c2-660754301e5a@opensource.wdc.com>
 <a248857e-991c-16d7-496c-9dc692186ead@noerenberg.de>
From:   Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
In-Reply-To: <a248857e-991c-16d7-496c-9dc692186ead@noerenberg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Am 26.01.2023 um 16:41 schrieb Hajo Noerenberg:

>>> [  209.134706] ata3: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000100 irq 39
>>> [  209.142214] ata4: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000180 irq 39
>>> [  209.149676] ata5: DUMMY
>>> [  209.469562] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> [  214.631228] ata3.00: qc timeout after 5000 msecs (cmd 0xec)
>>> [  214.636919] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>> [  214.957579] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>> [  225.127261] ata3.00: qc timeout after 10000 msecs (cmd 0xec)
>>> [  225.133030] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>> [  225.139184] ata3: limiting SATA link speed to 1.5 Gbps
>>> [  225.457616] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>>> [  257.127404] ata3.00: qc timeout after 30000 msecs (cmd 0xec)
>>> [  257.133181] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>> [  257.453758] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>>> [  257.773761] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [  257.781254] ata4.00: ATA-6: ST3250310NS, SN04, max UDMA/133
>>> [  257.786916] ata4.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
>>> [  257.796826] ata4.00: configured for UDMA/133
>>> [  257.801537] scsi 4:0:0:0: Direct-Access     ATA      ST3250310NS      SN04 PQ: 0 ANSI: 5
>>
>> Is this a SATA-1 drive (max 1.5gbps) ? port 3 does not work, but port 4 does...
>> Can you try swapping the drives connected to see if you end up with ata3 working
>> but not ata4 ?
>>
> 
> Swapping the drives slots does not change anything. ST3250310NS works, ST3500418AS not.
> 
> For my ST3250310NS, "hdparm -I" shows "Gen1 signaling speed (1.5Gb/s)" only. That's why I call it a SATA-1 drive. Oddly enough, a web search shows that it is sold as Sata-2 (https://www.seagate.com/docs/pdf/datasheet/disc/ds_barracuda_es.pdf).
> 

Update on this: For whatever reason, the ST3250310NS had a "downgrade to 1.5GB/s" jumper set on the back of the drive. I had stupidly  forgotten that HDD drives have jumpers (the last time I set a jumper on a hard drive was on old PATA drives decades ago). Thankfully someone added a hint to the bugzilla bug report (216094, comment #48).

If I remove the 1.5GB/s jumper, the ST3250310NS fails as well within Linux kernel. With U-Boot it works without jumper:

Reset SCSI
scanning bus for devices...
SATA link 0 timeout.
Target spinup took 0 ms.
SATA link 2 timeout.
AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
flags: 64bit ncq stag led pmp slum part
  Device 0: (1:0) Vendor: ATA Prod.: ST3250310NS Rev: SN04
            Type: Hard Disk
            Capacity: 238475.1 MB = 232.8 GB (488397168 x 512)

> I double checked with a FUJITSU MHZ2160BH laptop drive (hdparm shows Gen1=1.5Gb/s only), this works without problems. Other Gen2/Gen3 drives e.g. a WD3202ABYS or WD30EFRX do not work ("failed to IDENTIFY").
> 

I tried to jumper the WD30EFRX to 1.5GB/s but this does not change anything (still fails). But I'm unsure that the "downgrade jumper" even works at all for this relativly new drive. But with U-Boot it works:

Reset SCSI
scanning bus for devices...
Target spinup took 0 ms.
Target spinup took 0 ms.
SATA link 2 timeout.
AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
flags: 64bit ncq stag led pmp slum part
  Device 0: (0:0) Vendor: ATA Prod.: WDC WD30EFRX-68E Rev: 80.0
            Type: Hard Disk

I tested with another drive, a WD5000AADS: with 1.5Gb/s-jumper it works within Linux, without not. With U-Boot it works regardless of jumper setting.

I double-checked with libata.force=1.5GGbps, but this does not help:

[   49.191878] ata3: FORCE: PHY spd limit set to 1.5Gbps
[   49.197028] ata3: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000100 irq 39
[   49.204511] ata4: FORCE: PHY spd limit set to 1.5Gbps
[   49.209606] ata4: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000180 irq 39
[   49.217062] ata5: DUMMY
[   49.532303] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   54.753947] ata3.00: qc timeout after 5000 msecs (cmd 0xec)
[   54.759637] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   55.080266] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   65.249946] ata3.00: qc timeout after 10000 msecs (cmd 0xec)


Summary: With U-Boot and kernels <3.16 the drives work, even without jumper. I wonder if there is a way to get the drives working with up to date kernels. This would have the benefit of a.) no need to set jumpers and b.) getting bigger/newer drives like the WD30EFRX to work which probably do not have a downgrade-jumper.

Hajo
