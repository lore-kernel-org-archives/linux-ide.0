From: Wes Newell <w.newell@verizon.net>
Subject: Re: Sis180 Jetway S755Max
Date: Tue, 30 Aug 2005 02:46:01 -0500
Message-ID: <43140EB9.6070902@verizon.net>
References: <m31x4pkhjb.fsf@anduin.mandrakesoft.com>	<4309A268.8090203@gmx.net>
 <430AA69A.1030307@verizon.net>	<430AD885.4080001@gmx.net>
 <430B63D1.6080108@verizon.net>	<m3fyt02y2t.fsf@anduin.mandrakesoft.com>
 <430B91C1.6040407@verizon.net> <430B9D0A.3060202@gmx.net>
 <430C11C7.8010308@verizon.net> <m3ek8cswgd.fsf@anduin.mandrakesoft.com>
 <43134CDF.2060106@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms048pub.verizon.net ([206.46.252.48]:16005 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751186AbVH3Hne (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Aug 2005 03:43:34 -0400
Received: from [192.168.0.2] ([71.244.20.31])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IM000LQ4YS729G6@vms048.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Tue, 30 Aug 2005 02:43:19 -0500 (CDT)
In-reply-to: <43134CDF.2060106@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnaud Patard <apatard@mandriva.com>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, "linux.ide" <linux-ide@vger.kernel.org>

Wes Newell wrote:

> Arnaud Patard wrote:
>
>> Wes Newell <w.newell@verizon.net> writes:
>>
>>  
>>
>>> Uwe Koziolek wrote:
>>>
>>>   
>>>
>>>> Hello Wes,
>>>>
>>>> i include for you a hothack for SiS180 into the sata5513, untested and
>>>> not pretty.
>>>>
>>>>     
>>>
>>> I tried this one first. It found the controller but errored out. here
>>> the relevant dmesg.
>>>
>>> Linux version 2.6.11-12mdkcustom (root@wes2.com) (gcc version 3.4.3
>>> (Mandrakelinux 10.2 3.4.3-7mdk)) #1 Tue Aug 23 23:58:08 CDT 2005
>>>
>>> SIS5513: IDE controller at PCI slot 0000:00:0c.0
>>> SIS5513: chipset revision 0
>>> SIS5513: IDE controller at PCI slot 0000:00:0c.0
>>> SIS5513: chipset revision 0
>>> SIS_IDE: probe of 0000:00:0c.0 failed with error -1
>>>   
>>
>> strange.. it's like the driver didn't recognize your chipset. According
>> to Jetway you have a 963L MuTIOL chipset which is afaik supported by the
>> driver.
>>  
>>
>
> Yes, it has the 963, but it ALSO has a real SIS180 on it. That's where 
> the problem lies, not with the 963. The 963 ide ports work fine with 
> the stock 5513 driver.
>
>> Could you try the sis5113.c I've attached ? It's the same one as the one
>> submitted by Uwe. I only added some silly printks.
>>
>>  
>>
>>>> additional i include the patch submitted by Arnaud Patard.
>>>>
>>>>     
>>>
>>> I'm not sure how or to which sata_sis.c file to apply this. I've got
>>> the one that came with the above kernel, and then I've got the one I
>>>   
>>
>>
>> the sata_sis from the 2.6.11-12mdk is the same as the one on kernel.org.
>>
>>  
>>
>>> downloaded from SIS that locks up the system when a pata drive is
>>> installed on the sis180. The first was simple enough, just replaced
>>> the original sis5513.c and recompiled the kernel. Don't know what to
>>> do with this one.
>>>
>>>   
>>>
>>>> If the last one works, it is the better solution, with chances to be
>>>> included into the kernel.
>>>>
>>>>     
>>>
>>> the sata_sis patch suppossed to add pata support. Can't tell from
>>> his message and the code is greek to me.
>>>   
>>
>>
>> I've configured the registers of the card when in pata mode but it's not
>> tested (I've only a SiS964L and SiS182 handy). I've only tested SATA
>> mode for SiS180 and SiS182.
>>  
>>
> Ok, I've give this a try first.
>
Didn't work. syslog output:
(with no drive attached)
Aug 30 02:22:34 wes2 kernel: libata version 1.10 loaded.
Aug 30 02:22:34 wes2 kernel: ata1: SATA max UDMA/133 cmd 0xDC00 ctl 
0xE002 bmdma 0xEC00 irq 19
Aug 30 02:22:34 wes2 kernel: ata2: SATA max UDMA/133 cmd 0xE400 ctl 
0xE802 bmdma 0xEC08 irq 19
Aug 30 02:22:34 wes2 kernel: ata1: no device found (phy stat c033c754)
Aug 30 02:22:34 wes2 kernel: scsi1 : sata_sis
Aug 30 02:22:35 wes2 kernel: ata2: no device found (phy stat c033c754)
Aug 30 02:22:35 wes2 kernel: scsi2 : sata_sis

(with  drive attached)
Aug 30 02:28:24 wes2 kernel: libata version 1.10 loaded.
Aug 30 02:28:24 wes2 kernel: ata1: SATA max UDMA/133 cmd 0xDC00 ctl 
0xE002 bmdma 0xEC00 irq 19
Aug 30 02:28:24 wes2 kernel: ata2: SATA max UDMA/133 cmd 0xE400 ctl 
0xE802 bmdma 0xEC08 irq 19
Aug 30 02:28:24 wes2 kernel: ata1: no device found (phy stat 00000000)
Aug 30 02:28:24 wes2 kernel: scsi2 : sata_sis
Aug 30 02:28:24 wes2 kernel: ata2: no device found (phy stat 00000000)
Aug 30 02:28:24 wes2 kernel: scsi3 : sata_sis


