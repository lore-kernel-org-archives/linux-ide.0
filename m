From: Holger Macht <hmacht@suse.de>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Tue, 6 May 2008 11:26:53 +0200
Message-ID: <20080506092653.GB4378@homac>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac> <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:36487 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765557AbYEFJYs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 05:24:48 -0400
Content-Disposition: inline
In-Reply-To: <48201987.4020009@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Di 06. Mai - 17:40:39, Tejun Heo wrote:
> (cc'ing Holger Macht, copying whole body for him)
>
> Hello, guys.
>
> Matthew Garrett wrote:
>> On Tue, May 06, 2008 at 10:13:47AM +0200, Holger Macht wrote:
>>> On Mo 05. Mai - 23:33:57, Matthew Garrett wrote:
>>>> 48feb3c419508487becfb9ea3afcc54c3eac6d80 appears to flag a device as 
>
> That should be 233f112042d0b50170212dbff99c3b34b8773cd3, right?
>
>>>> detached if an acpi eject request is received. In 2.6.24 and earlier, an 
>>>> eject request merely sent an event to userland which could then cleanly 
>>>> unmount the device and let the user know when it was safe to remove the 
>>>> drive. Removing the device would then send another acpi request that 
>>>> triggered the actual hotplug and bus rescan.
>>> What second acpi request are you referring to?
>>
>> For bay devices, the sequence is an optional eject request (before 
>> removal, and not implemented on all hardware) followed by either a bus or 
>> device check request (after removal).
>>
>>>> This seems like a regression - it's no longer possible to ensure that a 
>>>> bay device is cleanly unmounted. Was this really the desired behaviour? 
>>> I'm thinking about his for several days now and looking for a proper
>>> solution how to ensure that userland has the possibility to cleanly
>>> unmount a device. But it's definitely no regression. Before...systems with
>>> a bay in a dock stations simply froze hard in certain circumstances. It
>>> was pure luck that it worked for one major kernel version or so.
>>
>> Ah. I think the issue here is that you're trying to treat bays in docks in 
>> the same way as internal bays. These should probably be different 
>> callbacks.

Right, another solution I'm thinking of is to just handle those bays in
the docks differently. Going back to the old bahaviour, thus letting full
control to userland about deleting a bay device.

For the dockstation case, we have to detach a bay on the dock
immediately. Otherwise userland might call into a dead interface. You can
differentiate already through the dock driver, having different callbacks
for "dock notification" and the acpi notification for the bay device.

>>
>>> The only sane way for me seems that userland has to be involved before
>>> actually triggering any event or removing any device. Something like
>>> "savely remove this piece of hardware".
>>
>> That's what the eject request is for.

No. The moment when the bay event is generated, the moment the user pushes
the lever on the bay, the user might immediately pull out the device,
letting no chance for cleaning up...There must be an event before the user
touches anything, to have the time to unmount etc. and then tell "now it's
save to remove the bay device". This would also solve the "there's no bay
event" case.

>>
>>> For this to archive, we would need another sysfs entry flagging a bay
>>> device as "on dock station", so that userland knows what to unmount/eject
>>> before a dock event. Userspace relying on the bay event on the device is
>>> not a proper solution. The device may have been gone before userland
>>> finishes his work, or as you mention, there's no bay event.
>>
>> Yes. The user can, of course, do bad things. That doesn't mean we should 
>> avoid the opportunity to cleanly unmount filesystems when the user doesn't 
>> behave pathologically.

Agreed.

>>
>>>> It should be noted that not all hardware sends the eject request at all 
>>>> (Thinkpads do, but Dell and HP laptops don't), so we can't depend on 
>>>> receiving this when dealing with a bay event.
>>> I don't think we depend on the event. If the device gets removed without
>>> an appropriate event, the behaviour should be the same as before. If not,
>>> that wasn't the intentional behaviour.
>>
>> What ought to be possible for dock devices is something like "Receive 
>> eject request, clean up anything that has to be done in kernel, allow 
>> userspace to intervene and tidy up its side of things, let userspace 
>> signal completion, complete the undocking sequence". For internal bays, we 
>> certainly shouldn't be detaching the device when all we've received is an 
>> eject request.

When the bay is inside the dock, it should be save to immediately remove
the device. Userspace is in control of sending the dock event whenever it
likes to, being able to unmount filesystems etc. before generating the
event. Userland just needs to know which bays are in the dock.

> The original change was from Holder Macht and IIRC it was to avoid machine 
> hard lock up on certain laptops which happens when libata EH goes out to 
> find out what happened when it receives bus/device check after removal.  
> Maybe what should be done instead is that eject request doesn't do anything 
> but tells acpid to unmount and delete the block device by echoing 1 to 
> sysfs delete node.

If that's acceptable, I'm ok with letting full control to userspace.

Regards,
	Holger

> Hmmm... It would be perfect if we can tell whether DEVICE/BUS CHECK is in 
> which direction (device coming or going away).
>
> Thanks.
>

