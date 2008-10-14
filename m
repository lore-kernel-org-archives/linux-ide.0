From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Porting old hardware from ide to libata (was [PATCH 0/7] ide: locking improvements)
Date: Tue, 14 Oct 2008 10:05:07 +0200
Message-ID: <18676.21171.712235.629851@harpo.it.uu.se>
References: <20081013234648.41cfca48@lxorguk.ukuu.org.uk>
	<232037.89022.qm@web57407.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:47745 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbYJNIFU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 04:05:20 -0400
In-Reply-To: <232037.89022.qm@web57407.mail.re1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stan.cunningham@yahoo.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Stan Cunningham writes:
 > > Unfortunately the big remaining one (mac support)
 > > didn't happen as the
 > > Mac that dwmw2 loaned me died and as in typical crapple
 > > design style it
 > > needed major surgery with sharpened wall paper scrapers to
 > > even open it
 > > the work didn't get done.
 > 
 > I started a wiki page ( http://ata.wiki.kernel.org/index.php/Hardware_For_Developers ) where developers can list the hardware they need in order to develop libata drivers. I'm sure there are people with unused hardware that they would be be willing to donate to interested developers. Or give money donations so that developers can buy the necessary hardware. Please feel free to add the Apple parts you need to that page.
 > 
 > BTW, I recall there was another attempt at writing a libata driver for Apple hardware, namely pata_macio by Benjamin Herrenschmidt.

I tried pata_macio in a G4 eMac. Worked fine, except that something was
missing in sysfs or OF or whereever causing yaboot to fail to update the
boot loader while that disk was driven by pata_macio.

So I put it on ice waiting for newer versions from Ben, but that never
happened so I forgot about it.
