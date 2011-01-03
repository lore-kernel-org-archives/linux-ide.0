From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Adding runtime PM support to sata_mv driver
Date: Mon, 3 Jan 2011 10:15:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101031000200.2486-100000@iolanthe.rowland.org>
References: <20110103143947.GS18831@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44392 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755174Ab1ACPPm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 10:15:42 -0500
In-Reply-To: <20110103143947.GS18831@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Priyanka Gupta <ankaguptaca@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org

On Mon, 3 Jan 2011, Tejun Heo wrote:

> Hello,
> 
> On Sun, Jan 02, 2011 at 11:07:43PM -0600, Priyanka Gupta wrote:
> > Let me try and elaborate on what I am trying to achieve: I would like
> > to add a way to move the marvell sata controller to D3hot to save some
> > power.
> 
> Oh I see.  You wanna put the controller into sleep.  You'll have to
> implement EH actions for it and invoke EH to do it.  The problem is
> that for it to work in generic manner, the operations need to be
> synchronized with other accesses to the hardware and going through EH
> is the easiest way to achieve that.  Something like the following
> would work.

Are you talking about the usual SCSI error handler or something else 
specific to ATA drivers?

Runtime suspend should not occur unless all the child devices (i.e.,
the attached drives) are already suspended.  This means it is not
necessary to synchronize any operations, since there shouldn't be any
other accesses to the hardware going on.  Therefore there is no need to
use the error handler.

> On runtime suspend
> 
> * Tell EH to kick in and suspend the controller (and wait (or not)).
> 
> * EH kicks in.  Mark the port inactive so that further commands
>   processing won't happen (it would probably be nice if this is
>   something the PM framework can guarantee but I don't think it's done
>   that way, is it?)

Why must the port be marked inactive?  If any further commands need to
be processed then they should cause the controller to be resumed, at
which point the port will be active again.

> * EH skips all other EH actions and put the controller in sleep.

The PCI core already takes care of putting device into D3.  The EH 
doesn't need to do it.  And there shouldn't be any other EH actions 
pending.

> On runtime resume
> 
> * Tell EH to kick in and wake up the controller.

The PCI core already puts devices back into D0.

> * EH kicks in.  Powers up the controller and revalidates all the
>   attached devices.

At this point the attached devices should still be suspended.  
Presumably you would not want to revalidate them until their own 
runtime resumes occur.

> So, it's gonna take a bit more code than posted.

On the contrary, there should be almost no new code needed.  In fact,
calling pm_runtime_put_noidle() in the probe routine and
pm_runtime_get_noresume() in the remove routine should be almost good 
enough.

Alan Stern

