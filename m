From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: no hotplugging support (FIXME)
Date: Sat, 21 Feb 2009 22:15:35 -0600
Message-ID: <49A0D167.9060707@gmail.com>
References: <Pine.LNX.4.10.10301040547120.421-100000@master.linux-ide.org> <499F171D.5020600@verizon.net> <499F52C8.90205@gmail.com> <49A0B1D8.10303@verizon.net> <49A0C8F5.30405@gmail.com> <49A0CFFF.3050806@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:44490 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbZBVEPj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Feb 2009 23:15:39 -0500
Received: by gxk22 with SMTP id 22so4028445gxk.13
        for <linux-ide@vger.kernel.org>; Sat, 21 Feb 2009 20:15:38 -0800 (PST)
In-Reply-To: <49A0CFFF.3050806@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Todd and Margo Chester <ToddAndMargo@verizon.net>
Cc: linux-ide@vger.kernel.org

Todd and Margo Chester wrote:
> Robert Hancock wrote:
>> Todd and Margo Chester wrote:
>>> Robert Hancock wrote:
>>>> Todd and Margo Chester wrote:
>>>>> Hi Jeff,
>>>>>
>>>>> I am having a nasty problem with hot swapping a removable (not
>>>>> eSATA) drive I use for backup on several servers.  It is reported
>>>>> over on
>>>>> http://bugs.centos.org/view.php?id=3391
>>>>>
>>>>> Trying to help me find a work around to the problem at
>>>>> http://www.centos.org/modules/newbb/viewtopic.php?topic_id=18608&start=0#forumpost68783 
>>>>>
>>>>> Alan posted your ata_piix.c code at
>>>>> http://centos.toracat.org/ajb/tmp/toddandmargo/ata_piix.c
>>>>> He pointed out
>>>>>
>>>>> 1483 /* no hotplugging support (FIXME) */
>>>>> 1484 if (!in_module_init)
>>>>> 1485 return -ENODEV;
>>>>>
>>>>> What do you mean by the comment in line 1483?  Is there some
>>>>> know issue with hot swapping SATA drives?
>>>>
>>>> If you're using the ata_piix driver then it means your motherboard 
>>>> is not in AHCI mode, so hotplugging is not supported by either the 
>>>> driver or controller. You have to enable AHCI for SATA hotplug to 
>>>> work on Intel controllers.
>>>>
>>>
>>> Hi Robers,
>>>
>>>    As far as I can tell, ACHI is turned on on my motherboard.
>>> I have tried all variation in bios (one of them turns /dev/sdb
>>> into /dev/hda).   Does not mean ACHI is working right.
>>>
>>>    Do you know of any reason why my kernel
>>> (CentOS 5.2: 2.6.18-92.1.22.el5) would not support
>>> (bugs, etc.) hotplugging?
>>>
>>>    Also, do you know of a utility that I can use to
>>> ask ACHI what is has for me (give me a report)?
>>>
>>> Many thanks,
>>> -T
>>
>> If the device is in AHCI mode then the ata_piix driver won't load for 
>> it - at least it won't in current kernels, I can't say for sure that 
>> it won't in the CentOS 5 version.. You do need to get it using the 
>> ahci driver instead of ata_piix or hotplug definitely won't work.
>>
>> You can try changing the boot initrd to try to load the AHCI driver 
>> instead by changing the scsi_hostadapter entry in /etc/modprobe.conf 
>> to be ahci instead of ata_piix, then rebuilding the initrd or 
>> reinstalling the kernel RPM. However, if the BIOS isn't set up 
>> properly for AHCI mode to work, you'll have to either boot up in 
>> rescue mode and fix it, or boot up from a different kernel entry in grub.
> 
> Hi Robert,
> 
>    Thank you.  I take it there is no probe of the AHCI module.  Rats!
> 
> My /etc/modprobe.conf (BIOS: Enhanced SATA Mode):
> 
> alias scsi_hostadapter sata_sil
> alias eth1 e1000e
> alias scsi_hostadapter1 megaraid_mbox
> alias scsi_hostadapter2 ata_piix
> alias snd-card-0 snd-intel8x0
> options snd-card-0 index=0
> options snd-intel8x0 index=0
> remove snd-intel8x0 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; 
> }; /sbin/modprobe -r --ignore-remove snd-intel8x0

In CentOS 5 this file mainly gets set up by the installer. If you change 
your BIOS settings you'd have to change it manually and rebuild the 
initrd for the changes to take effect.

> 
> While fooling around with my BIOS, trying to see what happens
> in the various SATA modes, the one called "ACHI Compatibility mode"
> changed my removable drive from /dev/sdb to /dev/hda.  ("mount /dev/hda"
> still hangs for two minutes, then the kernel freezes.)

Yeah, compatbility mode likely isn't what you want. It likely sets up 
the controller for IDE mode.

Motherboard makers are sometimes pretty bad about labelling the settings 
properly. Often AHCI is labelled as RAID mode or something.

> 
> I am wondering if there is a clue here.  Does the ACHI module load
> drives as /dev/sd* or /dev/hd*?

It will be sd*

> 
> Many thanks,
> -T
> 
> p.s., just of curiosity, what would the ACHI module look
> like in my modprobe.conf?

You would change:

alias scsi_hostadapter2 ata_piix

to

alias scsi_hostadapter2 ahci
