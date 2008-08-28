From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Fri, 29 Aug 2008 01:08:23 +0300
Message-ID: <c70ff3ad0808281508q46ef7a8ahca5d0c2a325b2d2e@mail.gmail.com>
References: <200808261045.33241.elendil@planet.nl>
	 <200808281911.28484.elendil@planet.nl>
	 <20080828181136.GC24539@xi.wantstofly.org>
	 <200808282043.46032.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.236]:21081 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbYH1WIY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 18:08:24 -0400
Received: by qb-out-0506.google.com with SMTP id f11so1158249qba.17
        for <linux-ide@vger.kernel.org>; Thu, 28 Aug 2008 15:08:24 -0700 (PDT)
In-Reply-To: <200808282043.46032.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>

> $ sudo devmem2 0xf108002c w 1
> /dev/mem opened.
> Memory mapped at address 0x4001f000.
> Value at address 0xF108002C (0x4001f02c): 0x0
> Written 0x1; readback 0x1
>
> After that the HDD led does react again to io activity.
do you mean it's blinking on io activity? is it off when no io running?

saeed
