From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_qstor, pdc_adma, sata_sx4: convert to new EH
Date: Fri, 03 Aug 2007 11:16:59 -0400
Message-ID: <46B346EB.1040009@garzik.org>
References: <20070724011404.GA14064@havoc.gtf.org> <46B31862.10201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60456 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762471AbXHCPRF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Aug 2007 11:17:05 -0400
In-Reply-To: <46B31862.10201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mlord@pobox.com

Tejun Heo wrote:
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
> pdc_adma works fine.  Tested both a harddrive and a cdrom.  ATAPI check
> sense seems to work and harddrive was successfully recovered from
> timeout induced by shaking the harddisk for 30s.  :-)

Thanks!  I'll push pdc_adma new-EH conversion into #upstream.

	Jeff



