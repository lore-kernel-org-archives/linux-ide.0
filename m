From: "David S. Miller" <davem@redhat.com>
Subject: Re: IDE corruption datapoint
Date: Wed, 16 Jul 2003 06:27:17 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030716062717.72198f11.davem@redhat.com>
References: <20030716060845.0e71a6e5.davem@redhat.com>
	<200307161324.h6GDO7l28802@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pizda.ninka.net ([216.101.162.242]:49371 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270822AbTGPNV6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2003 09:21:58 -0400
In-Reply-To: <200307161324.h6GDO7l28802@devserv.devel.redhat.com>
List-Id: linux-ide@vger.kernel.org
Cc: alan@redhat.com, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, bcollins@debian.org

On Wed, 16 Jul 2003 09:24:07 -0400 (EDT)
Alan Cox <alan@redhat.com> wrote:

> > CONFIG_X86_GOOD_APIC is enabled, but there is no IO-APIC in this
> > VAIO and /proc/interrupts shows all XT-PIC.
> 
> It matters if you have APIC/IO-APIC support enabled. In marcelo's tree
> disable_irq is broken in APIC mode for non SMP.

I'll test with this option enabled then.

> > Can you show the patch in question?  I guess it's in 2.6.0-test1
> > already?
> 
> I got mail from two people confirming some "patch" fixed it, but nobody
> ever sent me the patch in question. I'd guess its making sure the PIO side
> is always set up at boot

That was probably from me, I forwarded you an email from Ivan saying
"this aparently fixes Alpha, I'm asking Ben Collins to test back in
2.4.x" but the latter never actually occurred :-)
