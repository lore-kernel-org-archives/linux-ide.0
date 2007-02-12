From: Tejun Heo <htejun@gmail.com>
Subject: Re: pcim_enable_device BUGs for libata devices in 2.6.20-git6
Date: Mon, 12 Feb 2007 01:11:55 -0800
Message-ID: <45D02F5B.801@gmail.com>
References: <45CFB87F.9060802@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:50173 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964812AbXBLJXl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2007 04:23:41 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1761182wxd
        for <linux-ide@vger.kernel.org>; Mon, 12 Feb 2007 01:23:40 -0800 (PST)
In-Reply-To: <45CFB87F.9060802@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

[cc'ing Pavel, Hi!]

Robert Hancock wrote:
> I'm seeing BUGs like these on all libata-driven controllers when 
> suspending to disk on 2.6.20-git6:
> 
> sata_nv 0000:00:07.0: resuming
> BUG: at drivers/pci/pci.c:817 pcim_enable_device()
> 
> Call Trace:
>  [<ffffffff80337d21>] pcim_enable_device+0x8a/0xa5
>  [<ffffffff88099d18>] :libata:ata_pci_device_do_resume+0x20/0x59
>  [<ffffffff880bb731>] :sata_nv:nv_pci_device_resume+0x1d/0x100
>  [<ffffffff8039d2bf>] resume_device+0xcb/0x12c
>  [<ffffffff8039d3ac>] dpm_resume+0x8c/0xec
>  [<ffffffff8039d456>] device_resume+0x4a/0x5d
>  [<ffffffff802a0a33>] pm_suspend_disk+0x160/0x170
>  [<ffffffff8029f4b6>] enter_state+0x52/0x1da
>  [<ffffffff8029f69c>] state_store+0x5e/0x79
>  [<ffffffff802f2b20>] sysfs_write_file+0xe4/0x118
>  [<ffffffff80214b58>] vfs_write+0xce/0x177
>  [<ffffffff8021553e>] sys_write+0x45/0x6e
>  [<ffffffff8025711e>] system_call+0x7e/0x83
> 
> It looks like what's happening is that during the "freezing" stage, we 
> suspend and then resume the controllers. ata_pci_device_do_suspend only 
> calls pci_disable_device if the event is PM_EVENT_SUSPEND but 
> ata_pci_device_do_resume calls pcim_enable_device unconditionally. If 
> the event was something else, then pcim_enable_device complains because 
> the device was previously enabled and never disabled.
> 
> Not sure what the best way to fix this is?

I think what should happen is either one of the followings.

1. Don't restore power state and re-enable PCI device on resume from 
freeze just as we don't do the opposite when freezing.

2. Unconditionally disable and power down PCI device on suspend whether 
it's freeze or not.

#2 would be simpler but I'm a bit worried about it.  There might be 
controllers which choke after such sequence (save state, disable, power 
down, no actual power removal, power on, restore state, re-enable).

#1 can be easily done by taking a look at the current device power state 
(gendev->power.power_state).  The problem is that no one in 
suspend/resume path seems to be setting that variable except for runtime 
suspend/resume stuff which is scheduled to be removed, right?  Pavel, is 
there any reason why suspend/resume paths don't set 
dev->power.power_state?  Is the field going away together with new 
libata?  Or am I just confused about it.

Thanks.

-- 
tejun

