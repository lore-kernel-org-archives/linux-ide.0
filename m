From: Jeff Garzik <jeff@garzik.org>
Subject: Re: linux-next: first tree
Date: Thu, 14 Feb 2008 16:45:49 -0500
Message-ID: <47B4B68D.7080805@garzik.org>
References: <20080215003537.8911ce35.sfr@canb.auug.org.au>	 <47B4AC97.3040001@garzik.org> <1203024381.3158.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759202AbYBNVqN@vger.kernel.org>
In-Reply-To: <1203024381.3158.26.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

James Bottomley wrote:
> So does this indicate the meaning of upstream and upstream-fixes is
> still the same?  I always took upstream-fixes to be bug fixes for this
> -rc and upstream as queued for the next merge window, in which case NEXT
> would be the union of those two sets?


In practice, #upstream-fixes isn't very useful, because I send its 
contents to Linus very very rapidly once they are committed to that 
branch.  I then locally delete that branch once Linus merges it, and 
re-create it [again, locally] the next time I have some bug fixes to apply.

So it is a "somewhat throwaway" branch.

The main utility of #upstream-fixes is so that I can do
	git branch upstream-linus upstream-fixes
and then continue making commits in parallel with a Linus pull+push cycle.

The #upstream branch is much more useful, because that is where things 
for the next kernel are stored, during a bug-fix-only cycle.  This is 
largely equivalent to NEXT, though I plan to be more stringent in my 
requirements for NEXT commits than #upstream commits.

One thing to note is that "pure" rebases are somewhat rare; I much 
prefer to wait until the batch of commits lands in 
torvalds/linux-2.6.git, before I blow away and recreate (with a new 
torvalds HEAD) the branch in question.


So, to answer your question...  Fixes should go upstream fast enough 
that they should hit NEXT implicitly via a Linus pull+push.  It should 
be the union of two sets, yes, if a Linus cycle takes a long time.  When 
both #upstream and #upstream-fixes are active, I tend to always branch 
#upstream off of #upstream-fixes and/or do a "git pull . upstream-fixes" 
when updating #upstream.

	Jeff
