From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 4/6] ide: allow ide_dev_read_id() to be called from the IRQ context
Date: Wed, 24 Jun 2009 11:51:16 +0200
Message-ID: <200906241151.16506.bzolnier@gmail.com>
References: <200906232329.11648.bzolnier@gmail.com> <200906240336.25263.bzolnier@gmail.com> <20090623.213535.52208572.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:64636 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbZFXJpb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 05:45:31 -0400
In-Reply-To: <20090623.213535.52208572.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 24 June 2009 06:35:35 David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Wed, 24 Jun 2009 03:36:24 +0200
> 
> > IOW if there are really some technical issues left to be addressed with
> > these patches I'll be happy to address them but I'm not doing any more
> > new IDE stuff.
> 
> Discussing alternative approaches to fixing the problem is a technical
> issue.
> 
> If you just want to dump your pending fixes and have no interest in
> anything other than minor fixups and typo cures, then it's likely most
> of these patches will be used only as guides for others rather than
> being applied.

I'm perfectly happy with it.

> Specifically in this case I really think this is a very unclean way to
> solve this problem, which is why I suggested alternative
> implementations in the first place.
> 
> Anything that requires a set of if() blocks checking "in interrupt
> context" or not is a big red flag in my book.

It is also a big red flag in my book.  However after long hours put into
analysis of the issue I came to conclusions that they are needed/justified
in this specific case unless we are going to do really major surgery there
(which we shouldn't according to the new policy).

You've put less than 2h (because that was the time since my post till your
reply) into analysis of the bug, the related problems and the solution.

It could be that if you had put a bit more time into it and/or asked detailed
technical questions related to the solution (i.e. "Why x needs to be there
and we can't do y?") instead of keeping the technical discussion on the very
vague level (which sounded like "can't we use block layer to process block
requests because drive commands are block requests and raw commands are drive
commands so we should use block layer") you would come to very different
conclusions than you did initially.
