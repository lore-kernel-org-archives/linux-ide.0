From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] libata: skip 0xff polling for PATA controllers
Date: Fri, 09 Nov 2007 09:41:33 +0900
Message-ID: <4733ACBD.4020602@gmail.com>
References: <47327262.9020004@gmail.com> <473311A2.9080005@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:40174 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbXKIBIf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 20:08:35 -0500
Received: by rv-out-0910.google.com with SMTP id k20so326768rvb
        for <linux-ide@vger.kernel.org>; Thu, 08 Nov 2007 17:08:35 -0800 (PST)
In-Reply-To: <473311A2.9080005@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Luca Tettamanti <kronos.it@gmail.com>

Mark Lord wrote:
> Tejun Heo wrote:
>> In a presentation of true workmanship, pata_ali asserts IRQ
>> permanantly if the TF status register is read more than once when
>> there's no device attached to the port.
> ..
> 
> Is using the altstatus reg (rather than status reg), when possible,
> a better idea here?

I dunno.  It probably differs case-by-case.  In general, status reg
should be safer as it is supposed to clear IRQ.

-- 
tejun
