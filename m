From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Mon, 25 Feb 2008 19:22:47 -0500
Message-ID: <47C35BD7.8040107@pobox.com>
References: <47C3572D.1060904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34168 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755498AbYBZAWv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 19:22:51 -0500
In-Reply-To: <47C3572D.1060904@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

As an aside, ISTR tomo-san was working on eliminating the need for the 
"/2" by tackling the details on the IOMMU side...

	Jeff



