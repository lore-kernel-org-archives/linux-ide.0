From: Todd and Margo Chester <ToddAndMargo@verizon.net>
Subject: Re: no hotplugging support (FIXME)
Date: Tue, 24 Feb 2009 13:57:57 -0800
Message-ID: <49A46D65.1030008@verizon.net>
References: <Pine.LNX.4.10.10301040547120.421-100000@master.linux-ide.org>
 <499F171D.5020600@verizon.net> <499F52C8.90205@gmail.com>
 <49A0B1D8.10303@verizon.net> <49A0C8F5.30405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:58665 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbZBXW6X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Feb 2009 17:58:23 -0500
Received: from rn1.rent-a-nerd.local ([71.125.118.126])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFL00CE0BOLQRYV@vms173015.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Tue, 24 Feb 2009 15:57:58 -0600 (CST)
In-reply-to: <49A0C8F5.30405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
> Todd and Margo Chester wrote:
>> Robert Hancock wrote:
>>> Todd and Margo Chester wrote:
>>>> Hi Jeff,
>>>>
>>>> I am having a nasty problem with hot swapping a removable (not
>>>> eSATA) drive I use for backup on several servers.  It is reported
>>>> over on
>>>> http://bugs.centos.org/view.php?id=3391
>>>>
>>>> Trying to help me find a work around to the problem at
>>>> http://www.centos.org/modules/newbb/viewtopic.php?topic_id=18608&start=0#forumpost68783 
>>>>
>>>> Alan posted your ata_piix.c code at
>>>> http://centos.toracat.org/ajb/tmp/toddandmargo/ata_piix.c
>>>> He pointed out
>>>>
>>>> 1483 /* no hotplugging support (FIXME) */
>>>> 1484 if (!in_module_init)
>>>> 1485 return -ENODEV;
>>>>
>>>> What do you mean by the comment in line 1483?  Is there some
>>>> know issue with hot swapping SATA drives?
>>>
>>> If you're using the ata_piix driver then it means your motherboard is 
>>> not in AHCI mode, so hotplugging is not supported by either the 
>>> driver or controller. You have to enable AHCI for SATA hotplug to 
>>> work on Intel controllers.
>>>
>>
>> Hi Robers,
>>
>>    As far as I can tell, ACHI is turned on on my motherboard.
>> I have tried all variation in bios (one of them turns /dev/sdb
>> into /dev/hda).   Does not mean ACHI is working right.
>>
>>    Do you know of any reason why my kernel
>> (CentOS 5.2: 2.6.18-92.1.22.el5) would not support
>> (bugs, etc.) hotplugging?
>>
>>    Also, do you know of a utility that I can use to
>> ask ACHI what is has for me (give me a report)?
>>
>> Many thanks,
>> -T
> 
> If the device is in AHCI mode then the ata_piix driver won't load for it 
> - at least it won't in current kernels, I can't say for sure that it 
> won't in the CentOS 5 version.. You do need to get it using the ahci 
> driver instead of ata_piix or hotplug definitely won't work.
> 
> You can try changing the boot initrd to try to load the AHCI driver 
> instead by changing the scsi_hostadapter entry in /etc/modprobe.conf to 
> be ahci instead of ata_piix, then rebuilding the initrd or reinstalling 
> the kernel RPM. However, if the BIOS isn't set up properly for AHCI mode 
> to work, you'll have to either boot up in rescue mode and fix it, or 
> boot up from a different kernel entry in grub.
> 

Hi Robert,

I have

$ modprobe --dry-run -v ahci
insmod /lib/modules/2.6.18-92.1.22.el5/kernel/drivers/ata/ahci.ko

in my system.  Do I just use "modprobe" to install the module
and go edit /etc/modprobe.conf?

And, does the modprobe insertion stay permanent (survives a reboot)?

I am confused   :-[   Can you point me to a link that gives the
directions?

-T
