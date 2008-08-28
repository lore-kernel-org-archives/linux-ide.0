From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Thu, 28 Aug 2008 20:43:44 +0200
Message-ID: <200808282043.46032.elendil@planet.nl>
References: <200808261045.33241.elendil@planet.nl> <200808281911.28484.elendil@planet.nl> <20080828181136.GC24539@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpo-eml04.kpnxchange.com ([213.75.38.153]:41297 "EHLO
	cpsmtpo-eml04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752842AbYH1Snt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 14:43:49 -0400
In-Reply-To: <20080828181136.GC24539@xi.wantstofly.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: saeed bishara <saeed.bishara@gmail.com>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>

On Thursday 28 August 2008, Lennert Buytenhek wrote:
> On Thu, Aug 28, 2008 at 07:11:27PM +0200, Frans Pop wrote:
> > > can you try setting bit 0 of the 0xf108002c then run some io?
>
> Can you try devmem2?

OK, that works better:

$ sudo devmem2 0xf108002c w 1
/dev/mem opened.
Memory mapped at address 0x4001f000.
Value at address 0xF108002C (0x4001f02c): 0x0
Written 0x1; readback 0x1

After that the HDD led does react again to io activity.
