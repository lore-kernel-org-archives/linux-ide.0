From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata.h: Don't do a SATA check for 40wire_relaxed
Date: Sat, 24 Nov 2007 13:46:18 +0000
Message-ID: <20071124134618.697217f0@the-village.bc.nu>
References: <20071119152434.45363e5d@the-village.bc.nu>
	<47477D1B.9050305@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54290 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751063AbXKXNtB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Nov 2007 08:49:01 -0500
In-Reply-To: <47477D1B.9050305@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Fri, 23 Nov 2007 20:23:39 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > Without the valid bits at least one set of TSScorp drives report 0 in
> > word 93 for PATA 40 wire, which we (and the specs) say actually means
> > SATA. (The SATA version seems to report 80 wire...)
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> SATA version on what controller?  Have you verified where the bridge is, 
> if it's not reporting word93==0 ?

PATA you see 0x0000 for 40 wire, 0x2000 for 80 wire (no valid bits), and
for SATA (no bridges or if present in the drive) 0x2000

Alan
