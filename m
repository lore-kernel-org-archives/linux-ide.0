From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Thu, 28 Aug 2008 11:25:12 +0200
Message-ID: <200808281125.14012.elendil@planet.nl>
References: <200808261045.33241.elendil@planet.nl> <c70ff3ad0808271029u7f53f5ffkd44eacd996da5cb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml13.kpnxchange.com ([213.75.38.113]:14356 "EHLO
	hpsmtp-eml13.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112AbYH1JZQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 05:25:16 -0400
In-Reply-To: <c70ff3ad0808271029u7f53f5ffkd44eacd996da5cb2@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: linux-arm-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Wednesday 27 August 2008, saeed bishara wrote:
> Frans, does the LED stay "on" even when there is no disk activity?

Yes, it does.

On Wednesday 27 August 2008, saeed bishara wrote:
> > I'm being told that there's a standard LED control bit on Orion, but
> > hopefully Saeed can comment.  If it's a QNAP specific problem, I can
> > talk to my contacts at QNAP.
>
> bit 0 of 0x8002c controls the active LED, 1 makes it blink slower
> (more user friendly).
> I checked 2.6.26 on rd5182 and both LEDs work fine. it's probably QNAP
> specific problem.
> Frans, can you please try the patch at
> http://www.spinics.net/lists/linux-ide/msg25093.html

That patch does not seem to make any difference.

> if it still doesn't work please check the value of the register at
> 0xf1010004 (MPPs control).

$ sudo ./bin/devmem2 0xf1010004
/dev/mem opened.
Memory mapped at address 0x4001f000.
Value at address 0xF1010004 (0x4001f004): 0x55550000

Thanks,
FJP
