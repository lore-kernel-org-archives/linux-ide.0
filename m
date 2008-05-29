From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RESEND: [PATCH] libata-sff: Fix oops reported in kerneloops.org
 for pnp devices with no ctl
Date: Thu, 29 May 2008 10:04:10 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805290950230.2958@woody.linux-foundation.org>
References: <20080529161453.24735.805.stgit@core>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756806AbYE2REd@vger.kernel.org>
In-Reply-To: <20080529161453.24735.805.stgit@core>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jeff@garzik.org
List-Id: linux-ide@vger.kernel.org



On Thu, 29 May 2008, Alan Cox wrote:
>
> (Jeff would you please take a look at this: Its #4 or #5 top OOPS on Arjan's
>  oops tracker, and it generally causes the boot to fail. First sent 20th May)

Quite frankly, if I was Jeff, I'd have refused to apply this patch as "too 
damn ugly to live".

Why the *hell* doesn't it just fix "ata_sff_altstatus()" instead? Why does 
it introduce a ludicrously named stupid "maybe" version of it that doesn't 
oops?

In other words: in *any* case where the old "ata_sff_altstatus()" function 
worked correctly, the new "ata_sff_maybe_altstatus()" function does THE 
EXACT SAME THING. And in any case where the old "ata_sff_altstatus()" 
function oopsed, the new "maybe" version at least is _better_.

In other words: there is absolutely no excuse for keeping the old (and 
known-to-be-broken) "ata_sff_altstatus()" function at all. It should be 
removed, not left around with an alternate function that works.

I also think your "ata_sff_sync()" thing is buggy. It has a "ndelay(400)" 
that is almost certainly buggy (it's the one that is already in 
ata_sff_pause()).

It may be that you meant to make it an "else if" case, ie if there was no 
IO-read, then you do a ndelay(400) as a last desperate case, but that's 
not how your ata_sdd_sync() is actually written.

		Linus
