From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Thu, 29 Nov 2007 16:05:55 +0000
Message-ID: <20071129160555.38ee2edc@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468202627-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40241 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754218AbXK2QKk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:10:40 -0500
In-Reply-To: <11963468202627-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Tejun Heo <htejun@gmail.com>

> Private command type / transfer length filtering in sata_promise,
> pata_it821x and pata_pdc2027x are removed as core layer filtering is
> more conservative.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK - as before

This is the wrong way to do stuff. Stop penalizing the 99.99% of users
with perfectly sane hardware. In addition I note that the whitelist for
drives would rapidly be thousands of entries long and unmanagable.

Blacklist the problem drives - there aren't that many as far as I can see
from Fedora. Also don't confuse this with the pata_ali ATAPI problems
which are most of the ones I do find.

Alan
