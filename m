From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Thu, 1 Nov 2007 10:53:35 +0000
Message-ID: <20071101105335.1f20bab3@the-village.bc.nu>
References: <47274A5F.6070409@gentoo.org>
	<20071030153417.59b9182c@the-village.bc.nu>
	<47276DCA.1000808@gentoo.org>
	<20071030190153.373c9347@the-village.bc.nu>
	<47278439.4030801@gentoo.org>
	<20071031114958.210bd7cc@the-village.bc.nu>
	<20071031115754.GK5059@kernel.dk>
	<4729A0DF.20800@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:60776 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756473AbXKAKxC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2007 06:53:02 -0400
In-Reply-To: <4729A0DF.20800@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Daniel Drake <dsd@gentoo.org>, linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Albert Lee <albertcc@tw.ibm.com>

> demonstrated by (a) Alan's patch did not change DMA lbam/lbah 
> programming and (b) Daniel's report of the message "ata2.00: 66 bytes 

(a) did. Well the original did, dunno about your version.

> I am not drawing any conclusions yet, but I'm thinking that blimit=8k 
> may be a better choice for SATA ATAPI.

Only if your transfer is actually 8K or more.


Alan
