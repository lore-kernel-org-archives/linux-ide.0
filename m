From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata question
Date: Wed, 02 Aug 2006 16:20:14 +0900
Message-ID: <44D0522E.6030905@gmail.com>
References: <1154445491.18593.111.camel@acme>  <44CF7447.300@gmail.com>	 <1154457583.4665.5.camel@shark.pacific>  <44CFA15C.8080109@gmail.com>	 <1154458981.4665.9.camel@shark.pacific>  <44CFA618.2090204@gmail.com> <1154502301.5691.23.camel@acme>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:18967 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751306AbWHBHUC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Aug 2006 03:20:02 -0400
Received: by py-out-1112.google.com with SMTP id t32so1567006pyc
        for <linux-ide@vger.kernel.org>; Wed, 02 Aug 2006 00:20:02 -0700 (PDT)
In-Reply-To: <1154502301.5691.23.camel@acme>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Oberholtzer <roger@opq.se>
Cc: linux-ide@vger.kernel.org

Roger Oberholtzer wrote:
> On Wed, 2006-08-02 at 04:06 +0900, Tejun Heo wrote: 
>> Roger Oberholtzer wrote:
>>> On Wed, 2006-08-02 at 03:45 +0900, Tejun Heo wrote:
>>>> Roger Oberholtzer wrote:
>>>>> On Wed, 2006-08-02 at 00:33 +0900, Tejun Heo wrote:
>>>>>> Roger Oberholtzer wrote:
>>>>>>> Should hotplug work with Intel Corporation 82801GB/GR/GH (ICH7
>>>>>>> Family) chipset? I am trying kernel 2.6.17.7
>>>> Ah.. I should have spotted this earlier.  2.6.17.7 doesn't contain 
>>>> updated EH and doesn't support any of new features including 
>>>> hot/warmplug.  Please try 2.6.18-rc3.
>>> OK. But I think there are issues with 2.6.18 generally. But I can try it
>>> to see if this makes this better.
>> If you're uncomfortable with -rcX, you can try libata-tj-stable patch. 
>> It contains most of new stuff.
>>
>> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060710.tar.bz2
> 
> Thanks for that. But it had no noticeable difference.

Hmmm... That's weird. 'echo - - - > /sys/class/scsi_host/xxx.../scan' 
didn't do the right thing?  Care to post dmesg?

> I looked in the bios on my system to see if I could set the SATA disks
> to AHCI mode. I did not see anything like that. I could select to do a
> manual config, in which case I could set things like LBA mode, 32-bit
> I/O (which defaults to off). So if hots wap require AHCI mode, I seem to
> be screwed. It is a phoenix bios for the supermicro computer.

The chipset might not support ahci mode.

> Maybe I can try a different SATA card instead of the stuff on the
> motherboard. What do you think is the best one re hots waping? Either
> PCI or PCI-X.

I primarily use sil3112/4, sil3124/32 and ahci for development.  So 
those tend to have better support for EH/hotplug stuff.

>>>>> I bet the driver does the right thing. The trick is knowing what that is
>>>>> supposed to be. And how to use the various commands on files in /sys at
>>>>> the correct time and in the correct order.
>>>> Really, it's not that complicated.
>>> Once you know what it is you need to do.
>> I tried hard to make things just work.  If you find things unnecessarily 
>> complicated, please let me know.
> 
> I have a system with an IDE disk with the OS that is fixed. I also have
> 4 hot swappable SATA disk bays. My use will involve changing the SATA
> disks to do an analysis of the data they contain. There will be 4 disks
> in an analysis set. I need to make it easy for the user to insert and
> remove disks. Rebooting each time is a bad alternative. So, if hot swap
> does not work, I will have to get warm swap working. I think part of the
> confusion I have is how to deal with disks that are mounted. So I need
> to get the steps well defined and make those that require user
> interaction as few as possible.

As far as libata is concerned, for warmplug, all you need to use are

   echo 1 > /sys/class/scsi_device/xxxx/device/delete

for removal, and for plugging

   echo - - - > /sys/class/scsi_host/xxxxx/scan

If you remove device before unmounting, the mounted fs will suffer from 
io errors and probably spit quite some error messages, so unmounting 
before is a good idea.

In general, ata_piix doesn't respond very well to runtime device 
addition mainly due to problems with port enable.  So, if you boot with 
empty slot and put new device in there and issue scan, it might or might 
not work, but ports which had a device attached on boot seem to always work.

On any 2.6.17 kernel, without new EH, none of hot/warm plugging works. 
Please double check you have the correct kernel.  Kernel messages are 
very different.

-- 
tejun
