From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git patches] ide update
Date: Thu, 18 Aug 2005 15:15:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508181512240.3412@g5.osdl.org>
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932497AbVHRWPx@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org



On Thu, 18 Aug 2005, Bartlomiej Zolnierkiewicz wrote:
> 
> 3 obvious fixes + support for 2 new controllers
> (just new PCI IDs).

Btw, things like this:

	+#define IDEFLOPPY_TICKS_DELAY  HZ/20   /* default delay for ZIP 100 (50ms) */

are just bugs waiting to happen.

Hint: see what happens when you do something like this:

	high_byte = IDEFLOPPY_TICKS_DELAY >> 8;
	low_byte = (unsigned char) IDEFLOPPY_TICKS_DELAY;

and watch in amazement how you get entirely the wrong value if HZ is 1000.

Try it out..

		Linus
