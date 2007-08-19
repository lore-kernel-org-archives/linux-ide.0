From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Sun, 19 Aug 2007 17:56:32 +0100
Message-ID: <20070819175632.349d11c5@the-village.bc.nu>
References: <46C69913.1060505@g7.org>
	<46C799E8.8080407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44473 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753435AbXHSQsq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Aug 2007 12:48:46 -0400
In-Reply-To: <46C799E8.8080407@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Malcolm Gillies <malcolm@g7.org>, linux-ide@vger.kernel.org

> I don't think we can safely assume that UDMA can co-operate with non-UDMA
> on the same cable.  In this case, it might be causing the CF device to falsely
> detect control cycles.

Improbable and never observed. The PIO address setup timing requires care
but not the rest, and especially not UDMA where you've got different
signalling and different timing active.

Sounds to me like the usual case of people putting CF convertors onto
spec compliant cables and ending up with electrical problems. If you
stick additional connectors, wires and plugs onto the cable it goes out
of spec.
