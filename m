From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: check cdb len per dev instead of per host
Date: Thu, 1 Feb 2007 17:16:13 +0000
Message-ID: <20070201171613.72091b81@localhost.localdomain>
References: <45C21C21.2060800@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41957 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751823AbXBAREN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 12:04:13 -0500
In-Reply-To: <45C21C21.2060800@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, 01 Feb 2007 11:58:09 -0500
Mark Lord <liml@rtr.ca> wrote:

> Fix libata to perform CDB len validation per device
> rather than per host.  This way, validation still works
> when we have a mix of 12-byte and 16-byte devices on
> a common host interface.#

Users can pass 16byte commands in the "safe" list of commands so can spam
the log via the printk

NAK

