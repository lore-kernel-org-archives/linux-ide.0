From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: DMA breakage in 2.6.29-rc*
Date: Sat, 31 Jan 2009 07:45:46 +1100
Message-ID: <1233348346.18767.26.camel@pasglop>
References: <1233294371.18767.23.camel@pasglop>
	 <18818.61421.549546.38274@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55789 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501AbZA3UrG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 15:47:06 -0500
In-Reply-To: <18818.61421.549546.38274@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, list linux-ide <linux-ide@vger.kernel.org>

On Fri, 2009-01-30 at 13:17 +0100, Mikael Pettersson wrote:
> Benjamin Herrenschmidt writes:
>  > Hi Bart !
>  > 
>  > On a bunch of pmac's, I'm getting lost interrupts when trying to do DMA
>  > with ide hard disks (first time at boot when reading the partition
>  > table). It then times out, reverts to PIO and boots fine.
>  > 
>  > Haven't had time to fully bisect yet, but it seem to be somewhere in the
>  > pile of IDE patches (surprise :-) that went in around that time.
> 
> On a slightly related note, any update on the pata_macio driver
> you posted last summer? As I recall, it worked ok on my G4, except
> for some OF/yaboot mismatch which broke ydl's /sbin/installkernel.

I needs more work and I didn't get a chance to do that yet.. It will
need yaboot's ofboot script to be updated too, unfortunately, as it hard
codes things specific to ide-pmac.

Cheers,
Ben.


