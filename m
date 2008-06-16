From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE fixes
Date: Mon, 16 Jun 2008 11:10:42 +0200
Message-ID: <200806161110.44224.bzolnier@gmail.com>
References: <200806152149.11267.bzolnier@gmail.com> <alpine.LFD.1.10.0806151630380.2949@woody.linux-foundation.org> <alpine.LFD.1.10.0806151702400.2949@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:6066 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758375AbYFPJKB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2008 05:10:01 -0400
Received: by yw-out-2324.google.com with SMTP id 9so3045741ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 16 Jun 2008 02:09:31 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806151702400.2949@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 16 June 2008, Linus Torvalds wrote:
> 
> On Sun, 15 Jun 2008, Linus Torvalds wrote:
> > 
> > It *looks* like it has all the new objects, but its 
> > objects/info/alternates is corrupt:
> > 
> > 	[torvalds@hera ide-2.6.git]$ cat objects/info/alternates 
> > 	/home/dump/git/linux-2.6.git/.git/objects
> > 
> > and there is no such thing as "/home/dump/git/linux-2.6.git/"
> 
> Ok, I did the pull by just copying the objects to a local repo, and 
> setting the alternates file correctly. So it worked this time, but please 
> double-check your alternates next time,

Thanks, and sorry for troubles.

Bart
