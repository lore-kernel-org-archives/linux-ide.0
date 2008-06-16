From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] IDE fixes
Date: Sun, 15 Jun 2008 17:04:18 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806151702400.2949@woody.linux-foundation.org>
References: <200806152149.11267.bzolnier@gmail.com> <alpine.LFD.1.10.0806151630380.2949@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752524AbYFPAFf@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0806151630380.2949@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org



On Sun, 15 Jun 2008, Linus Torvalds wrote:
> 
> It *looks* like it has all the new objects, but its 
> objects/info/alternates is corrupt:
> 
> 	[torvalds@hera ide-2.6.git]$ cat objects/info/alternates 
> 	/home/dump/git/linux-2.6.git/.git/objects
> 
> and there is no such thing as "/home/dump/git/linux-2.6.git/"

Ok, I did the pull by just copying the objects to a local repo, and 
setting the alternates file correctly. So it worked this time, but please 
double-check your alternates next time,

		Linus
