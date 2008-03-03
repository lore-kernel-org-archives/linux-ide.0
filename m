From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: locking problem in sata_sil24?
Date: Tue, 04 Mar 2008 09:58:15 +1100
Message-ID: <1204585095.21545.37.camel@pasglop>
References: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
	 <1204583866.21545.31.camel@pasglop>
	 <DCEAAC0833DD314AB0B58112AD99B93B0410A575@ismail.innsys.innovsys.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38692 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754527AbYCCW66 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Mar 2008 17:58:58 -0500
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0410A575@ismail.innsys.innovsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


On Mon, 2008-03-03 at 16:44 -0600, Rune Torgersen wrote:
> Benjamin Herrenschmidt wrote:
> > On Mon, 2008-03-03 at 16:10 -0600, Rune Torgersen wrote:
> >> Hi I am trying to get PREEMPT_RT pach to wokr on my 2.6.24 kernel,
> 
> > What core is in the 8280 ? At this stage, I wouldn't rule out a bug in
> > the lockdep patches, I need to do more work on them.
> 
> Should be an 603e
> adn revision (from u-boot)
> CPU:   MPC8280 (HiP7 Rev 14, Mask 1.0 1K49M) at 447.897 MHz
> 
> 
> 
> I am currently compiling a LOCKDEP kernel for my x86 desktop, as it has
> the exact same SiliconImage controller on a card, so I'll see if it gets
> a similar detection.

In fact, I remember working on 64 bits lockdep, based on patches from
Johannes, but I didn't do 32 bits. I think somebody worked on it, but
now I can't find the patches...

Whoever did it can bounce them back to me ? I intend to do some more
work on this soon.

Cheers,
Ben.

