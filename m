From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA "target mode" (or "Channel-to-Channel" comm mode)
Date: Tue, 03 Mar 2009 10:59:43 -0500
Message-ID: <49AD53EF.5060600@pobox.com>
References: <49AD34F4.8090008@rtr.ca> <49AD3BA5.3080603@pobox.com> <49AD409F.6040102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55568 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597AbZCCP7w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Mar 2009 10:59:52 -0500
In-Reply-To: <49AD409F.6040102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Mark Lord wrote:
>>> Guys,
>>>
>>> Within the next couple of weeks, I would like to submit patches
>>> for 2.6.30 for a simple form of what Marvell likes to call "target 
>>> mode",
>>> or C2C (channel-to-channel communications).
>>>
>>> This is for sata_mv.
>>>
>>> The question is, how to expose an interface to actually access it?
>>>
>>> Quick background on Marvell C2C:
>>>
>>> 1. C2C is only for Gen2 and Gen2e chipsets.
>>>
>>> 2. Requires a special SATA cross-over (simple twist) cable
>>>    between two SATA ports.  Ports can be on the same host
>>>    adaptor or on separate adaptors and/or machines.
>>>
>>> 3. Each sata_mv port can be either a (0) normal SATA host,
>>>    or (1) special SATA C2C initiator, or (2) a SATA target device.
>>>
>>> 4. A Gen2e mode (2) target can connect/communicate with either
>>>    a mode (0) host or a mode (1) initiator.  I'm not yet sure
>>>    whether an older Gen2 target can connect with a mode (0) host.
>>>
>>> 5. Mode (1) initiator appears to relax requirements such as waiting
>>>    for a device BUSY bit to clear etc., and is intended for simple
>>>    channel-to-channel communications.
>>>
>>> 6. A boot/module parameter seems to be the best way to enable
>>>    this feature, as otherwise libata wastes a lot of time and
>>>    effort probing for non-existant drives and slowing down
>>>    the boot process.
>>>
>>> 7. Initially, all that we want is a way to use two SATA ports
>>>    (on the same or different machines) as a simple byte-stream
>>>    communications channel, between a mode (1) inititiator
>>>    and a mode (2) target.  This is used in real-life as a high-speed
>>>    local comm channel between halves of split server machines.
>>>
>>> 8. Transparently emulating a SATA drive is possible on Gen2e chips
>>>    at least, and perhaps also on Gen2 chips.  This is not being
>>>    worked on at this time.
>>>
>>> 9. Using two ports in tandem, one mode (0) host and one mode (2) target,
>>>    one can construct a quite capable SATA capture/analyzer device
>>>    which could be inserted in between any other SATA host and device.
>>>    Quite useful, and something I intend to work on later this year.
>>>
>>> So, starting with simple stuff, I want to expose an interface for
>>> point 7 above.  The thought is to use netlink for this, on both ends.
>>>
>>> An alternative might be to tie it into the SCSI Target Framework (tgt).
>>> But that is more for full target device emulation than for simple comms.
>>> And SATA is not SCSI, so it could really restrict/prevent us from doing
>>> a full SATA emulation (eg. point 9) in the end.
>>>
>>> Time is short, so I'd like to spend it on something that Jeff would
>>> actually accept.  Thus this email.
>>
>> It depends on the task.
>>
>> The miscdev (i.e. chrdev) interface found in 
>> drivers/scsi/scsi_tgt_if.c of repo [1] seems pretty generic, simple, 
>> small and applicable to portions of the problem presented here...  The 
>> basic task in scsi_tgt_if's case is just shoveling packets to/from 
>> userspace.
> ..
> 
> Except it's rather SCSI specific, and the userspace frontend even more so.
> The code expects a SCSI command block, LUN, TAG, and other fields that
> a SATA FIS won't have.  Seems clumsy, particularly when we (in theory)
> are trying to decouple libata from SCSI.   But if that's the way,
> then I can clumsily wrap each FIS in a fake ATA_16 header or something.

The kernel bits are not terribly SCSI-specific.  I'd ignore the userland 
bits.

We just have to get the interface right.  Even if we "cp scsi_tgt_if.c 
ata_tgt_if.c" and then go from there, we should make an effort to create 
similar packet push/pull interfaces.

Creating something wildly different would be counterproductive.


>> SATA packet capture:  highly useful, but implies _copying_ the packets 
>> before passing them on to regular channels.  So, does this imply 
>> packets will be copied kernel->userspace->kernel ?  kernel->kernel?  
>> The interface will be vastly different in each case.
> ..
> 
> Absolutely, which is why I'm leaving that for (much) later,
> and looking for a simple (userspace) comms method to begin with,
> using the special (non-SATA compliant) "initiator" on one end,
> and a "target" on the other end.  This is different from the SATA 
> interceptor/emulator configurations.

I would just bang out an interface.  Userspace interfaces always wind up 
needing some tweaking.

	Jeff



