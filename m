From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [IDE] Fix build bug
Date: Thu, 25 Oct 2007 18:12:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0710251809070.24086@blysk.ds.pg.gda.pl>
References: <20071025135334.GA23272@linux-mips.org> <20071025141305.GA11698@uranus.ravnborg.org>
 <Pine.LNX.4.64N.0710251545300.24086@blysk.ds.pg.gda.pl>
 <20071025160529.GB24621@linux-mips.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:43405 "EHLO
	cerber.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbXJYRMq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 13:12:46 -0400
In-Reply-To: <20071025160529.GB24621@linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mips@linux-mips.org

On Thu, 25 Oct 2007, Ralf Baechle wrote:

> >  Somebody wants to mix up read-only and read/write data in the same 
> > section and GCC quite legitimately complains about it.  You cannot have 
> > both at a time.
> 
> My interpretation is that it would be perfectly ok for a C compiler to
> do minimal handling of const by only throwing errors for attempted
> assignments to const objects but otherwise treating them as if they
> were non-const, that is for example putting them into an r/w section.

 That would probably be valid (any C standard expert please correct me if 
I am wrong), but the approach looks like: since we have the capability in 
the hardware and the OS, then why not actually enforce the rule at the run 
time as well?

  Maciej
