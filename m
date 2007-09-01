From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [1/2] 2.6.23-rc3: known regressions with patches
Date: Sat, 1 Sep 2007 00:08:14 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709010006570.14418@woody.linux-foundation.org>
References: <46D59081.2040605@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754105AbXIAHKk@vger.kernel.org>
In-Reply-To: <46D59081.2040605@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Gabriel C <nix.or.die@googlemail.com>, Satyam Sharma <satyam.sharma@gmail.com>, Vitaly Bordug <vitb@kernel.crashing.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Tony Luck <tony.luck@intel.com>, John Stultz <johnstul@us.ibm.com>, Paolo Ornati <ornati@fastwebnet.it>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, Stephen Ziemba <sziemba@ecn.purdue.edu>
List-Id: linux-ide@vger.kernel.org



On Wed, 29 Aug 2007, Michal Piotrowski wrote:
> 
> Clocks & time
> 
> Subject         : "double" hpet clocksource && hard freeze
> References      : http://lkml.org/lkml/2007/8/23/257
> Last known good : ?
> Submitter       : Paolo Ornati <ornati@fastwebnet.it>
> Caused-By       : Tony Luck <tony.luck@intel.com>
>                   commit 0aa366f351d044703e25c8425e508170e80d83b1
> Handled-By      : John Stultz <johnstul@us.ibm.com>
>                   Tony Luck <tony.luck@intel.com>
> Patch           : http://lkml.org/lkml/2007/8/23/285
> Status          : patch available

Should be solved by 3b2b64fd311c92f2137eb7cee7025794cd854057, although 
differently from the the patch suggested above. So the regression should 
be gone a of -rc5.

		Linus
