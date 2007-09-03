From: John Sigler <linux.kernel@free.fr>
Subject: Re: hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete
 Error }
Date: Mon, 03 Sep 2007 15:17:42 +0200
Message-ID: <46DC0976.10003@free.fr>
References: <46D59ED2.4000900@free.fr> <46D9876F.1070405@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:49916 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbXICNSX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Sep 2007 09:18:23 -0400
In-Reply-To: <46D9876F.1070405@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Sergei Shtylyov wrote:

> John Sigler wrote:
> 
>> When my system boots, I get several set_drive_speed_status errors.
>> (Please see attached dmesg output.)
> 
>> Can someone explain what they mean? How do I get rid of them?
> 
>    IDE code attempts to autotune PIO mode and fails at that because your 
> device is too old (or its manufacturer was too lazy) to support ATA-2 
> (or EIDE from marketing PoV) is its full glory.

But the data sheet seems to state the drive supports PIO modes 1 and 2?

>> Is there something I need to set in the config? or something I should 
>> not have set?
> 
>    No, it just means that the IDE code is *too young* to support such 
> pre-EIDE devices. :-D

Wow! This is a device that was purchased only a few months ago...

>> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>> ide: Assuming 33MHz system bus speed for PIO modes; override with 
>> idebus=xx
>> VP_IDE: IDE controller at PCI slot 0000:00:07.1
>> VP_IDE: chipset revision 6
>> VP_IDE: not 100% native mode: will probe irqs later
>> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
>>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:pio, hdb:pio
>>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
>> Probing IDE interface ide0...
>> hda: PQI IDE DiskOnModule, ATA DISK drive
>> hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete 
>> Error }
>> hda: set_drive_speed_status: error=0x04 { DriveStatusError }
>> hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete 
>> Error }
>> hda: set_drive_speed_status: error=0x04 { DriveStatusError }
> 
>   That means that you've managed to find pre-EIDE/ATA hardware which 
> doesn't support setting arbitrary PIO modes. What's funny is that 
> recently being discussed here, so expect a patch RSN. :-)

In 2.6.23?

Regards.
