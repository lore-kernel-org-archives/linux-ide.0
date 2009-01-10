From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: todays git: WARNING: at drivers/ata/libata-sff.c:1017
 ata_sff_hsm_move+0x45e/0x750()
Date: Sat, 10 Jan 2009 13:51:04 +0000
Message-ID: <20090110135104.3f402b5d@lxorguk.ukuu.org.uk>
References: <200901091334.55823.borntraeger@de.ibm.com>
	<49688B63.5030105@ru.mvista.com>
	<20090110122130.318cf168@lxorguk.ukuu.org.uk>
	<200901101404.39139.borntraeger@de.ibm.com>
	<49689F19.7030203@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42495 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750773AbZAJNzb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jan 2009 08:55:31 -0500
In-Reply-To: <49689F19.7030203@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, lkml <linux-kernel@vger.kernel.org>

On Sat, 10 Jan 2009 08:14:01 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Christian Borntraeger wrote:
> > Am Samstag 10 Januar 2009 schrieb Alan Cox:
> >>>    That's the typical REQUEST SENSE command with 18-byte data length.
> >> Which means something has become horribly broken in the core libata stack.
> >> An 18 byte inquiry would have 18 bytes as the *last* sg element. That
> >> would therefore not trigger the WARN_ON. Someone has passed an sg list
> >> that isn't properly terminated perhaps ?
> >>
> >> I wonder if the pad code broke this.
> > 
> > I just checked 2.6.28 + PIO32 patch. Its also broken. Whatever caused this 
> > problem did it a while ago.
> 
> Just to be clear, you mean:
> 
> 2.6.28 is OK
> 2.6.28 + PIO32 is broken

As far as I can tell

2.6.28 is broken but it doesn't show due to other factors
2.6.28 using 32bit PIO shows up the fact someone seems to be passing
broken sg lists
