From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 17:50:51 +0000
Message-ID: <20091119175051.6a91d160@lxorguk.ukuu.org.uk>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>
	<200911191645.29885.bzolnier@gmail.com>
	<20091119162738.7e8e5665@lxorguk.ukuu.org.uk>
	<200911191838.11791.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56634 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752913AbZKSRs6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 12:48:58 -0500
In-Reply-To: <200911191838.11791.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Thu, 19 Nov 2009 18:38:11 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Thursday 19 November 2009 17:27:38 Alan Cox wrote:
> > > > > already have a buggy cable detection (since ->pre_reset ignores the mandatory
> > > > 
> > > > Wrong.
> > > 
> > > You cannot know it unless you know how chip operates internally.  That's it.
> > 
> > Read the code. How the chip operates is irrelevant.
> 
> lol, there is a genuine cable detection bug in pata_hpt3x2n on closer look...

Oh you found it now I told you which one was buggy - well done. Already
patched along with adding suspend/resume and fixing a performance funny.
