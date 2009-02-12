From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: EXPORT_SYMBOL_GPL(ata_pio_sectors) ?
Date: Thu, 12 Feb 2009 17:15:17 -0500
Message-ID: <49949F75.5040707@pobox.com>
References: <4994952F.9080006@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57867 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbZBLWPZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Feb 2009 17:15:25 -0500
In-Reply-To: <4994952F.9080006@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun / Jeff,
> 
> Any objections if I EXPORT ata_pio_sectors() for use from sata_mv.c ?
> The code there is complex enough that I'd rather not duplicate it.
> 
> It will be needed for an errata workaround that's being worked on,
> and I'll post a patch for it along with the errata patch once it
> is ready.

That's fine...


