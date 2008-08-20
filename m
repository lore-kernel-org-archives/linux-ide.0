From: Steven Gill <smgill75@verizon.net>
Subject: Re: sata_mv (NOT!)
Date: Wed, 20 Aug 2008 01:20:23 -0400
Message-ID: <48ABA997.1050109@verizon.net>
References: <48A0C170.2000803@verizon.net> <48A307D3.2000905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:40594 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYHTFUd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Aug 2008 01:20:33 -0400
Received: from vm.thebtbgroup.com ([72.78.111.7])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K5V00EE2W60AND8@vms046.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Wed, 20 Aug 2008 00:20:24 -0500 (CDT)
In-reply-to: <48A307D3.2000905@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Sorry for the mistake there.  I realized I was using a non-mainline 
driver to get PATA to work, but decided to move to a SATA DVD burner.  
When inserting a disk into the drive (when hooked to the Marvell 6145), 
I get the following:

ata10.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.00: cmd a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
         cdb 4a 01 00 00 10 00 00 00  08 00 00 00 00 00 00 00
         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata10.00: status: { DRDY }
ata10: hard resetting link
ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata10.00: configured for UDMA/100
ata10: EH complete
ata10.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata10.00: cmd a0/00:00:00:02:00/00:00:00:00:00/a0 tag 0 pio 16388 in
         cdb 51 00 00 00 00 00 00 00  02 00 00 00 00 00 00 00
         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata10.00: status: { DRDY }
ata10: hard resetting link
ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

I am currently running 2.26.2

I was able to sucessfully burn a CD when connecting this drive to the 
ICH9 controller sata port, but could not burn a dual layer dvd (There 
was a similar reset message)

Aug 19 22:05:18 [kernel] warning: `growisofs' uses deprecated v2 
capabilities in a way that may be insecure.
Aug 19 22:06:21 [kernel] ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x6 frozen
Aug 19 22:06:21 [kernel] ata5.00: cmd 
a0/01:00:00:00:80/00:00:00:00:00/a0 tag 0 dma 32768 out
Aug 19 22:06:21 [kernel]          cdb 2a 00 00 00 00 00 00 00  10 00 00 
00 00 00 00 00
Aug 19 22:06:21 [kernel]          res 
40/00:03:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Aug 19 22:06:21 [kernel] ata5.00: status: { DRDY }
Aug 19 22:06:21 [kernel] ata5: hard resetting link
Aug 19 22:06:21 [kernel] ata5: SATA link up 1.5 Gbps (SStatus 113 
SControl 300)

Steve

Mark Lord wrote:
> Steven Gill wrote:
>> Hi List,
>>
>> I am having some issues getting my Marvell 6145 working on my Asus 
>> P5E ws pro motherboard working.  I am using a 3rd party patch to get 
>> the pata port working, but have not had success with my e-sata ports 
>> (on the board the 6145 drives 2 sata and 2 e-sata ports.  There are 
>> another 6 sata ports driven by the onboard intel ich9).  When 
>> checking dmesg output, I see this:
>>
>> ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
>> PCI: Setting latency timer of device 0000:02:00.0 to 64
>> Marvell (S)ATA Controller is found, using IRQ 16.
>> Interrupt Error: 0x40000000 orgIntStatus: 0x40000001 completeSlot=0x1.
>>
>> I am willing to help debug any issues, test patches, etc, but most 
>> importantly wanted to report the issue.  I know this is labelled as 
>> "highly experimental", but again, wanted to offer assistance in testing.
> ..
>
> Wrong driver.  sata_mv does *NOT* drive the 6145 chip.
> Rather, that particular chip emulates AHCI, and uses the ahci driver.
>
> -ml
>

