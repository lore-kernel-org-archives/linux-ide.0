From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: ata2.00: failed to set xfermode (err_mask=0x100),ata2.00: disabled,
 CD-ROM drive dead
Date: Mon, 29 Mar 2010 18:20:48 -0500
Message-ID: <4BB135D0.5060507@hardwarefreak.com>
References: <4B9EA02F.2070704@hardwarefreak.com> <4B9EC67A.3020201@gmail.com> <4B9ED027.30800@hardwarefreak.com> <4BAAB080.3010401@kernel.org> <4BAB2A94.8010001@hardwarefreak.com> <20100325215242.GA9785@localhost.localdomain> <4BAF9670.6010706@hardwarefreak.com> <4BAFB58C.5050702@gmail.com> <4BAFEA7A.50904@kernel.org> <4BAFEFA3.3090502@hardwarefreak.com> <4BAFF370.6090207@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:55254 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472Ab0C2XUu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Mar 2010 19:20:50 -0400
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 601CA6C3CE
	for <linux-ide@vger.kernel.org>; Mon, 29 Mar 2010 18:20:49 -0500 (CDT)
In-Reply-To: <4BAFF370.6090207@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo put forth on 3/28/2010 7:25 PM:
> On 03/29/2010 09:09 AM, Stan Hoeppner wrote:
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 4a28420..ca4a50a 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -3446,6 +3446,10 @@ static int ata_dev_set_mode(struct ata_device *dev)
>>>  				       "NOSETXFER but PATA detected - can't "
>>>  				       "skip SETXFER, might malfunction\n");
>>>  		err_mask = ata_dev_set_xfermode(dev);
>>> +		if (err_mask)
>>> +			ata_dev_printk(dev, KERN_WARNING, "SETXFER failed w/ %x\n",
>>> +				       err_mask);
>>> +		err_mask = 0;
>>>  	}
>>>
>>>  	if (err_mask & ~AC_ERR_DEV)
>>
>>
>> I'm still using 2.6.32.9.  Is it ok to apply this against 2.6.32.9?
> 
> Yeah, that part hasn't changed lately so it should be okay.

This patch seems to have done the trick Tejun.  Thank you.  Device mount and
read access seem to be slower than with the IDE driver.  But given how
little I use the CD-ROM drive this initial impression may not accurately
describe reality.  Here's relevant dmesg entries from the patched kernel:

scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
ata1: port disabled. ignoring.
ata2.00: ATAPI: Pioneer CD-ROM ATAPI Model DR-A24X  0102, E1.02, max MWDMA2
ata2.00: SETXFER failed w/ 100
ata2.00: configured for MWDMA2
scsi 1:0:0:0: CD-ROM            PIONEER  CD-ROM DR-A01S   1.02 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 20x/20x xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0

Thanks.

-- 
Stan
