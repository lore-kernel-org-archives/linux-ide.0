From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [git patches] libata updates for 3.3
Date: Mon, 16 Jan 2012 22:03:01 +0000
Message-ID: <20120116220300.GA6961@srcf.ucam.org>
References: <4F12E57E.3090805@garzik.org>
 <1326676534.13517.3.camel@minggr>
 <1326691403.13517.21.camel@minggr>
 <CA+55aFzqECJjbtgyOXy_H1smh09SsfgrAuVY7hK2sC-xj1GZHg@mail.gmail.com>
 <20120116194211.2cd09fb3@pyramind.ukuu.org.uk>
 <CA+55aFxNcAtCmzEejS=3+_L_rp-MOBS0yLS061YgiCsFw_Mt5Q@mail.gmail.com>
 <20120116195427.64edd96f@pyramind.ukuu.org.uk>
 <CA+55aFzXFyHTUv=8NtSmXA2UY_qO5P=HXdGnhUmF9YoA5vpX1g@mail.gmail.com>
 <20120116212640.GA6313@srcf.ucam.org>
 <CA+55aFw53SiHYZ29bo83iyuEG1vEz5WYcx5PWegw51Y1r8YZzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43333 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562Ab2APWDK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2012 17:03:10 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFw53SiHYZ29bo83iyuEG1vEz5WYcx5PWegw51Y1r8YZzA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lin Ming <ming.m.lin@intel.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Jan 16, 2012 at 01:34:53PM -0800, Linus Torvalds wrote:
> On Mon, Jan 16, 2012 at 1:26 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >
> > Macs will come up with ahci if you boot via EFI rather than the BIOS
> > compatibility module.
> 
> Apparently not this one. Or there is something else subtly wrong. I
> use rEFIt to boot Linux on this thing, which should mean that it
> booted as an EFI image, even if the kernel itself is not natively
> using EFI (or even built to care).

refit is an EFI app, but it's usually used to trigger a BIOS-based boot.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
