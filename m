Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F210C05027
	for <linux-ide@archiver.kernel.org>; Thu, 26 Jan 2023 15:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjAZPmW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Jan 2023 10:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjAZPmV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2023 10:42:21 -0500
Received: from mx.bauer-kirch.de (mx.bauer-kirch.de [87.230.111.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3353B6812F
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2023 07:41:56 -0800 (PST)
Received: by mail.bauer-kirch.de with ESMTPSA id 1pL4Nu-0004Ej-6h
        authenticated id <420001312>
        (TLS1.2:ECDHE_RSA_SECP256R1__AES_128_GCM:128); Thu, 26 Jan 2023 16:41:54 +0100
Message-ID: <a248857e-991c-16d7-496c-9dc692186ead@noerenberg.de>
Date:   Thu, 26 Jan 2023 16:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Marvel 88SE6121 fails with SATA-2/3 HDDs
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de>
 <930a0685-c741-110e-40c2-660754301e5a@opensource.wdc.com>
From:   Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
In-Reply-To: <930a0685-c741-110e-40c2-660754301e5a@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Am 26.01.2023 um 01:34 schrieb Damien Le Moal:
> On 2023/01/25 22:23, Hajo Noerenberg wrote:
>>
>> Bug report for Seagate Blackarmor NAS440 with Marvel 88SE6121 controller (AHCI kernel module): Very old SATA-1 HDDs (mostly laptop HDDs in my tests) work flawlessly, SATA-2/3 consistently fail. Limiting SATA speed (libata.force=1.5G ...) does not help.
>>
>> [  208.992175] pcieport 0000:00:01.0: enabling device (0140 -> 0143)
>> [  209.007014] ahci 0000:01:00.0: Disabling your PATA port. Use the boot option 'ahci.marvell_enable=0' to avoid this.
> 
> See drivers/ata/ahci.c:
> 
> 	/* The AHCI driver can only drive the SATA ports, the PATA driver
>            can drive them all so if both drivers are selected make sure
>            AHCI stays out of the way */
> 
> Can you try the pata driver instead: pata_marvell (CONFIG_PATA_MARVELL).
> 

linux-6.2-rc5# rmmod ahci
linux-6.2-rc5# insmod ./drivers/ata/pata_marvell.ko 

[71690.890645] scsi host3: pata_marvell
[71690.901410] scsi host4: pata_marvell
[71690.906035] ata9: PATA max UDMA/100 cmd 0x10010 ctl 0x10020 bmdma 0x10000 irq 39
[71690.913584] ata10: PATA max UDMA/133 cmd 0x10018 ctl 0x10024 bmdma 0x10008 irq 39

linux-6.2-rc5# lspci -vv
01:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6111/6121 SATA II / PATA Controller (rev b2) (prog-if 8f [PCI native mode controller, supports both channels switched to ISA compatibility mode, supports bus mastering])
        Subsystem: Marvell Technology Group Ltd. 88SE6111/6121 1/2 port SATA II + 1 port PATA Controller
[...]
        Kernel driver in use: pata_marvell
        Kernel modules: ahci

But no disks show up.

I'm pretty sure I tried the pata_marvell driver with some older kernels last year and had no positive results, but I do not remember in detail.


>> [  209.017595] ahci 0000:01:00.0: controller can't do NCQ, turning off CAP_NCQ
>> [  209.024616] ahci 0000:01:00.0: controller can't do PMP, turning off CAP_PMP
>> [  209.031635] ahci 0000:01:00.0: masking port_map 0x7 -> 0x3
>> [  209.067304] ahci 0000:01:00.0: SSS flag set, parallel bus scan disabled
>> [  209.074078] ahci 0000:01:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x3 impl IDE mode
>> [  209.082187] ahci 0000:01:00.0: flags: 64bit stag led slum part
>> [  209.107629] scsi host3: ahci
>> [  209.117716] scsi host4: ahci
>> [  209.131433] scsi host5: ahci
>> [  209.134706] ata3: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000100 irq 39
>> [  209.142214] ata4: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000180 irq 39
>> [  209.149676] ata5: DUMMY
>> [  209.469562] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [  214.631228] ata3.00: qc timeout after 5000 msecs (cmd 0xec)
>> [  214.636919] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> [  214.957579] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [  225.127261] ata3.00: qc timeout after 10000 msecs (cmd 0xec)
>> [  225.133030] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> [  225.139184] ata3: limiting SATA link speed to 1.5 Gbps
>> [  225.457616] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [  257.127404] ata3.00: qc timeout after 30000 msecs (cmd 0xec)
>> [  257.133181] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> [  257.453758] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [  257.773761] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [  257.781254] ata4.00: ATA-6: ST3250310NS, SN04, max UDMA/133
>> [  257.786916] ata4.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
>> [  257.796826] ata4.00: configured for UDMA/133
>> [  257.801537] scsi 4:0:0:0: Direct-Access     ATA      ST3250310NS      SN04 PQ: 0 ANSI: 5
> 
> Is this a SATA-1 drive (max 1.5gbps) ? port 3 does not work, but port 4 does...
> Can you try swapping the drives connected to see if you end up with ata3 working
> but not ata4 ?
> 

Swapping the drives slots does not change anything. ST3250310NS works, ST3500418AS not.

For my ST3250310NS, "hdparm -I" shows "Gen1 signaling speed (1.5Gb/s)" only. That's why I call it a SATA-1 drive. Oddly enough, a web search shows that it is sold as Sata-2 (https://www.seagate.com/docs/pdf/datasheet/disc/ds_barracuda_es.pdf).

I double checked with a FUJITSU MHZ2160BH laptop drive (hdparm shows Gen1=1.5Gb/s only), this works without problems. Other Gen2/Gen3 drives e.g. a WD3202ABYS or WD30EFRX do not work ("failed to IDENTIFY").

I may need to summarize my observations more precisely: drives that advertise a speed higher than Gen1=1.5Gb/s ("hdparm -I") do not work with the 88SE6121 controller and Linux kernel ahci module. Limiting SATA speed (libata.force=1.5G ...) does not help.

I can't completely rule out that the problem is definitely something to do with the SATA speed. These are just the observations with the drives available to me.

Hajo
