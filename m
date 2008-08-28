From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Fri, 29 Aug 2008 00:40:06 +0200
Message-ID: <200808290040.08447.elendil@planet.nl>
References: <200808261045.33241.elendil@planet.nl> <200808282043.46032.elendil@planet.nl> <c70ff3ad0808281508q46ef7a8ahca5d0c2a325b2d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpo-eml03.kpnxchange.com ([213.75.38.152]:59844 "EHLO
	cpsmtpo-eml03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754043AbYH1WkL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 18:40:11 -0400
In-Reply-To: <c70ff3ad0808281508q46ef7a8ahca5d0c2a325b2d2e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>

On Friday 29 August 2008, saeed bishara wrote:
> > $ sudo devmem2 0xf108002c w 1
> > /dev/mem opened.
> > Memory mapped at address 0x4001f000.
> > Value at address 0xF108002C (0x4001f02c): 0x0
> > Written 0x1; readback 0x1
> >
> > After that the HDD led does react again to io activity.
>
> do you mean it's blinking on io activity?

Yes.

> is it off when no io running? 

No. It is on when there is no activity, but that is how it has always 
been. Same as the LAN led which is also always on when there is a 
connection and blinks on activity.

I don't know if that's how that's intended, but IMHO it makes sense for an 
embedded device to have the led on by default to show the device is
"present and recognized" and to blink when there is activity.

Cheers,
FJP
