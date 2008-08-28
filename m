From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Thu, 28 Aug 2008 19:11:27 +0200
Message-ID: <200808281911.28484.elendil@planet.nl>
References: <200808261045.33241.elendil@planet.nl> <200808281125.14012.elendil@planet.nl> <c70ff3ad0808280353n18967a9frf414091ae768030c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml12.kpnxchange.com ([213.75.38.112]:12870 "EHLO
	hpsmtp-eml12.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752116AbYH1RLf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 13:11:35 -0400
In-Reply-To: <c70ff3ad0808280353n18967a9frf414091ae768030c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Thursday 28 August 2008, saeed bishara wrote:
> can you try setting bit 0 of the 0xf108002c then run some io?

Tried that using Grant's suggestion (thanks!), but setting the bit does 
not seem to take:

$ sudo mmio_rd f108002c 1
0x0000000000000000
$ sudo mmio_wr f108002c 1
0000000000000000 -> 0000000000000001
$ sudo mmio_rd f108002c 1
0x0000000000000000

Am I doing something wrong here?
