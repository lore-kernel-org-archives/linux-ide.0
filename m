From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Thu, 27 Mar 2008 15:31:00 +0000
Message-ID: <20080327153100.6d834986@core>
References: <12066128663306-git-send-email-htejun@gmail.com>
	<47EBAE2B.8070102@rtr.ca>
	<47EBB09F.9070607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49875 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756069AbYC0PsF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 11:48:05 -0400
In-Reply-To: <47EBB09F.9070607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org

> In 18 years of IDE/ATA development,
> I have *never* seen a hard disk drive report a WRITE error.

You don't try hard enough. Also a cache flush write error is more likely
than a write reporting the error, because with caching enabled the disk
only finds out when it comes to try and flush or you do.

> Which makes sense, if you think about it -- it's rewriting the sector
> with new ECC info, so it *should* succeed.  The only case where it won't,
> is if the sector has been marked as "bad" internally, and the drive is
> too dumb to try anyways after it runs out of remap space.

Or you have a drive with raid optimised firmware, a magneto-optical or
other similar cases.

Alan
