From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata-dev-2.6: pdc2027x timing register fix for 100MHz
 adapters
Date: Thu, 24 Feb 2005 14:51:17 +0800
Message-ID: <421D7965.304@tw.ibm.com>
References: <003f01c50905$c8090d10$6401a8c0@tw.ibm.com> <421D6CAC.3020308@tw.ibm.com> <421D6FDB.8080608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:40427 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261876AbVBXGvZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 01:51:25 -0500
In-Reply-To: <421D6FDB.8080608@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>



Jeff Garzik wrote:

> 
>> 1. For the 100MHz pdc20268 and pdc20270 adapters, rely on the hardware 
>> to set the timing registers.
> 
> 
> How does the hardware set the timing registers?
> 
> Does it snoop the SET FEATURES - XFER MODE command?
> 
Yes.

All chips supported by the pata_pdc2027x driver do that.
The values set by the hardware are assuming PLL running at 100MHz.
So, for 133MHz adatpers, we have to override the values set by hardware by software.
For 100Mhz adapters, we can rely on the hardware for the timing registers.

Albert


