From: Tejun Heo <tj@kernel.org>
Subject: Re: Adding runtime PM support to sata_mv driver
Date: Mon, 3 Jan 2011 16:31:34 +0100
Message-ID: <20110103153134.GW18831@htj.dyndns.org>
References: <20110103143947.GS18831@htj.dyndns.org>
 <Pine.LNX.4.44L0.1101031000200.2486-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35926 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab1ACPbj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 10:31:39 -0500
Received: by bwz15 with SMTP id 15so13787262bwz.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2011 07:31:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1101031000200.2486-100000@iolanthe.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Priyanka Gupta <ankaguptaca@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org

Hello, Alan.

On Mon, Jan 03, 2011 at 10:15:40AM -0500, Alan Stern wrote:
> > Oh I see.  You wanna put the controller into sleep.  You'll have to
> > implement EH actions for it and invoke EH to do it.  The problem is
> > that for it to work in generic manner, the operations need to be
> > synchronized with other accesses to the hardware and going through EH
> > is the easiest way to achieve that.  Something like the following
> > would work.
> 
> Are you talking about the usual SCSI error handler or something else 
> specific to ATA drivers?

I'm talking specifically about libata EH.

> Runtime suspend should not occur unless all the child devices (i.e.,
> the attached drives) are already suspended.  This means it is not
> necessary to synchronize any operations, since there shouldn't be any
> other accesses to the hardware going on.  Therefore there is no need to
> use the error handler.

Well, it's not that simple I'm afraid.  EH actions are asynchronous.
Even if all the downstream devices are suspended, PHY events can
happen any time and EH could be active.  Hmmm... a delta but it would
make more sense to put only the controller into hot sleep while
leaving the disk alone for rotating devices.

Also, on resume, as the controller was out, libata needs to do full
revalidation & reconfiguration.  There's no way to avoid EH.

> > * EH kicks in.  Mark the port inactive so that further commands
> >   processing won't happen (it would probably be nice if this is
> >   something the PM framework can guarantee but I don't think it's done
> >   that way, is it?)
> 
> Why must the port be marked inactive?  If any further commands need to
> be processed then they should cause the controller to be resumed, at
> which point the port will be active again.

Then, at least we would need to plug EH because commands aren't the
only intiation vector.

> > * EH skips all other EH actions and put the controller in sleep.
> 
> The PCI core already takes care of putting device into D3.  The EH 
> doesn't need to do it.  And there shouldn't be any other EH actions 
> pending.

So, it behaves differently from the usual suspend/resume?  We have
.suspend callback which puts the controller into D3.  Are you saying
for runtime PM that isn't necessary?  If so, wouldn't it be better to
unify behaviors between the two paths?

> > On runtime resume
> > 
> > * Tell EH to kick in and wake up the controller.
> 
> The PCI core already puts devices back into D0.

I still can't see how this would work without low level driver's help.
Who's gonna reconfigure the controller?  Or are controllers supposed
to maintain all configurations across D3(hot) sleep?

> > * EH kicks in.  Powers up the controller and revalidates all the
> >   attached devices.
> 
> At this point the attached devices should still be suspended.  
> Presumably you would not want to revalidate them until their own 
> runtime resumes occur.

Controller resume involves SATA bus resets.  As there can be multiple
devices per bus, you can't really divide things that neatly.  The
hardware isn't designed that way.

> > So, it's gonna take a bit more code than posted.
> 
> On the contrary, there should be almost no new code needed.  In fact,
> calling pm_runtime_put_noidle() in the probe routine and
> pm_runtime_get_noresume() in the remove routine should be almost good 
> enough.

Yeah, that would be nice.  I'm quite doubtful that would work as well
as you would expect it to tho.

Thanks.

-- 
tejun
