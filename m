From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 18:52:23 +0100
Message-ID: <200911191852.23061.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <200911191838.11791.bzolnier@gmail.com> <20091119175051.6a91d160@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:54807 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbZKSRxJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 12:53:09 -0500
In-Reply-To: <20091119175051.6a91d160@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Thursday 19 November 2009 18:50:51 Alan Cox wrote:
> On Thu, 19 Nov 2009 18:38:11 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Thursday 19 November 2009 17:27:38 Alan Cox wrote:
> > > > > > already have a buggy cable detection (since ->pre_reset ignores the mandatory
> > > > > 
> > > > > Wrong.
> > > > 
> > > > You cannot know it unless you know how chip operates internally.  That's it.
> > > 
> > > Read the code. How the chip operates is irrelevant.
> > 
> > lol, there is a genuine cable detection bug in pata_hpt3x2n on closer look...
> 
> Oh you found it now I told you which one was buggy - well done. Already
> patched along with adding suspend/resume and fixing a performance funny.

LOL

Fixed where?  I posted the patch as soon as I noticed the problem.

Told me about it?  Now this is extra funny since the bug been there for like
three years and still would be unfixed if it wasn't for this discussion.

The best part is that the bug would never have happened in the first place
if you weren't artificially splitting HPT37x and HPT3xxN support cause cable
detection for all those chipsets (except HPT374 fn 1) is identical!! :)

-- 
Bartlomiej Zolnierkiewicz
