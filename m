From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
Date: Sun, 25 Jun 2006 00:17:31 +0100
Message-ID: <1151191051.8676.44.camel@localhost.localdomain>
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net>
	 <449DBE88.5020809@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14755 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964870AbWFXXCV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 19:02:21 -0400
In-Reply-To: <449DBE88.5020809@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, castet.matthieu@free.fr, B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>

SETFEATURES_XFER stuff is magic anyway because some controllers snoop.
Also of course like the old IDE we send some rather iffy PIO requests
and that might have something to do with the problem of course.

I've got two reports that look similar and are from ALi controllers so
trying the 10uS version might be worth doing, at least for PATA

