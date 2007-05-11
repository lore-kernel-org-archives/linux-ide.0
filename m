From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data
 xfer functions
Date: Fri, 11 May 2007 18:38:55 +0100
Message-ID: <20070511183855.65b045bc@the-village.bc.nu>
References: <463EAB4D.3000309@tw.ibm.com>
	<463ED8B9.4060501@gmail.com>
	<463F0B25.40103@tw.ibm.com>
	<463F0DAD.5060307@gmail.com>
	<463F1374.1010100@tw.ibm.com>
	<463F1509.30100@gmail.com>
	<46405F50.5090901@tw.ibm.com>
	<20070508130025.7693980c@the-village.bc.nu>
	<464066A4.1010008@gmail.com>
	<20070508132046.70a4d9ed@the-village.bc.nu>
	<46406C9A.4000802@gmail.com>
	<20070508134540.509f4704@the-village.bc.nu>
	<464073B1.80303@gmail.com>
	<4644192A.8090809@tw.ibm.com>
	<46441CA9.4030109@tw.ibm.com>
	<46447FB5.3040306@gmail.com>
	<46449067.70107@tw.ibm.com>
	<4644A282.4030008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38266 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759162AbXEKRev (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 13:34:51 -0400
In-Reply-To: <4644A282.4030008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

> That would be the cleanest way to do it but I'm not sure whether all
> controllers can live with that.  If I understand correctly, Some
> controllers just have to have the whole transfer done atomically.  I
> think Alan knows much better about this.  Alan?

Those controllers already do a local IRQ disable in their private
->data_xfer method so ought to be ok.
