From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [git patches 2/2] warnings: use uninitialized_var()
Date: Wed, 18 Jul 2007 13:30:11 +0200
Message-ID: <20070718113011.GI3801@stusta.de>
References: <20070717214239.GF28448@devserv.devel.redhat.com> <20070717214952.GG28448@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36935 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932075AbXGRLat (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 07:30:49 -0400
Content-Disposition: inline
In-Reply-To: <20070717214952.GG28448@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, chas@cmf.nrl.navy.mil, rolandd@cisco.com, dwmw2@infradead.org, gregkh@suse.de

On Tue, Jul 17, 2007 at 05:49:52PM -0400, Jeff Garzik wrote:
> 
> For many months, I have maintained a hand-verified list of bogus "may be
> used uninitialized" warning fixes, in misc-2.6.git#gccbug.  Andrew urged
> me to head these upstream.
> 
> I have gone through and re-analyzed each warning, and verified that
> these variables are indeed initialized properly, and gcc is making
> needless noise.
>...

Some notes:
- if gcc can prove a variable gets used uninitialized it gives
  a different warning
- gcc says it may be used uninitialized - there can always be false
  positives when the correctness of the code is due to some higher
  level logic
- I've seen cases in the kernel where it was technically impossible
  for the compiler to verify a variable always gets initialized

So if we want these warnings we'll always need to silence the ones that 
are verified as being correct code like your patches do - and that's not 
gcc's fault.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

