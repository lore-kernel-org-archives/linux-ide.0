From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc6] sata_inic162x: add big fat warning about broken
 LBA48 support
Date: Fri, 29 Jun 2007 02:53:53 +0900
Message-ID: <4683F5B1.7090507@gmail.com>
References: <4683DCD3.1040303@gmail.com> <4683F4CD.2090106@rtr.ca> <4683F51C.3060404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:24152 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762321AbXF1Rx6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 13:53:58 -0400
Received: by nz-out-0506.google.com with SMTP id s18so181882nze
        for <linux-ide@vger.kernel.org>; Thu, 28 Jun 2007 10:53:57 -0700 (PDT)
In-Reply-To: <4683F51C.3060404@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> sata_inic162x can't do LBA48 properly yet.  Whine loudly about it to
>>> reduce confusion.
>>
>> Why not whine only when an affected device is actually present?
> 
> That's sorta that I think...

That was me being lazy.  I'll just ban > LBA28 disks on the controller.

-- 
tejun
