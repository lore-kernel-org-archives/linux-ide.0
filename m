From: Alan Cox <alan@redhat.com>
Subject: Re: IDE corruption datapoint
Date: Wed, 16 Jul 2003 09:24:07 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200307161324.h6GDO7l28802@devserv.devel.redhat.com>
References: <20030716060845.0e71a6e5.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:28196 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270803AbTGPNJT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jul 2003 09:09:19 -0400
In-Reply-To: <20030716060845.0e71a6e5.davem@redhat.com> from "David S. Miller" at Gor 16, 2003 06:08:45 
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@redhat.com>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, bcollins@debian.org

> CONFIG_X86_GOOD_APIC is enabled, but there is no IO-APIC in this
> VAIO and /proc/interrupts shows all XT-PIC.

It matters if you have APIC/IO-APIC support enabled. In marcelo's tree
disable_irq is broken in APIC mode for non SMP.

> WRT. the VAIO, I originally suspected some of the DMI table changes
> that went into 2.4.21, but I reverted that (and nearly all of the
> other i386 specific 2.4.21 changes) to no avail.

They really wouldn't relate to the IDE code at all. IDE or block layer
stuff is by far the most likely.

> Interesting.  I've never seen any evidence from Ben or anyone else who
> saw the problem on Sparc say much other than "2.6.0-test1 doesn't have
> the problem, 2.4.x does"
> 
> Can you show the patch in question?  I guess it's in 2.6.0-test1
> already?

I got mail from two people confirming some "patch" fixed it, but nobody
ever sent me the patch in question. I'd guess its making sure the PIO side
is always set up at boot
