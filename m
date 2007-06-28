From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2.6.22-rc6] sata_inic162x: add big fat warning about broken
 LBA48 support
Date: Thu, 28 Jun 2007 13:50:05 -0400
Message-ID: <4683F4CD.2090106@rtr.ca>
References: <4683DCD3.1040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4200 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759272AbXF1Rt1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jun 2007 13:49:27 -0400
In-Reply-To: <4683DCD3.1040303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> sata_inic162x can't do LBA48 properly yet.  Whine loudly about it to
> reduce confusion.

Why not whine only when an affected device is actually present?

Cheers from OLS.
