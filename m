From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] linux-next: Tree for April 10 - kernel panic while
 loading ata driver on powermac
Date: Thu, 10 Apr 2008 12:32:30 +0100
Message-ID: <20080410123230.7203f626@core>
References: <20080410181404.b76939a6.sfr@canb.auug.org.au>
	<47FDEAFA.10407@linux.vnet.ibm.com>
	<47FDEFC8.9070105@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33447 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754268AbYDJLyR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Apr 2008 07:54:17 -0400
In-Reply-To: <47FDEFC8.9070105@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Thu, 10 Apr 2008 06:45:28 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Kamalesh Babulal wrote:
> > Hi Stephen,
> > 
> > The next-20080410 kernel panics while bootup over the PowerMac G5 box, while
> > loading the ATA driver.
> 
> IDE driver, you mean.

Jeff - we may in the kernel world use IDE v ATA to distinguish between
the two drivers but both are still ATA drives and I don't think its too
fair to respond this way, especially to someone who has gone to the
trouble of capturing a very good trace.

Alan
