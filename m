From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: DMA breakage in 2.6.29-rc*
Date: Fri, 30 Jan 2009 13:17:49 +0100
Message-ID: <18818.61421.549546.38274@harpo.it.uu.se>
References: <1233294371.18767.23.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:36859 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbZA3MSE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 07:18:04 -0500
In-Reply-To: <1233294371.18767.23.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, list linux-ide <linux-ide@vger.kernel.org>

Benjamin Herrenschmidt writes:
 > Hi Bart !
 > 
 > On a bunch of pmac's, I'm getting lost interrupts when trying to do DMA
 > with ide hard disks (first time at boot when reading the partition
 > table). It then times out, reverts to PIO and boots fine.
 > 
 > Haven't had time to fully bisect yet, but it seem to be somewhere in the
 > pile of IDE patches (surprise :-) that went in around that time.

On a slightly related note, any update on the pata_macio driver
you posted last summer? As I recall, it worked ok on my G4, except
for some OF/yaboot mismatch which broke ydl's /sbin/installkernel.
