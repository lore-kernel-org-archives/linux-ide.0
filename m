From: Mark Lord <liml@rtr.ca>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Mon, 25 Feb 2008 19:28:29 -0500
Message-ID: <47C35D2D.106@rtr.ca>
References: <47C3572D.1060904@rtr.ca> <47C35BD7.8040107@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1441 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253AbYBZAZm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 19:25:42 -0500
In-Reply-To: <47C35BD7.8040107@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> As an aside, ISTR tomo-san was working on eliminating the need for the 
> "/2" by tackling the details on the IOMMU side...
..

Yes, tomo-san just led a nice detailed discussion of it here at LSF'08,
and he agrees that even today it shouldn't affect us that way.

Cheers
