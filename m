From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Tue, 30 Oct 2007 15:34:17 +0000
Message-ID: <20071030153417.59b9182c@the-village.bc.nu>
References: <47274A5F.6070409@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54037 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756505AbXJ3Pcx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 11:32:53 -0400
In-Reply-To: <47274A5F.6070409@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Tue, 30 Oct 2007 15:14:39 +0000
Daniel Drake <dsd@gentoo.org> wrote:

> Hi Alan,
> 
> In 2.6.23 and previous, CD writing works fine on my system. I'm using 
> ata_piix on:
> 
> 00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA 
> IDE Controller (rev 01)
> 
> When I'm running CD writing utilities, I sometimes see this message in 
> the kernel logs:
> 	ata2.00: 66 bytes trailing data
> Things do work fine though.

By luck in part I suspect. That shouldn't be happening and indicates
something is very wrong. With the fifo buffers set right that may well
get worse.

> git bisect lead me to commit 2db78dd302d26d242d3e8e5c4c5024b6c3ea93c2 as 
> the culprit.
> 
> Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date:   Tue Oct 2 13:53:04 2007 -0700
> 
>      libata_scsi: Fix ATAPI transfer lengths
> 
>      Some controller variants snoop the ATAPI length value for Packet
>      transfers to do state machine and FIFO management. Thus we want to
>      set it properly, even for cases where it is otherwise meaningless.
> 
> Any ideas?

Not immediately - but if you've got wrong transfer lengths its a
candidate for this.

Ok lets start with the basics

If you mount a CD and use it does it work
If you use cdrecord does it work ?

What vendor drive and does it seem to be a specific box/drive that
triggers this ?

Alan
