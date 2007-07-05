From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc7] libata: quirk IOMEGA ZIP 250 ATAPI FLOPPY
Date: Thu, 05 Jul 2007 19:53:38 -0400
Message-ID: <468D8482.9040203@garzik.org>
References: <20070705033131.GW29122@htj.dyndns.org> <20070705133926.66050cce@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52001 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760266AbXGEXxm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jul 2007 19:53:42 -0400
In-Reply-To: <20070705133926.66050cce@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, bruinjm@xs4all.nl

Alan Cox wrote:
>> but IDE simply ignores the error and continues to operate in MWDMA
>> mode, so I guess we can remove the 'temporary fix' comment or add
>> another quirk type - ATA_HORKAGE_SETXFER_MAY_FAIL - and use it.
> 
> Should we warn in these cases ? Or issue a new identify and check the
> mode activated ?

The latter, issuing a new identify, is really what you want to do. 
AFAICT that's the canonical method of querying the device's knowledge of 
its mode settings.

	Jeff



