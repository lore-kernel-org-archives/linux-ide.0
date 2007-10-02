From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 9/15] cs5530: remove needless ide_lock taking
Date: Tue, 2 Oct 2007 23:02:20 +0200
Message-ID: <200710022302.20574.bzolnier@gmail.com>
References: <200710012337.16971.bzolnier@gmail.com> <20071002144541.1832b74d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:30390 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbXJBVTm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 17:19:42 -0400
Received: by nf-out-0910.google.com with SMTP id g13so3415442nfb
        for <linux-ide@vger.kernel.org>; Tue, 02 Oct 2007 14:19:42 -0700 (PDT)
In-Reply-To: <20071002144541.1832b74d@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Tuesday 02 October 2007, Alan Cox wrote:
> > -	spin_lock_irqsave(&ide_lock, flags);
> > -		/* all CPUs (there should only be one CPU with this chipset) */
> > -
> 
> NAK
> 
> What about pre-emptible kernels. Put in a private lock.

All the removed code resided in init_chipset_cs5530() which is called only
during the controller initialization.  Moreover pata_cs5530 also don't have
any locking in cs5530_init_chip().

Bart
