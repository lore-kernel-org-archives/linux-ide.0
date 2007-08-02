From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_qstor, pdc_adma, sata_sx4: convert to new EH
Date: Thu, 02 Aug 2007 21:40:51 +0900
Message-ID: <46B1D0D3.5050703@gmail.com>
References: <20070724011404.GA14064@havoc.gtf.org> <46B1CDCD.3010907@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:21377 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbXHBMk7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 08:40:59 -0400
Received: by rv-out-0910.google.com with SMTP id k20so404539rvb
        for <linux-ide@vger.kernel.org>; Thu, 02 Aug 2007 05:40:59 -0700 (PDT)
In-Reply-To: <46B1CDCD.3010907@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> This is just a refresh of the existing libata-dev.git#new-eh patches
>> that convert all remaining old-EH drivers to new EH, against 2.6.23-rc1.
>>
>> All three conversions are completely untested.  pdc_adma and sata_qstor
>> need reviewing by someone with docs, in addition to testing.
>>
>> Even "it still works" or "this patch breaks stuff" feedback from users
>> is useful.
> 
> Tejun has some pdc_adma hardware..  ;)

Yeah, I actually have two thanks to Mark. :-)  Will test soon.

-- 
tejun
