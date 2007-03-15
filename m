From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Fri, 16 Mar 2007 01:32:51 +0800
Message-ID: <45F98343.3060703@tw.ibm.com>
References: <45F873AC.6010204@gmail.com> <45F8C3E1.3080805@tw.ibm.com> <45F9460E.7020701@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:57988 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbXCORdL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 13:33:11 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2FHXAdN025922
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 13:33:10 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2FHXA4g062168
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 11:33:10 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2FHXAX5001992
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 11:33:10 -0600
In-Reply-To: <45F9460E.7020701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

YUP wrote:
> Hi Albert,
> 
> Thanks for quick answer.
> 
>>> [   35.082749] Uniform CD-ROM driver Revision: 3.20
>>> [   35.083141] sr 0:0:0:0: Attached scsi CD-ROM sr0
>>> [   35.092019] sr1: scsi3-mmc drive: 231x/52x cd/rw xa/form2 cdda tray
>>> [   35.092385] sr 0:0:1:0: Attached scsi CD-ROM sr1
>>> [   35.099265] sr 0:0:0:0: Attached scsi generic sg0 type 5
>>> [   35.099296] sr 0:0:1:0: Attached scsi generic sg1 type 5
>>
>>
>> Both your HP DVD Writer 200j and AOpen 56X/AKH are detected correctly
>> as sr0 and sr1. (It might be /dev/scd0 and /dev/scd1 on your distro.)
>>
>> However, there are problems with the AOpen "E-IDE    CD-ROM 56X/AKH"
>> drive. It reports the strange "231x" speed and later timeout on INQUIRY.
> 
> 
> I've seen that, but! I have no devices like /dev/sr0 and /dev/sr1 nor
> /dev/scd0 and /dev/scd1.
> 
> 

Strange. But this is another problem. Let's focused on the "qc timeout"
problem first.

>>
>> Could you please replace the cable and/or connect the AOpen drive to
>> another PATA port and see if it makes the "qc timeout" go away, thanks.
> 
> 
> I tried replace the cable with no result. The second experiment was
> successful: I plugged DVD and cdrom separately to the different ports
> (before they were on one cable as master and slave), this time dvd runs
> well, but I can't see cdrom. I also tried play with master-slave,
> different combination with different cables etc. Result is the same -
> dvd is OK, cdrom causes annoying messages.  Maybe something is wrong
> with my cdrom. But under windows  everything works fine... And with
> 2.6.18 kernel everything was fine.
> 
> Yarema
> 
> Here is my dmesg:
> 
<snip>
> [   34.252968] libata version 2.00 loaded.
> [   34.255515] ata_piix 0000:00:1f.1: version 2.00ac7
> [   34.255556] PCI: Setting latency timer of device 0000:00:1f.1 to 64
> [   34.255697] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000
> irq 14
> [   34.255756] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008
> irq 15
> [   34.255777] scsi0 : ata_piix
> [   34.572543] ata1.00: ATAPI, max UDMA/33
> [   34.736223] ata1.00: configured for UDMA/33
> [   34.736252] scsi1 : ata_piix
> [   34.894233] scsi 0:0:0:0: CD-ROM            HP       DVD Writer 200j
>  1.36 PQ: 0 ANSI: 5
> [   34.900160] pata_pdc2027x 0000:02:01.0: version 0.74-ac5
> [   34.999368] pata_pdc2027x 0000:02:01.0: PLL input clock 16550 kHz
> [   35.029543] ata3: PATA max UDMA/133 cmd 0xE08617C0 ctl 0xE0861FDA
> bmdma 0xE0861000 irq 21
> [   35.029600] ata4: PATA max UDMA/133 cmd 0xE08615C0 ctl 0xE0861DDA
> bmdma 0xE0861008 irq 21
> [   35.029617] scsi2 : pata_pdc2027x
> [   35.048373] sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda
> tray
> [   35.048383] Uniform CD-ROM driver Revision: 3.20
> [   35.048479] sr 0:0:0:0: Attached scsi CD-ROM sr0
> [   35.055422] sr 0:0:0:0: Attached scsi generic sg0 type 5
> [   35.191725] ata3.00: ATA-7, max UDMA/100, 234493056 sectors: LBA48
> [   35.191732] ata3.00: ata3: dev 0 multi count 16
> [   35.199693] ata3.01: ATA-7, max UDMA/133, 320173056 sectors: LBA48
> [   35.199697] ata3.01: ata3: dev 1 multi count 16
> [   35.207679] ata3.00: Host Protected Area detected:
> [   35.207681]  current size: 234493056 sectors (120 GB)
> [   35.207683]  native size: 274965953385600 sectors (140782568 GB)
> [   35.207687] ata3.00: configured for UDMA/100
> [   35.215664] ata3.01: configured for UDMA/133
> [   35.215694] scsi3 : pata_pdc2027x
> [   35.382452] ATA: abnormal status 0x7F on port 0xE08615DF
> [   35.393825] ATA: abnormal status 0x7F on port 0xE08615DF
> [   35.555096] ata4.01: ATAPI, max MWDMA2
> [   35.718854] ata4.01: configured for MWDMA2
> [   35.721044] scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG SP1203N
>  TL10 PQ: 0 ANSI: 5
> [   35.721824] scsi 2:0:0:0: Attached scsi generic sg1 type 0
> [   35.722015] scsi 2:0:1:0: Direct-Access     ATA      Maxtor 6Y160P0
>  YAR4 PQ: 0 ANSI: 5
> [   35.722742] scsi 2:0:1:0: Attached scsi generic sg2 type 0
> [   35.723427] scsi 3:0:1:0: CD-ROM            E-IDE    CD-ROM 56X/AKH
>  A80  PQ: 0 ANSI: 5
> [   35.732888] sr1: scsi3-mmc drive: 229x/52x cd/rw xa/form2 cdda tray
> [   35.733222] sr 3:0:1:0: Attached scsi CD-ROM sr1
> [   35.733642] sr 3:0:1:0: Attached scsi generic sg3 type 5

