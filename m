From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Problem with ata layer in 2.6.24
Date: Mon, 28 Jan 2008 12:59:13 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801281248190.13593@iabervon.org>
References: <200801272122.21823.gene.heskett@gmail.com> <1201539043.31293.7.camel@zem> <1201540830.6526.19.camel@localhost> <200801281230.32910.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753081AbYA1R7b@vger.kernel.org>
In-Reply-To: <200801281230.32910.gene.heskett@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gene Heskett <gene.heskett@gmail.com>
Cc: Zan Lynx <zlynx@acm.org>, Calvin Walton <calvin.walton@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, 28 Jan 2008, Gene Heskett wrote:

> I believe at this point, its moot.  I captured quite a few instances of that 
> error message while rebooting the last time, all of which occurred long 
> before I logged in and did a startx (I boot to runlevel 3 here), so the 
> kernel was NOT tainted at that point.  That dmesg has been posted and some 
> questions asked.
> 
> As this has gone on for a while, it seems to me that with 14,800 google hits 
> on this problem, Linus should call a halt until this is found and fixed.  But 
> I'm not Linus.  I'm also locking up for 30 at a time, & probably ready for 
> reboot #7 today.

Can you switch back to old IDE to get your work done (and to make sure 
it's not a hardware issue that's developed recently)? I believe libata is 
just a whole lot pickier about behavior than the IDE subsystem was, so 
it's more likely to complain about stuff, both for good reasons and when 
it shouldn't, and there are a slew of potential "we have to accept that 
old PATA hardware does this" bugs that all have the same symptom of "we go 
into error handling when nothing is actually wrong", hence the vast 
quantity of hits. I think it's not exactly that it's a common problem as 
that it's a lot of problems that aren't very distinguishable.

	-Daniel
*This .sig left intentionally blank*
