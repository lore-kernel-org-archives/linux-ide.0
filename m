From: Frans Pop <elendil@planet.nl>
Subject: Re: [RFC][PATCH] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Sun, 1 Mar 2009 13:44:17 +0100
Message-ID: <200903011344.18888.elendil@planet.nl>
References: <200808261124.39282.elendil@planet.nl> <c70ff3ad0902240133o7558beeay563c89defd35e575@mail.gmail.com> <20090301075956.GA28039@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml17.KPNXCHANGE.COM ([213.75.38.117]:13473 "EHLO
	hpsmtp-eml17.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752693AbZCAM7e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Mar 2009 07:59:34 -0500
In-Reply-To: <20090301075956.GA28039@deprecation.cyrius.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: saeed bishara <saeed.bishara@gmail.com>, Mark Lord <liml@rtr.ca>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Sunday 01 March 2009, Martin Michlmayr wrote:
> * saeed bishara <saeed.bishara@gmail.com> [2009-02-24 11:33]:
> > What I think is that this issue is seen with the specific disk that
> > you have, the chip blinks the LED depending on the BUSY bit status,
> > and I suspect that with the disk you have does clear that bit
> > immediately after receiving the command FIS, so the LED will be off,
> > though the command is not completed yet, and this makes the led
> > responsiveness differ that in NCQ-disabled mode.
>
> The LED issue was reported by two people on the QNAP forum the other
> day.  I asked what disks they had and one has a WDC WD7500AACS-00D6B0
> whereas the other one has a WDC WD10EADS-00L5B1.  Do you also use a
> WDC disk, Frans?

I always was rather doubtful of Saeed's analysis (with all due respect), 
but it's good to see confirmed that the same problem manifests with other 
disks too.

I have a completely different HD:
Model Family:     Hitachi Deskstar T7K250 series
Device Model:     HDT722516DLA380
Firmware Version: V43OA91A
User Capacity:    164,696,555,520 bytes

Cheers,
FJP
