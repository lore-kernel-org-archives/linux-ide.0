From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/2] 2.6.22-rc5: known regressions v2
Date: Thu, 21 Jun 2007 18:35:07 +0200
Message-ID: <467AA8BB.2060305@googlemail.com>
References: <467AA5D2.3020500@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:42263 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553AbXFUQfq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jun 2007 12:35:46 -0400
Received: by ug-out-1314.google.com with SMTP id j3so614274ugf
        for <linux-ide@vger.kernel.org>; Thu, 21 Jun 2007 09:35:46 -0700 (PDT)
In-Reply-To: <467AA5D2.3020500@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Rodney Gordon II <meff@spherevision.org>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, Mark Fortescue <mark@mtfhpc.demon.co.uk>, William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>, discuss@x86-64.org, Ioan Ionita <opslynx@gmail.com>

Hi all,

Here is a list of some known regressions in 2.6.22-rc5.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

(BTW. There is a new category called "Will be fixed in 2.6.23")



SATA/PATA

Subject    : libata IT821X driver still fails! Hard-freezes system
References : http://lkml.org/lkml/2007/6/14/82
Submitter  : Rodney Gordon II <meff@spherevision.org>
Status     : unknown



Sparc64

Subject    : random invalid instruction occourances on sparc32 (sun4c)
References : http://lkml.org/lkml/2007/6/17/111
Submitter  : Mark Fortescue <mark@mtfhpc.demon.co.uk>
Status     : problem is being debugged

Subject    : 2.6.22-rc broke X on Ultra5
References : http://lkml.org/lkml/2007/5/22/78
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Handled-By : David Miller <davem@davemloft.net>
Status     : problem is being debugged



x86-64

Subject    : x86-64 2.6.22-rc2 random segfaults
References : http://lkml.org/lkml/2007/5/24/275
Submitter  : Ioan Ionita <opslynx@gmail.com>
Status     : Unknown



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/
