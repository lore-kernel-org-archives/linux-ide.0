From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: stable basic 4-port SATA card
Date: Thu, 13 Dec 2007 15:09:05 +0100
Message-ID: <18273.15617.119611.820953@harpo.it.uu.se>
References: <200711151001.lAFA11wC019059@harpo.it.uu.se>
	<fjrci9$v8o$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:41342 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbXLMOJK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Dec 2007 09:09:10 -0500
In-Reply-To: <fjrci9$v8o$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patric Karlsson <patric@ce.chalmers.se>
Cc: linux-ide@vger.kernel.org

Patric Karlsson writes:
 > Mikael Pettersson wrote:
 > > On Thu, 15 Nov 2007 12:32:14 +0900, Tejun Heo wrote:
 > >> * sata_promise: Generally works okay; however there are still some
 > >> problems with recent 3Gbps chips. (Mikael, please pitch in)
 > > 
 > > Right, 2nd-gen 3Gbps chips have had "intermittent" issues,
 > > which we hope are cured by the recent ASIC bug workaround,
 > > but it will take a while for that fix to propagate out.
 > > To speed up that process I'm considering backporting the fix
 > > to 2.6.23 and 2.6.22.
 > > 
 > > NCQ and PMP are supported in the hardware and in the vendor's
 > > driver, but not yet in sata_promise. My intention is to add
 > > NCQ soon, but there's no time-plan yet for this.
 > > 
 > > /Mikael
 > > -
 > > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
 > > the body of a message to majordomo@vger.kernel.org
 > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > > 
 > 
 > Backporting would be nice, since we're still some ways from a stable 
 > 2.6.24, and I'm not comfortable running -rc kernels in production 
 > enviroments.

Ok.

For 2.6.23 there is one patch:

<http://user.it.uu.se/~mikpe/linux/patches/sata_promise/patch-sata_promise-1-asic-sg-bug-fix-v3-2.6.23>
This is the workaround for the ASIC PRD/SG bug.

For 2.6.22 there are two patches:

<http://user.it.uu.se/~mikpe/linux/patches/sata_promise/patch-sata_promise-1-ft_tx4200-is-gen2-2.6.22>
This corrects the classification of FastTrack TX4200 cards,
which in turn fixes nasty errors in how they are accessed.

<http://user.it.uu.se/~mikpe/linux/patches/sata_promise/patch-sata_promise-2-asic-sg-bug-fix-v3-2.6.22>
This is the workaround for the ASIC PRD/SG bug.

/Mikael