It was "sr1: scsi3-mmc drive: 231x/52x cd/rw xa/form2 cdda tray" and
this time it's "229x/52x"... Looks like one bit of data is changed.
Maybe signal interference?

<snip>

> [   65.749627] ata4.01: qc timeout (cmd 0xa0)
> [   65.749644] ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> frozen
> [   65.749656] ata4.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0
> cdb 0x12 data 254 in
> [   65.749658]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask
> 0x5 (timeout)
> [   72.739179] ata4: port is slow to respond, please be patient (Status
> 0xd8)
> [   95.720773] ata4: port failed to respond (30 secs, Status 0xd8)
> [   95.720785] ata4: soft resetting port
> [   95.887933] ATA: abnormal status 0x7F on port 0xE08615DF
> [   95.899315] ATA: abnormal status 0x7F on port 0xE08615DF
> [   96.060304] ata4.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> [   96.060311] ata4.01: revalidation failed (errno=-5)
> [   96.060321] ata4: failed to recover some devices, retrying in 5 secs
> [  101.056818] ata4: soft resetting port

I still have no clue what caused "qc timeout" here.

Could you please try:
1. Apply the attached HSM debug patch to mainline 2.6.20.3 kernel 
   and post the dmesg for debugging.
2. Turn off ATAPI DMA by adding one line of
 	{ "CD-ROM 56X/AKH", NULL,	ATA_HORKAGE_NODMA },
   to  ata_device_blacklist[] and see if it helps. 

Thanks.
--
albert

--- linux-2.6.20.3/drivers/ata/libata-core.c	2007-03-15 12:13:12.000000000 +0800
+++ linux-2.6.20.3-mod/drivers/ata/libata-core.c	2007-03-15 12:13:55.000000000 +0800
@@ -4371,8 +4371,9 @@ int ata_hsm_move(struct ata_port *ap, st
 	WARN_ON(in_wq != ata_hsm_ok_in_wq(ap, qc));
 
 fsm_start:
-	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state, status);
+	if (is_atapi_taskfile(&qc->tf))
+		printk(KERN_ERR "ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
+		       ap->id, qc->tf.protocol, ap->hsm_task_state, status);
 
 	switch (ap->hsm_task_state) {
 	case HSM_ST_FIRST:
@@ -5091,8 +5092,9 @@ inline unsigned int ata_host_intr (struc
 	struct ata_eh_info *ehi = &ap->eh_info;
 	u8 status, host_stat = 0;
 
-	VPRINTK("ata%u: protocol %d task_state %d\n",
-		ap->id, qc->tf.protocol, ap->hsm_task_state);
+	if (is_atapi_taskfile(&qc->tf))
+		printk(KERN_ERR "ata%u: protocol %d task_state %d\n",
+		       ap->id, qc->tf.protocol, ap->hsm_task_state);
 
 	/* Check whether we are expecting interrupt in this state */
 	switch (ap->hsm_task_state) {

