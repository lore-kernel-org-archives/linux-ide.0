From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for ATA_16 commands to ATAPI devices
Date: Wed, 03 Jan 2007 09:18:26 -0500
Message-ID: <459BBB32.8050203@rtr.ca>
References: <200701021939.10496.liml@rtr.ca>	<459AFDC2.6060900@garzik.org>	<20070103010724.19b17522@localhost.localdomain>	<459B42C5.2080804@rtr.ca> <20070103113415.707f4ab3@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1998 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbXACOS2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jan 2007 09:18:28 -0500
In-Reply-To: <20070103113415.707f4ab3@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Alan wrote:
>
> I know it currently does this, the more important question for the ATA
> side is - should it ? 

No.  That's why we now have a patch in play to tell it not to.  ;)

Cheers!
