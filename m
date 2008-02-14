From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: "ide=reverse" do we still need this?
Date: Thu, 14 Feb 2008 12:16:42 -0500
Message-ID: <47B4777A.70400@tmr.com>
References: <20080213001506.GA13933@kroah.com> <47B24AB3.3040009@keyaccess.nl> <20080213044436.GB10101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmr.com ([64.65.253.246]:39658 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbYBNRRf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 12:17:35 -0500
In-Reply-To: <20080213044436.GB10101@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Rene Herman <rene.herman@keyaccess.nl>, bzolnier@gmail.com, muli@il.ibm.com, jdmason@kudzu.us, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

Greg KH wrote:
> On Wed, Feb 13, 2008 at 02:41:07AM +0100, Rene Herman wrote:
>> On 13-02-08 01:15, Greg KH wrote:
>>
>>> I'm reworking the pci device list logic (we currently keep all PCI
>>> devices in 2 lists, which isn't the nicest, we should be able to get
>>> away with only 1 list.)
>>> The only bother I've found so far is the pci_get_device_reverse()
>>> function, it's used in 2 places, IDE and the calgary driver.
>>> I'm curious if we really still support the ide=reverse option?  It's a
>>> config option that I don't think the distros still enable (SuSE does
>>> not).  Is this still needed these days?
>>> In digging, we changed this option in 2.2.x from being called
>>> "pci=reverse" and no one else seems to miss it.
>>> Any thoughts?
>> While details escape me somewhat again at the monment, a few months ago I 
>> was playing around with a PCI Promise IDE controller and needed ide=reverse 
>> to save me from having to switch disks around to still have a bootable 
>> system.
>>
>> Or some such. Not too clear anymore, but I remember it saved the day.
> 
> You couldn't just change the boot disk in grub?
> 
> Or use an initramfs and /dev/disk/by-id/ to keep any future moves
> stable?
> 
There are any number of things you can do when the system is booted, but 
the only thing you can do when the system won't boot is use kernel boot 
options.

This is primarily useful for old systems running modern software, such 
as old PC redeployed to network, external device control, or system 
monitoring. Upgrading the BIOS is no longer going to happen, and 
upgrading the hardware isn't cost effective, but keeping old systems out 
of the landfill is ecologically and financially sound.

The option is a holdover from the past, but so arm some of my clients 
and their hardware. ;-)
And *my* hardware, I might add, I am as cheap as anyone.

-- 
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
