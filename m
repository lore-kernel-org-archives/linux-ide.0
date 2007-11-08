From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes] libata: skip 0xff polling for PATA controllers
Date: Thu, 08 Nov 2007 08:39:46 -0500
Message-ID: <473311A2.9080005@rtr.ca>
References: <47327262.9020004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4796 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541AbXKHNjs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 08:39:48 -0500
In-Reply-To: <47327262.9020004@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Luca Tettamanti <kronos.it@gmail.com>

Tejun Heo wrote:
> In a presentation of true workmanship, pata_ali asserts IRQ
> permanantly if the TF status register is read more than once when
> there's no device attached to the port.
..

Is using the altstatus reg (rather than status reg), when possible,
a better idea here?
