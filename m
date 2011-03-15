From: Tejun Heo <tj@kernel.org>
Subject: Re: [Bugme-new] [Bug 31022] New: Kernel oops under
 dequeue_task_fair
Date: Tue, 15 Mar 2011 08:47:31 +0100
Message-ID: <20110315074731.GE8635@htj.dyndns.org>
References: <bug-31022-10286@https.bugzilla.kernel.org/>
 <20110314152504.bda4940b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34346 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab1COHrg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Mar 2011 03:47:36 -0400
Received: by fxm17 with SMTP id 17so288216fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 15 Mar 2011 00:47:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110314152504.bda4940b.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, sgunderson@bigfoot.com

Hello,

On Mon, Mar 14, 2011 at 03:25:04PM -0700, Andrew Morton wrote:
> The ata driver detected an error and the kernel immediately oopsed
> somewhere in the CPU scheduler.  I'd be suspecting a bug somewhere in a
> rarely-used ata/block codepath.

Eh, unlikely.  The path is frequently traveled (shared with probing
path) and I can't really think of anything which could affect
scheduler like that.  There's nothing really exotic there.

> On Sun, 13 Mar 2011 00:31:38 GMT
> > Under somewhat heavy load, I first had problems with eth0 going haywire:

Pretty please always attach full kernel log including the boot
messages when reporting a kernel bug.

> > [1041371.782410] e1000e 0000:04:00.0: eth0: Reset adapter
> > [1041415.765409] e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow
> > Control: None

So, eth0 is acting up.

> > I switched the cables, took out the module, renamed eth1 to eth0 and added
> > things back. But 15 minutes later or so, I got the following oops:
> > 
> > [1041979.906665] ata9.00: exception Emask 0x32 SAct 0x0 SErr 0x1000400 action
> > 0x6 frozen
> > [1041979.915101] ata9.00: irq_stat 0x18000000, host bus error, interface fatal
> > error

and then the ATA controller is reporting data corruption on the host
bus, not the ATA bus - that is, data is getting corrupted while being
transported between the memory and the controller.

> > [1041980.002432] BUG: unable to handle kernel NULL pointer dereference at
> > 0000000000000181
> > [1041980.003006] IP: [<ffffffff8102dd5c>] dequeue_task_fair+0x20/0x227

and then the system goes belly up in an unrelated code path.

Looks like malfunctioning hardware to me.  My first suggestion would
be trying a different PSU.

Thanks.

-- 
tejun
