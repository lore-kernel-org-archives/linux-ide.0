From: Matt Darcy <kernel-lists@projecthugo.co.uk>
Subject: Re: Sata_MV 2.6.15 release
Date: Mon, 28 Nov 2005 14:47:13 +0000
Message-ID: <438B1871.7040807@projecthugo.co.uk>
References: <438AD60E.8050200@projecthugo.co.uk> <438B1452.3030809@emc.com>
Reply-To: kernel-lists@projecthugo.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from beng-03.stn.ab2.ifl.net ([194.238.49.3]:3091 "EHLO [127.0.0.1]")
	by vger.kernel.org with ESMTP id S1750869AbVK1OrP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Nov 2005 09:47:15 -0500
In-Reply-To: <438B1452.3030809@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Ric Wheeler wrote:

>
>
> Matt Darcy wrote:
>
>> Hi all,
>>
>> I've been using the propritary sata_mv driver for some time with good 
>> stability and reasonable performance. It has been a pain though due 
>> to using it for software raid configuration, and the fact that it is 
>> a module that has to be loaded at boot time, plus I cannot use it in 
>> a kernel after 2.6.12.6
>>
>> I was delighted to see the inclusion and development of this driver 
>> in the 2.6.15 kernel. I decided to give this a try.
>>
>> I was pleased to note it worked straight out of the box - with regard 
>> to detecting the disks attatched and making them available for raid 
>> startup at boot.
>>
>> However I had problems using lvm2 with the meta devices, the driver 
>> actually hangs the system, and for some reason includes cdrom devices 
>> when trying to create a volume group (note the cdrom drives are IDE 
>> based, on a VIA chip - so I don't know why the sata driver probes 
>> them - or at least thats how it appears)
>>
>> I noted that the driver is maked as very experimental, and I would 
>> like to feed into this drivers testing and debugging, as to be honest 
>> the sooner this driver becomes stable and usable, the easier my life 
>> will be.
>>
>> the note at the header of the driver says to use this mailing list 
>> for development/bugs, however it does seem a little strange mailing 
>> linux-ide when sata is classed as SCSI in the kernel.
>>
>> Is this the correct mailing list to discuss/report bugs on ?
>>
>> If so, what information is needed to report bugs effectivly - each 
>> list normally has a set of pre-requs, distro/version/config/certain 
>> libs etc etc.
>>
>> Many thanks,
>>
>> Matt
>>
>>
>>
> This is the right list - IDE and S-ATA drives both use libata which 
> does a SCSI -> IDE translation so that they can look & behave mostly 
> like real SCSI drives.
>
> Jeff Garzik is the main libata guy & has recently posted a large 
> update to the Marvell driver.  Brett left my group at EMC, but it 
> still lurking on this list as well, so you might get some help from 
> him as well.  Hopefully we (EMC) will have a full time person assigned 
> to the Marvell driver in the near future, but that person will focus 
> mostly on the hardware that we have at hand.
>
> What you normally need to do for a bug report is to try and get a run 
> with the latest kernel.  Jeff uses git to roll the experimental fixes 
> into his "libata" development branch, you can have a look at his page 
> for information on how to use git, etc:
>
>    http://linux.yyz.us/git-howto.html
>
> He also has a s-ata status page at the same site:
>
>    http://linux.yyz.us/sata/sata-status.html
>
> If you can reproduce your bugs on this libata-dev kernel, you will 
> have the best response from people on this list.
>
> Good luck!
>
> ric
>
>
Hi Ric,

thanks for all the info, apologies on the double post, my mail client 
crashed in the middle of sending, and it looked like the mail did not 
get sent, however it looks like it did, but by then I had already re-sent.

I'll start looking at these changes now.

I assume these changes are post-2.6.15-rc2 applied

thanks,

Matt


