From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 15/15] libata: use PIO for misc ATAPI commands
Date: Wed, 5 Dec 2007 13:00:21 +0000
Message-ID: <20071205130021.0d7f32e8@the-village.bc.nu>
References: <11968405951262-git-send-email-htejun@gmail.com>
	<11968405983276-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42871 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751442AbXLENFe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 08:05:34 -0500
In-Reply-To: <11968405983276-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Tejun Heo <htejun@gmail.com>

> Private command type / transfer length filtering in sata_promise,
> pata_it821x and pata_pdc2027x are removed as core layer filtering is
> more conservative.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK same reasons as the three previous times it was posted.

