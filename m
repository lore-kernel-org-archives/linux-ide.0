From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc6] sata_inic162x: add big fat warning about broken
 LBA48 support
Date: Thu, 28 Jun 2007 13:51:24 -0400
Message-ID: <4683F51C.3060404@garzik.org>
References: <4683DCD3.1040303@gmail.com> <4683F4CD.2090106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50802 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758581AbXF1Rv1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jun 2007 13:51:27 -0400
In-Reply-To: <4683F4CD.2090106@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>> sata_inic162x can't do LBA48 properly yet.  Whine loudly about it to
>> reduce confusion.
> 
> Why not whine only when an affected device is actually present?

That's sorta that I think...

	Jeff



