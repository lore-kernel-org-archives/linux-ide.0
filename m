From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 8/8] libata: ack more unsolicited INTRQ
Date: Wed, 16 May 2007 14:02:01 +0100
Message-ID: <20070516140201.29d0f6f0@the-village.bc.nu>
References: <464AACDF.1030903@tw.ibm.com>
	<464AB2F3.7030103@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36377 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758648AbXEPM6G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 08:58:06 -0400
In-Reply-To: <464AB2F3.7030103@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

> As previously discussed, the possible issue with this patch is:
> Some ATA/ATAPI devices might be unhappy if the STATUS register
> is read during data transfer (not sure if this is true or not).
> (Patch 5/8 doesn't have such issue.) 

Some older intel eats your disk if you do that.

Neither of these approaches quite work. Much as I dislike the "old IDE"
disable/enable irq approach it does look like that is the only safe
answer for some controllers.

Alan
--
