From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Thu, 15 Mar 2007 19:16:39 +0000
Message-ID: <20070315191639.7aadf9a3@lxorguk.ukuu.org.uk>
References: <354573.23811.qm@web803.biz.mail.mud.yahoo.com>
	<45F9851E.8000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42974 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751010AbXCOSNd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 14:13:33 -0400
In-Reply-To: <45F9851E.8000709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bob Stewart <bob@evoria.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

> both the reading and writing are seriously broken.  I can't tell whether
> they end up in the wrong sectors or garbage is transferred to/from the
> right sectors.

Does this occur regardless of which interface you use (the register
shadow or the DMA command engine ?)


