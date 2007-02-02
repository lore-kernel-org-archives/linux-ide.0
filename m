From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Fri, 2 Feb 2007 10:08:56 +0000
Message-ID: <20070202100856.706bd1e8@localhost.localdomain>
References: <20070202063748.GC1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44631 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932861AbXBBJ4f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 04:56:35 -0500
In-Reply-To: <20070202063748.GC1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> Note that both normal commands and EH commands timeouts are adjusted
> to 7 secs, but cache flushses still have 30sec timeout.  This is a
> side effect of the way sd makes use of sdev->timeout, but this is a
> good side effect in that ATA spec requires cache flushes are given
> longer timeout.

Our cache flush handling still appears to be questionable if not wrong.
Not sure how SCSI expects it to behave but for ATA we should call it
again on a fatal media error.


ACK to the patch itself.
