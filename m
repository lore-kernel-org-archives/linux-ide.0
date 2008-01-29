From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 17:44:55 +0000
Message-ID: <20080129174455.62742b82@core>
References: <200801272122.21823.gene.heskett@gmail.com>
	<200801291132.41657.gene.heskett@gmail.com>
	<18335.22763.625990.528217@alkaid.it.uu.se>
	<200801291204.44671.gene.heskett@gmail.com>
	<alpine.LNX.1.00.0801291220540.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37120 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751833AbYA2RtZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 12:49:25 -0500
In-Reply-To: <alpine.LNX.1.00.0801291220540.13593@iabervon.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Gene Heskett <gene.heskett@gmail.com>, Mikael Pettersson <mikpe@it.uu.se>, Richard Heck <rgheck@bobjweil.com>, Zan Lynx <zlynx@acm.org>, Calvin Walton <calvin.walton@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

> things in the kernel that refer to SCSI probably should say "storage" (or 
> "ATA", really, but that would make the acronyms confusing).

SCSI is a command protocol. It is what your CD-ROM drive and USB storage
devices talk (albeit with a bit of an accent).

Alan
