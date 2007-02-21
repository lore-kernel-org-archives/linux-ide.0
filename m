From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Wed, 21 Feb 2007 16:25:34 +0100
Message-ID: <8d158e1f0702210725u2f7d8d54nc5036e496d51b9d0@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>
	 <45D58270.4080909@tw.ibm.com>
	 <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>
	 <45DAD8DA.4000108@gmail.com>
	 <8d158e1f0702200405w6a0e817bx3d809540d28b843d@mail.gmail.com>
	 <8d158e1f0702201400w622bbcb2lc7711b5c8974bfcd@mail.gmail.com>
	 <45DBEB63.3010905@gmail.com>
	 <8d158e1f0702210447q4ee8526cke05a76f895ad824c@mail.gmail.com>
	 <45DC46DF.8030704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:34641 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161282AbXBUPZg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 10:25:36 -0500
Received: by wr-out-0506.google.com with SMTP id i21so2219664wra
        for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 07:25:35 -0800 (PST)
In-Reply-To: <45DC46DF.8030704@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

On 2/21/07, Tejun Heo <htejun@gmail.com> wrote:

> Sure.  Thanks.

Okay, done. :)

And here is the dmesg output for my pata_pdc207x driver.

pata_pdc2027x 0000:00:0f.0: version 0.74-ac5
ACPI: PCI Interrupt 0000:00:0f.0[A] -> GSI 19 (level, low) -> IRQ 21
pata_pdc2027x 0000:00:0f.0: PLL input clock 34020 kHz
ata7: PATA max UDMA/133 cmd 0xf98a17c0 ctl 0xf98a1fda bmdma 0xf98a1000 irq 21
ata8: PATA max UDMA/133 cmd 0xf98a15c0 ctl 0xf98a1dda bmdma 0xf98a1008 irq 21
scsi7 : pata_pdc2027x
cx2388x v4l2 driver version 0.0.6 loaded
ata7: CLASSIFY: device 0 50:01 01:00:00
ata7: CLASSIFY: device 1 50:01 01:00:00
ata7.00: ATA-7: Maxtor 6Y160P0, YAR41BW0, max UDMA/133
ata7.00: 320173056 sectors, multi 16: LBA48
ata7.01: ATA-6: WDC WD1200JB-00DUA3, 75.13B75, max UDMA/100
ata7.01: 234441648 sectors, multi 16: LBA48
ata7.00: configured for UDMA/33
ata7.01: configured for UDMA/100
scsi8 : pata_pdc2027x
scsi 4:0:0:0: Direct-Access     USB2.0   CardReader CF RW 0.0> PQ: 0 ANSI: 0
sd 4:0:0:0: Attached scsi removable disk sde
sd 4:0:0:0: Attached scsi generic sg4 type 0
usb-storage: device scan complete
ata8: CLASSIFY: device 0 50:00 aa:fe:3f
ata8: CLASSIFY: device 1 50:00 aa:10:00
scsi 7:0:0:0: Direct-Access     ATA      Maxtor 6Y160P0   YAR4 PQ: 0 ANSI: 5
SCSI device sdf: 320173056 512-byte hdwr sectors (163929 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sdf: 320173056 512-byte hdwr sectors (163929 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdf: sdf1
sd 7:0:0:0: Attached scsi disk sdf
sd 7:0:0:0: Attached scsi generic sg5 type 0
scsi 7:0:1:0: Direct-Access     ATA      WDC WD1200JB-00D 75.1 PQ: 0 ANSI: 5
SCSI device sdg: 234441648 512-byte hdwr sectors (120034 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sdg: 234441648 512-byte hdwr sectors (120034 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdg: sdg1
sd 7:0:1:0: Attached scsi disk sdg
sd 7:0:1:0: Attached scsi generic sg6 type 0


Patrick
