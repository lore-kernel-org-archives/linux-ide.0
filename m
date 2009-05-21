From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: PCI IRQ Pins
Date: Thu, 21 May 2009 18:43:16 +0200
Message-ID: <m3r5yi9zkr.fsf@intrepid.localdomain>
References: <4A13EC76.3020206@hiramoto.org>
	<m3r5ykgd97.fsf@intrepid.localdomain>
	<20090520205151.GC4095@n2100.arm.linux.org.uk>
	<m3zld7cuxk.fsf@intrepid.localdomain> <4A14F160.6080605@hiramoto.org>
	<4A150B9A.7080700@hiramoto.org> <4A1568FB.20508@ru.mvista.com>
	<4A156A21.2060108@hiramoto.org> <4A156E36.6080806@hiramoto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:59452 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167AbZEUQnR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 May 2009 12:43:17 -0400
In-Reply-To: <4A156E36.6080806@hiramoto.org> (Karl Hiramoto's message of "Thu\, 21 May 2009 17\:07\:34 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Karl Hiramoto <karl@hiramoto.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "ath9k-devel@lists.ath9k.org" <ath9k-devel@lists.ath9k.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-ide@vger.kernel.org

Karl Hiramoto <karl@hiramoto.org> writes:

> Sorry, think i misspoke,  after reading the IXP4xx dev manual it says 
> 66Mhz PCI version 2.2.

Typically the PCI clock on IXP4xx is 33 MHz but your board can use any
value from 0 to 66.666 MHz. Most wifi cards don't work with 66 MHz,
though. The only card working @ 66 MHz for me is CM9 (all cards I have
fail to connect the M66EN line to ground, so they simply don't work
instead of forcing 33 MHz clock). They are all based on ath5 chips.
-- 
Krzysztof Halasa
