From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] IDE updates/fixes
Date: Tue, 15 May 2007 18:49:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705151847160.3890@woody.linux-foundation.org>
References: <200705160127.55430.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761647AbXEPBv4@vger.kernel.org>
In-Reply-To: <200705160127.55430.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org



On Wed, 16 May 2007, Bartlomiej Zolnierkiewicz wrote:
> 
> * host driver fixes:
>   - pdc202xx_old: mode programming rewrite (a lot of bugs fixed)
>   - serverworks/sis5513: PIO mode setup fixes
>   - sl82c105: MWDMA0/1 support by Sergei
>   - cs5530/sc1200/sl82c105: ->speedproc support ("hdparm -X")

> * 2nd part of cleanups basing on DMA tuning rework (which was merged
>   in the previous IDE update) - quite straightforward code re-factoring
>   (no functionality changes) and removal of no longer needed functions.
> 
>   This results in simpler, more generic code and in ~300 LOCs gone.
> 
> * some misc fixes/updates

Bartlomiej, this really was too late for the 2.6.22 merge window. I'm 
going to pull it, since it seems borderline mostly fixes and the 
refactoring should hopefully not change any functionality, but I really 
don't enjoy it. Please don't do this again.

		Linus
