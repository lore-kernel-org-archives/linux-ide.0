From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Wed, 27 Aug 2008 20:06:59 +0300
Message-ID: <c70ff3ad0808271006ge3e615akcafbb8049f3f5c9f@mail.gmail.com>
References: <200808261124.39282.elendil@planet.nl> <48B40D2A.1090109@rtr.ca>
	 <20080827145620.GJ3622@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:61946 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbYH0RHB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Aug 2008 13:07:01 -0400
Received: by gxk10 with SMTP id 10so4314376gxk.13
        for <linux-ide@vger.kernel.org>; Wed, 27 Aug 2008 10:07:00 -0700 (PDT)
In-Reply-To: <20080827145620.GJ3622@deprecation.cyrius.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Mark Lord <liml@rtr.ca>, Frans Pop <elendil@planet.nl>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

>
> I'm being told that there's a standard LED control bit on Orion, but
> hopefully Saeed can comment.  If it's a QNAP specific problem, I can
> talk to my contacts at QNAP.

bit 0 of 0x8002c controls the active LED, 1 makes it blink slower
(more user friendly).
I checked 2.6.26 on rd5182 and both LEDs work fine. it's probably QNAP
specific problem.
Frans, can you please try the patch at
http://www.spinics.net/lists/linux-ide/msg25093.html
if it still doesn't work please check the value of the register at
0xf1010004 (MPPs control).


saeed
