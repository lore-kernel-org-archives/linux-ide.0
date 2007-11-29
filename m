From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Thu, 29 Nov 2007 17:38:50 +0000
Message-ID: <20071129173850.1c36fcd6@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468202627-git-send-email-htejun@gmail.com>
	<20071129160555.38ee2edc@the-village.bc.nu>
	<474EE561.7010207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:32772 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754325AbXK2RoI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 12:44:08 -0500
In-Reply-To: <474EE561.7010207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

> If we're gonna take that road, let's lift 16 byte alignment check during
> -rc cycles.  It's something which masks the problem half way.  It only
> hinders the debugging process.

That would be a good project for the -mm tree. Perhaps lift it to 2, and
also see what happens if the DMA padding is set to 2 or to 16 - as for
some cases this could be a controller limit.

Alan
