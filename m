From: Tejun Heo <tj@kernel.org>
Subject: Re: Laptop shock detection and harddisk protection
Date: Thu, 11 Sep 2008 18:34:46 +0200
Message-ID: <48C948A6.3080404@kernel.org>
References: <48C7FCEE.8060404@kernel.org> <41840b750809110908o54a61f55w7b1b9793abf55634@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50102 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbYIKQgV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Sep 2008 12:36:21 -0400
In-Reply-To: <41840b750809110908o54a61f55w7b1b9793abf55634@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>
Cc: Elias Oltmanns <eo@nebensachen.de>, Thomas Renninger <trenn@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Shem Multinymous.

Shem Multinymous wrote:
> Hi Tejun,
>> 1. How should the shock interface look like?  As we're gonna need
>>   userland daemon one way or the other, we can use the userland
>>   daemon to glue all the interfaces but it would be much better to
>>   have a unified interface.  Although there seem to be several
>>   different variants, they don't differ all that much and creating a
>>   new interface every time is painful.  I think we can get by with a
>>   sysfs interface with notification.
> 
> Using the input device interface for the accelerometer (as done by
> tp_smapi's hdaps + latest hdapsd) greatly reduces the number of
> accelerometer-related timer interrupts on tickless kernels, as
> measured by powertop. With syscall polling you have the kernal polling
> the hardware at ~50Hz and then the userspace hdapsd polling the kernel
> at ~50Hz. When they're out of phase so you can get up to 100
> interrupts/sec. With an input device you're always at 50Hz. The phase
> difference also induces a small extra delay in the shock handling
> response.

That reduction comes because input device supports poll and
sysfs_notify_event() does about the same thing.  The uesrland daemon
can just poll on a node and read data nodes when poll event on the
node triggeres.

>> 2. If we're gonna unify interface, how much can we unify the backend?
>>   Some devices are based on polling, others interrupt.  For polling,
>>   is it better to delegate the whole polling to userland or is it
>>   better to do some of it in kernel (tp_smapi seems to be doing
>>   this)?
> 
> The ThinkPad accelerometer needs to be polled at very regular
> intervals (max jitter on the order of 10ms), which sounds like a job
> for the kernel.

Yes, I agree.

> This is because in ThinkPads we actually have a 4-level pile:
> [hdapsd userspace] -> [hdaps kernel] -> [embedded controller] ->
> [accelerometer A2D]
> What the kernel polls is actually is the H8S embedded controller (EC)
> chip, which in turn does its own polling of the accelerometer A2D.
> Now, the EC has a tiny buffer and strange buffering semantics, and it
> has its own internal clock, so the software->EC polling should be very
> regular to minmize EC buffer overflows/underruns.

So, I think the whole polling should be implemented inside the kernel
and the kernel should notify userland when new data is available,
which is about what the current joystick implementation does and can
be achieved using sysfs_notify_event().

>> 3. What about the userland daemon?  It would be best to have a unified
>>   daemon which can handle all instead of one for hdaps and another
>>   for hp (and so on).  If we can unify the interface, this will be
>>   much easier.
> 
> Assuming the funky shock detection algorithms are done in userspace,
> we need two interfaces: one for the acceleration data (an input device
> works nicely) and one for "unload now" events.
> On HP, the kernel can trigger the "unload now" event directly. On
> ThinkPads, there's still the question of what the userspace shock
> detection daemon should do when it detects a shock: should it unloads
> the heads by itself, or trigger the generic "unload now" event and let
> someone else do the actual unloading.

Unloading heads will be simple.  Just echoing timeout in ms to sysfs
nodes, so I don't think it's a good idea to push out actual unloading
to another process especially as fork doesn't inherit mlockall.

On a related note, is there any plan to merge tp_smapi to mainline?
It seems you put a lot of work into it and I don't really see why it
should stay out of tree.

Thanks.

-- 
tejun
