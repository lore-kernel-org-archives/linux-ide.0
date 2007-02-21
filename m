From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Wed, 21 Feb 2007 17:13:32 +0100
Message-ID: <8d158e1f0702210813s637b13b1s675d899f26ab597@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <8d158e1f0702170236h51756aadh6539f5d782774764@mail.gmail.com>
	 <45DAD8DA.4000108@gmail.com>
	 <8d158e1f0702200405w6a0e817bx3d809540d28b843d@mail.gmail.com>
	 <8d158e1f0702201400w622bbcb2lc7711b5c8974bfcd@mail.gmail.com>
	 <45DBEB63.3010905@gmail.com>
	 <8d158e1f0702210447q4ee8526cke05a76f895ad824c@mail.gmail.com>
	 <45DC46DF.8030704@gmail.com>
	 <8d158e1f0702210725u2f7d8d54nc5036e496d51b9d0@mail.gmail.com>
	 <8d158e1f0702210736m43ebcbf0r6c50647f8ff92137@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:62628 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161321AbXBUQNl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 11:13:41 -0500
Received: by an-out-0708.google.com with SMTP id b33so608658ana
        for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 08:13:41 -0800 (PST)
In-Reply-To: <8d158e1f0702210736m43ebcbf0r6c50647f8ff92137@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

On 2/21/07, Patrick Ale <patrick.ale@gmail.com> wrote:

I think something snuffed it or is just playing a trick on me, look.

I detach the master disk and boot.

ata7: PATA max UDMA/133 cmd 0xf98a97c0 ctl 0xf98a9fda bmdma 0xf98a9000 irq 21
ata8: PATA max UDMA/133 cmd 0xf98a95c0 ctl 0xf98a9dda bmdma 0xf98a9008 irq 21
scsi6 : pata_pdc2027x
cx2388x v4l2 driver version 0.0.6 loaded
ata7: CLASSIFY: device 0 50:01 01:00:00
ata7: CLASSIFY: device 1 50:01 01:00:00
ata7.00: ATA-7: Maxtor 6Y160P0, YAR41BW0, max UDMA/133
ata7.00: 320173056 sectors, multi 16: LBA48
ata7.01: ATA-6: WDC WD1200JB-00DUA3, 75.13B75, max UDMA/100
ata7.01: 234441648 sectors, multi 16: LBA48
ata7.00: configured for UDMA/33
ata7.01: configured for UDMA/100
scsi7 : pata_pdc2027x
ata8: CLASSIFY: device 0 20:20 20:20:20
ata8: CLASSIFY: device 1 50:01 01:00:00
ATA: abnormal status 0x78 on port 0xf98a95df
ATA: abnormal status 0x78 on port 0xf98a95df
ata8.01: ATA-6: ST3120022A, 8.54, max UDMA/100
ata8.01: 234441648 sectors, multi 16: LBA48
ata8.01: configured for UDMA/100


Lookit!!! A seagate disk on the slave port!!

So, I halt the system, detach the slave and and attach the master.

pata_pdc2027x 0000:00:0f.0: version 0.74-ac5
ACPI: PCI Interrupt 0000:00:0f.0[A] -> GSI 19 (level, low) -> IRQ 19
pata_pdc2027x 0000:00:0f.0: PLL input clock 57326 kHz
ata3: PATA max UDMA/133 cmd 0xf88517c0 ctl 0xf8851fda bmdma 0xf8851000 irq 19
ata4: PATA max UDMA/133 cmd 0xf88515c0 ctl 0xf8851dda bmdma 0xf8851008 irq 19
scsi2 : pata_pdc2027x
input: PC Speaker as /class/input/input4
8139too Fast Ethernet driver 0.9.28
ata3: CLASSIFY: device 0 50:01 01:00:00
ata3: CLASSIFY: device 1 50:01 01:00:00
ata3.00: ATA-7: Maxtor 6Y160P0, YAR41BW0, max UDMA/133
ata3.00: 320173056 sectors, multi 16: LBA48
ata3.01: ATA-6: WDC WD1200JB-00DUA3, 75.13B75, max UDMA/100
ata3.01: 234441648 sectors, multi 16: LBA48
ata3.00: configured for UDMA/33
ata3.01: configured for UDMA/100
scsi3 : pata_pdc2027x
Linux video capture interface: v2.00
ata4: CLASSIFY: device 0 50:01 01:00:00
ata4: CLASSIFY: device 1 00:01 01:00:00
ata4.00: ATA-6: WDC WD1200JB-00EVA0, 15.05R15, max UDMA/100
ata4.00: 234441648 sectors, multi 16: LBA48
ata4.00: configured for UDMA/100


Ye gods! A Western Digital drive on the master port!
Please note how my ata busses change from ata7,ata8 to ata3,ata4 ,
this immediately solves my question how come my drive order mangles up
at times.

I tried to change the master/slave order aswell, so make the Seagate
master and the WD slave, no success, disks wont get detected.

Guess my only way out of this is to use both drives on seperate channels.

Unless there are patches I can try of course :)


Patrick
