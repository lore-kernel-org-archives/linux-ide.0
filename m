From: Rob Landley <rob@landley.net>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sun, 30 Oct 2005 06:44:19 -0600
Message-ID: <200510300644.20225.rob@landley.net>
References: <20051029182228.GA14495@havoc.gtf.org> <4363CB60.2000201@pobox.com> <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932168AbVJ3Moe@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Saturday 29 October 2005 14:37, Linus Torvalds wrote:
> Now, I've gotten several positive comments on how easy "git bisect" is to
> use, and I've used it myself, but this is the first time that patch users
> _really_ become very much second-class citizens, and you can't necessarily
> always do useful things with just the tar-trees and patches. That's sad,
> and possibly a really big downside.
>
> Don't get me wrong - I personally think that the new merge policy is a
> clear improvement, but it does have this downside.

One possible solution:

Rather than making the patch a simple diff of the trees, make the patch a cat 
of the individual patches/commits (preferably with descriptions) that got 
applied, in the order they got applied.

This makes the patch bigger, but it also means that bisect can be done with 
vi, simply by truncating the file at the last interesting patch and applying 
the truncated version to a clean tree.  Since patch applies hunks in order 
and sifts out hunks from description already...

Is this a viable option?

Rob
