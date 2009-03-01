From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [RFC][PATCH] sata_mv: harddisk activity led no longer
	responsive on QNAP TS-109
Date: Sun, 1 Mar 2009 08:59:56 +0100
Message-ID: <20090301075956.GA28039@deprecation.cyrius.com>
References: <200808261124.39282.elendil@planet.nl> <200808261225.46315.elendil@planet.nl> <497B2C60.60608@rtr.ca> <200902240933.45874.elendil@planet.nl> <c70ff3ad0902240133o7558beeay563c89defd35e575@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:58913 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbZCAIAK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Mar 2009 03:00:10 -0500
Content-Disposition: inline
In-Reply-To: <c70ff3ad0902240133o7558beeay563c89defd35e575@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Frans Pop <elendil@planet.nl>, Mark Lord <liml@rtr.ca>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

* saeed bishara <saeed.bishara@gmail.com> [2009-02-24 11:33]:
> What I think is that this issue is seen with the specific disk that
> you have, the chip blinks the LED depending on the BUSY bit status,
> and I suspect that with the disk you have does clear that bit
> immediately after receiving the command FIS, so the LED will be off,
> though the command is not completed yet, and this makes the led
> responsiveness differ that in NCQ-disabled mode.

The LED issue was reported by two people on the QNAP forum the other
day.  I asked what disks they had and one has a WDC WD7500AACS-00D6B0
whereas the other one has a WDC WD10EADS-00L5B1.  Do you also use a
WDC disk, Frans?

References:
http://forum.qnap.com/viewtopic.php?f=147&t=1344&start=220#p55925
http://forum.qnap.com/viewtopic.php?f=147&t=1344&start=220#p56027
http://forum.qnap.com/viewtopic.php?f=147&t=1344&start=230#p56351
-- 
Martin Michlmayr
http://www.cyrius.com/
