From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc7] libata: quirk IOMEGA ZIP 250 ATAPI FLOPPY
Date: Fri, 06 Jul 2007 15:42:50 +0900
Message-ID: <468DE46A.6080908@gmail.com>
References: <20070705033131.GW29122@htj.dyndns.org> <20070705133926.66050cce@the-village.bc.nu> <468D8482.9040203@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:50476 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759989AbXGFGm4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jul 2007 02:42:56 -0400
Received: by nz-out-0506.google.com with SMTP id s18so118601nze
        for <linux-ide@vger.kernel.org>; Thu, 05 Jul 2007 23:42:56 -0700 (PDT)
In-Reply-To: <468D8482.9040203@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, bruinjm@xs4all.nl

Jeff Garzik wrote:
> Alan Cox wrote:
>>> but IDE simply ignores the error and continues to operate in MWDMA
>>> mode, so I guess we can remove the 'temporary fix' comment or add
>>> another quirk type - ATA_HORKAGE_SETXFER_MAY_FAIL - and use it.
>>
>> Should we warn in these cases ? Or issue a new identify and check the
>> mode activated ?
> 
> The latter, issuing a new identify, is really what you want to do.
> AFAICT that's the canonical method of querying the device's knowledge of
> its mode settings.

How about just keep using PIO as the patch posted in this thread does?
I'm not really sure adding more complexity is worth it considering it's
only one device till now and it may not even be safe considering that
some controllers snoop SETXFER and configure themselves accordingly.

-- 
tejun
