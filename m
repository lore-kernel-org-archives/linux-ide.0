From: Tejun Heo <tj@kernel.org>
Subject: Re: possible ATA hang in 2.6.32-rc6
Date: Mon, 09 Nov 2009 18:34:02 +0900
Message-ID: <4AF7E20A.20005@kernel.org>
References: <4AF5ADA3.3070000@ix.netcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57645 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680AbZKIJfM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Nov 2009 04:35:12 -0500
In-Reply-To: <4AF5ADA3.3070000@ix.netcom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marty <martyb@ix.netcom.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, User discussion about IVTV <ivtv-users@ivtvdriver.org>

Hello, Marty.

Marty wrote:
> I got two hard hangs in 2.6.32-rc5 and rc6 in an Asrock A780GXE/128M
> with AMD 780G+SB700 chipsets, resulting in no response to magic alt-sysreq.
> The first hang left no log clues.  The second was closely but not
> immediately preceeded by syslog ATA error messages (see excerpt).

Do you have nmi watchdog configured?

> They occurred days apart, possibly associated with keyboard or
> mouse operation.  Each hang, both tuner cards were active, with heavy
> concurrent graphics, SATA and USB activity. The system has I2C and
> framebuffer issues with the Radeon 7000, causing problems in the
> tuners, but I don't know if it's relevant. The hangs result in no
> response to magic alt-sysreq.
> 
> When tuners, USB and graphics are not active, the system passes
> heavy prolonged stress testing. I got less-complete ATA-related hangs
> on my previous VIA system, under similar conditions.  I hoped this
> new board would fix the problem.  The tuner ivtv drivers could be
> involved, and were known as unstable until about a year ago.
> 
> I am now disabling PMP, to see if that avoids the problem.  Let me
> know if you need any more information.  Thanks,

The ata error messages indicate transmission problems.  The fact that
they're pretty close to each other is interesting and seems to point
to hardware problem (most likely power fluctuation).  At any rate,
ahci controllers are very unlikely to cause complete system hang, so
I'm a bit doubtful that ahci controller is directly responsible for
the hang.  Can you wire up a separate power supply and move hard
drives to that one?

Thanks.

-- 
tejun
