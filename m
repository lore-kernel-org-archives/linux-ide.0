From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sat, 29 Oct 2005 21:09:24 +0100
Message-ID: <20051029200924.GM7992@ftp.linux.org.uk>
References: <20051029182228.GA14495@havoc.gtf.org> <20051029121454.5d27aecb.akpm@osdl.org> <4363CB60.2000201@pobox.com> <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751294AbVJ2UJg@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Oct 29, 2005 at 12:37:58PM -0700, Linus Torvalds wrote:
> Now, I've gotten several positive comments on how easy "git bisect" is to 
> use, and I've used it myself, but this is the first time that patch users 
> _really_ become very much second-class citizens, and you can't necessarily 
> always do useful things with just the tar-trees and patches. That's sad, 
> and possibly a really big downside.
> 
> Don't get me wrong - I personally think that the new merge policy is a 
> clear improvement, but it does have this downside.

Well...  All it takes is extra patches when incremental gets too large;
e.g. have a script pick idle interval close to splitting the thing in
half until parts get less than <size>.  The question is, how much extra
load would that create?  Another problem is that a lot of intermediates
will not build, but that is just as true for -git<n> snapshots ;-/
