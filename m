From: George Georgalis <george@galis.org>
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
Date: Sun, 27 Jun 2004 22:12:53 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040628021253.GA30798@trot.local>
References: <20040624155919.GA16422@trot.local> <Pine.GSO.4.33.0406241442430.25702-100000@sweetums.bluetronic.net> <20040625213433.GB6502@trot.local> <Pine.LNX.4.58.0406251602140.1844@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:9113 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S264635AbUF1CMx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Jun 2004 22:12:53 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406251602140.1844@ppc970.osdl.org>
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On Fri, Jun 25, 2004 at 04:16:03PM -0700, Linus Torvalds wrote:
>That's "p->pids[PIDTYPE_PID].pidptr", and it looks like "p" is NULL.
>
>That in turn _shouldn't_ happen, since that comes from 
>
>       struct task_struct *task = proc_task(inode);
>
>and proc_task() should always be non-NULL for any /proc file that has one 
>of the pid-based dentry ops. 

>On Fri, 25 Jun 2004, George Georgalis wrote:
>> ATM, ps also seg faults, here is a corresponding oops,
>
>Same problem. One of your existing /proc/<xxx>/ directories has a NULL 
>"task" pointer, and that really shouldn't happen.

The first thing I noticed when reading sata_sil.c was readl() and
writel() calls.  Thinking that meant "read/write line" I guessed it
could invoke a sectors = 15 hardware issue with some data, and went to
see exactly what it means.

I haven't determined which include/asm-*/io.h is used for
MCYRIXIII/MVIAC3, but my best guess is include/asm-i386/io.h

#define readl(addr) (*(volatile unsigned int *) (addr))
#define writel(b,addr) (*(volatile unsigned int *) (addr) = (b))

then I find volatile in a driver example from
http://publications.gbdirect.co.uk/c_book/chapter8/const_and_volatile.html
Which describes how volatile is used to peek hardware status.

but, in sata_sil.c, sil_scr_write does

                writel(val, mmio);

volatile is used for data, not status! I can't glean this construct
(when the data runs out it's null and the loop ends?). Was going to say
if hardware caused status to turn up null that could be checked and
assigned before being used...

 On Sun, Jun 27, 2004 at 10:39:08AM -0700, Linus Torvalds wrote:
 >So I stand by the rule: we should make _code_ have the access rules, and
 >the data itself should never be volatile. And yes, jiffies breaks that
 >rule, but hey, that's not something I'm proud of.

So sata_sil.c is using the wrong construct or am I not reading it right?

>Hmm. I do worry that maybe it's the SATA thing that has written NULL 
>somewhere, since the /proc code never clears that field once it is set 
>(and it would always be set by the code that creates the inode in the 
>first place). 

Might it come from reiserfs? I didn't mkfs again after the last sata 
device block(s). I'll be doing some more experimentation, how would I
'find' the null in proc? can I detect that in user space? 

// George


-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

