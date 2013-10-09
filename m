From: arno@natisbad.org (Arnaud Ebalard)
Subject: Re: [BUG,REGRESSION] SATA regression on 12.0-rc4 kernel
Date: Wed, 09 Oct 2013 20:56:39 +0200
Message-ID: <87a9iiuvbs.fsf@natisbad.org>
References: <87vc1ahyft.fsf@natisbad.org>
	<20131007125943.GA1332@titan.lakedaemon.net>
	<87bo303nfe.fsf@natisbad.org> <52537015.6040200@gmail.com>
	<87y564waw0.fsf@natisbad.org>
	<CADLC3L3EYU0VSfLMYjo013jSTWm4yZw24y+4HdvOOoEkOc6uhQ@mail.gmail.com>
	<202B57C13565C241A5ED05E38B705C82012397EC@IRVEXCHMB08.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mic92-1-81-57-185-249.fbx.proxad.net ([81.57.185.249]:36228
	"EHLO smtp.natisbad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab3JIS46 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Oct 2013 14:56:58 -0400
In-Reply-To: <202B57C13565C241A5ED05E38B705C82012397EC@IRVEXCHMB08.corp.ad.broadcom.com>
	(Marc Carino's message of "Wed, 9 Oct 2013 15:22:48 +0000")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Marc (Marc-Angelo) Carino" <mcarino@broadcom.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Marc Carino <marc.ceeeee@gmail.com>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, willy tarreau <w@1wt.eu>, Jason Cooper <jason@lakedaemon.net>

Hi guys,

I went crazy on that one: I managed to reproduce the bug w/ another disk
(Seagate barracuda 7200.9). Then after a 'make clean' on the tree and a
compilation from ground of the stock 3.12-rc4, I never managed to
reproduce the error I had. I tested again with a WD30EFRX, the
WD2500AAJS and the Seagate barracuda 7200.9, all the three in two
different instances of the NAS: the error is gone.

The only logical conclusion is that it was due to some missing 'make
clean' on my tree.

I guess I owe you all some apologies for the noise.

Cheers,

a+

ps: and yes, I hate myself for having overwritten the erroneous image
