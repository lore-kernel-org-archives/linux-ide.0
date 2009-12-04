From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Fri, 4 Dec 2009 00:17:11 +0000
Message-ID: <20091204001711.2c2af9cc@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<200912031339.14440.bzolnier@gmail.com>
	<4B17FB37.2030501@garzik.org>
	<200912032045.48728.bzolnier@gmail.com>
	<4B182A9F.5090708@garzik.org>
	<4B18357E.9050900@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41298 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753564AbZLDAPX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 19:15:23 -0500
In-Reply-To: <4B18357E.9050900@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Likewise I'm happy with all of this stuff. My worry is the turn 32bit on
for hardware without real testing/docs checking except where it was on by
default bits.

The rest is good stuff. The 32bit stuff for the unproven cards could do
longer in -next as its only a performance boost for PIO.
