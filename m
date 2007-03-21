From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] libata hpa support
Date: Wed, 21 Mar 2007 13:41:44 -0400
Message-ID: <46016E58.5010509@garzik.org>
References: <20070223170625.GA29931@athena.road.mcmartin.ca>	<20070321130140.GA4328@athena.road.mcmartin.ca> <20070321183455.00f4732b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46439 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933227AbXCURls (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Mar 2007 13:41:48 -0400
In-Reply-To: <20070321183455.00f4732b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kyle McMartin <kyle@canonical.com>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

Alan Cox wrote:
> It may also fail to allow any resizing if the Macbook issues a security
> freeze from the firmware before the OS boots, if so we won't be able to
> resize the HPA or set/change passwords on the disk. If they are doing
> that then its a fairly sensible security choice.


That reminds me, there have been suggestions in the past that we should 
do a security freeze after probing and configuring.

	Jeff


