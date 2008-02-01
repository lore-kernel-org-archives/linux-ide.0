From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH RESEND number 2] libata: eliminate the home grown dma
 padding in favour of that provided by the block layer
Date: Fri, 01 Feb 2008 15:02:59 -0500
Message-ID: <47A37AF3.3030503@garzik.org>
References: <1199138168.3110.12.camel@localhost.localdomain>	 <1200698057.3111.68.camel@localhost.localdomain> <1201894847.3134.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44435 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756204AbYBAUDD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 15:03:03 -0500
In-Reply-To: <1201894847.3134.59.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jens Axboe <Jens.Axboe@oracle.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Tejun Heo <htejun@gmail.com>

James Bottomley wrote:
> Could we please get this in ... I thought I mentioned several times that
> it fixes a fatal oops in both aic94xx and ipr.

Tejun has a persistent objection...  see other email.

	Jeff



