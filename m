From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH bug fix 13378] pata_legacy: wait for async probing
Date: Fri, 5 Jun 2009 16:26:37 +0100
Message-ID: <20090605162637.5095972f@lxorguk.ukuu.org.uk>
References: <1244212899.3922.8.camel@mulgrave.site>
	<18985.13323.190252.350912@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47305 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752157AbZFEP1I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jun 2009 11:27:08 -0400
In-Reply-To: <18985.13323.190252.350912@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>, Mikael Pettersson <mikpe@it.uu.se>, torvalds@linux-foundation.org

> It's not apparent from this description, but the bug is worse
> than some warnings from the kernel: the kernel hangs hard.

Jeff seems to have vanished - some of the other trivial ATA one liners
haven't gone upstream either. He's posted 3 replies since 20th May so
I've no idea what he is up to (Fedora 11 mad panics perhaps) but this
patch probably wants to go direct to Linus.

Alan
