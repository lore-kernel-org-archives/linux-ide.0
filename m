From: Tejun Heo <tj@kernel.org>
Subject: Re: [git patches] libata fixes
Date: Wed, 28 Jan 2009 08:04:24 +0900
Message-ID: <497F92F8.5040806@kernel.org>
References: <20090127073055.GA30360@havoc.gtf.org> <alpine.LFD.2.00.0901270748290.3123@localhost.localdomain> <497F545B.6000104@garzik.org> <alpine.LFD.2.00.0901271100320.3123@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60814 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbZA0XE2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 18:04:28 -0500
In-Reply-To: <alpine.LFD.2.00.0901271100320.3123@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hello, Linus, Jeff.

Linus Torvalds wrote:
> 
> On Tue, 27 Jan 2009, Jeff Garzik wrote:
>> I also habitually _avoid_ "git commit -a", so I am surprised that I actually
>> made this mistake.  I am 100% certain that I issued neither "git rm" nor "git
>> update-index" commands on that file.
>>
>> Granted, I should have been more careful, but I am also surprised this
>> happened at all.
> 
> Well, it's attributed to Tejun, and he probably sent you a "git diff". The 
> delete part of such a diff is pretty small, so you both probably missed 
> it at the top of the diff:
> 
> 	diff --git a/arch/arm/mach-integrator/clock.h b/arch/arm/mach-integrator/clock.h
> 	deleted file mode 100644
> 	index e69de29..0000000
> 
> and then you used "git am -s" or something to apply it and delete that 
> file.
> 
> No "git commit -a" necessary - just a simple "git diff" after having done 
> a "make distclean" and then sending the result off by email without 
> looking any closer..

Yes, that patch was generated with "git diff" and distclean was done
cuz I just began to use separate output directories for build.  I've
restored the empty file for several times for other patches but it
slipped this time.  My apologies.  I'll be more careful.

Thanks.

-- 
tejun
