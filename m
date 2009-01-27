From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata fixes
Date: Tue, 27 Jan 2009 11:02:45 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901271100320.3123@localhost.localdomain>
References: <20090127073055.GA30360@havoc.gtf.org> <alpine.LFD.2.00.0901270748290.3123@localhost.localdomain> <497F545B.6000104@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53786 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755056AbZA0TDb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2009 14:03:31 -0500
In-Reply-To: <497F545B.6000104@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>



On Tue, 27 Jan 2009, Jeff Garzik wrote:
> 
> I also habitually _avoid_ "git commit -a", so I am surprised that I actually
> made this mistake.  I am 100% certain that I issued neither "git rm" nor "git
> update-index" commands on that file.
>
> Granted, I should have been more careful, but I am also surprised this
> happened at all.

Well, it's attributed to Tejun, and he probably sent you a "git diff". The 
delete part of such a diff is pretty small, so you both probably missed 
it at the top of the diff:

	diff --git a/arch/arm/mach-integrator/clock.h b/arch/arm/mach-integrator/clock.h
	deleted file mode 100644
	index e69de29..0000000

and then you used "git am -s" or something to apply it and delete that 
file.

No "git commit -a" necessary - just a simple "git diff" after having done 
a "make distclean" and then sending the result off by email without 
looking any closer..

			Linus
