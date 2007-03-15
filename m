From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Thu, 15 Mar 2007 11:56:17 +0800
Message-ID: <45F8C3E1.3080805@tw.ibm.com>
References: <45F873AC.6010204@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:35948 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965044AbXCOD4Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 23:56:24 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2F3uNqs002090
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 23:56:23 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2F3uN1B068544
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 21:56:23 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2F3uMk4001058
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 21:56:22 -0600
In-Reply-To: <45F873AC.6010204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: linux-ide@vger.kernel.org

YUP wrote:
> Hello,
> 
> I have the folowing problem. I'm running kubuntu box with
> 2.6.20-10 kernel with ubuntu patches and my cdrom as well as dvd drive
> doesn't recognized at all. I've already reported this on kubuntu forum,
> but nobody can answer me. The link is here:
> http://kubuntuforums.net/forums/index.php?topic=3080227.0
> I also tried to compile generic kernels from kernel.org with the same
> result. Can anybody say what is going on with my hardware or kernel?
> Before 2.6.20 everything ran smoothly.
> 
> 
> My latest dmesg output:
> 
<snip>
> [   33.707293] SCSI subsystem initialized
> [   33.715511] libata version 2.00 loaded.
...
> [   33.926133] ata_piix 0000:00:1f.1: version 2.00ac7
> [   33.926178] PCI: Setting latency timer of device 0000:00:1f.1 to 64
> [   33.926324] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000
> irq 14
> [   33.926388] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008
> irq 15
> [   33.926412] scsi0 : ata_piix
> [   33.993985] FDC 0 is a post-1991 82077
> [   34.245729] ata1.00: ATAPI, max UDMA/33
> [   34.409478] ata1.01: ATAPI, max MWDMA2
> [   34.573238] ata1.00: configured for UDMA/33
> [   34.736993] ata1.01: configured for MWDMA2
> [   34.737023] scsi1 : ata_piix
> [   34.894993] scsi 0:0:0:0: CD-ROM            HP       DVD Writer 200j
>  1.36 PQ: 0 ANSI: 5
> [   34.896276] scsi 0:0:1:0: CD-ROM            E-IDE    CD-ROM 56X/AKH
>  A80  PQ: 0 ANSI: 5
> [   34.909780] tulip0:  MII transceiver #1 config 1000 status 786d
> advertising 05e1.
> [   34.917561] eth0: ADMtek Comet rev 17 at Port 0xb400,
> 00:04:5A:8A:55:7B, IRQ 21.
> [   34.917761] pata_pdc2027x 0000:02:01.0: version 0.74-ac5
> [   35.016968] pata_pdc2027x 0000:02:01.0: PLL input clock 16550 kHz
> [   35.051596] ata3: PATA max UDMA/133 cmd 0xE08297C0 ctl 0xE0829FDA
> bmdma 0xE0829000 irq 21
> [   35.051661] ata4: PATA max UDMA/133 cmd 0xE08295C0 ctl 0xE0829DDA
> bmdma 0xE0829008 irq 21
> [   35.051681] scsi2 : pata_pdc2027x
> [   35.082740] sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda
> tray
> [   35.082749] Uniform CD-ROM driver Revision: 3.20
> [   35.083141] sr 0:0:0:0: Attached scsi CD-ROM sr0
> [   35.092019] sr1: scsi3-mmc drive: 231x/52x cd/rw xa/form2 cdda tray
> [   35.092385] sr 0:0:1:0: Attached scsi CD-ROM sr1
> [   35.099265] sr 0:0:0:0: Attached scsi generic sg0 type 5
> [   35.099296] sr 0:0:1:0: Attached scsi generic sg1 type 5

Both your HP DVD Writer 200j and AOpen 56X/AKH are detected correctly
as sr0 and sr1. (It might be /dev/scd0 and /dev/scd1 on your distro.)

However, there are problems with the AOpen "E-IDE    CD-ROM 56X/AKH"
drive. It reports the strange "231x" speed and later timeout on INQUIRY.

<snip>

> [   65.095382] ata1.01: qc timeout (cmd 0xa0)
> [   65.095404] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> frozen
> [   65.095409] ata1.01: (BMDMA stat 0x65)
> [   65.095417] ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0
> cdb 0x12 data 254 in
> [   65.095419]          res 51/51:03:00:12:00/00:00:00:00:00/b0 Emask
> 0x5 (timeout)
> [   72.084934] ata1: port is slow to respond, please be patient (Status
> 0xd8)
> [   95.066527] ata1: port failed to respond (30 secs, Status 0xd8)
> [   95.066538] ata1: soft resetting port
> [   95.549849] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x1)
> [   95.549856] ata1.01: revalidation failed (errno=-5)
> [   95.549865] ata1: failed to recover some devices, retrying in 5 secs
> [  100.546369] ata1: soft resetting port
> [  101.193580] ata1.00: configured for UDMA/33
> [  101.357350] ata1.01: configured for MWDMA2
> [  101.357399] ata1: EH complete
> [  131.348286] ata1.01: qc timeout (cmd 0xa0)
> [  131.348308] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2

Could you please replace the cable and/or connect the AOpen drive to
another PATA port and see if it makes the "qc timeout" go away, thanks.

--
Albert

