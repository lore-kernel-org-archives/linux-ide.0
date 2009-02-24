From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [RFC][PATCH] sata_mv: harddisk activity led no longer responsive
	on QNAP TS-109
Date: Tue, 24 Feb 2009 11:33:52 +0200
Message-ID: <c70ff3ad0902240133o7558beeay563c89defd35e575@mail.gmail.com>
References: <200808261124.39282.elendil@planet.nl>
	 <200808261225.46315.elendil@planet.nl> <497B2C60.60608@rtr.ca>
	 <200902240933.45874.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f167.google.com ([209.85.220.167]:55504 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbZBXJd4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Feb 2009 04:33:56 -0500
In-Reply-To: <200902240933.45874.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Mark Lord <liml@rtr.ca>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

>> There is a reported chipset errata for *exactly* this symptom,
>> though the errata is supposedly for the older 6041/6081 variants.
>> But it is possible that the same problem still exists in the
>> chip you are using there (SOC, right?).
That erratum was fixed in the production revisions, beside, that the
blink mode working, but it's responsivness is not good enough as when
NCQ disabled.
   What I think is that this issue is seen with the specific disk that
you have, the chip blinks the LED depending on the BUSY bit status,
and I suspect that with the disk you have does clear that bit
immediately after receiving the command FIS, so the LED will be off,
though the command is not completed yet, and this makes the led
responsiveness differ that in NCQ-disabled mode.

> In the blink mode the led is not as responsive as when NCQ is disabled,
> but at least it does show when there is I/O. If I disable NCQ by setting
> queue_depth to 1, blink mode is disabled and the led behaves as with
> pre-2.6.26 kernels.
>
> I've done my best to make the implementation as cheap as possible.
>
> One question I have is whether _all_ SOCs need this quirk or if we should
> test for a model or revision. Is there model/revision info available for SOC?
   if my understanding if the issue is correct, then this should apply
for all devices besides to the SOC.
