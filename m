From: Tejun Heo <htejun@gmail.com>
Subject: Re: [COORDINATE] INIC-1620TA/1622TA2/1623TA2 SATA controllers from
 initio
Date: Fri, 01 Dec 2006 09:57:59 +0900
Message-ID: <456F7E17.6050301@gmail.com>
References: <43D646C2.6040104@gmail.com> <ekn6pj$9dt$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:13319 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031665AbWLAA6M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 19:58:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2289124uga
        for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 16:58:11 -0800 (PST)
In-Reply-To: <ekn6pj$9dt$1@sea.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthias Urlichs <matthias@urlichs.de>
Cc: linux-ide@vger.kernel.org

Matthias Urlichs wrote:
> On Wed, 25 Jan 2006 00:24:50 +0900, Tejun Heo wrote:
> 
>> I've just bought this brand-new/quite affordable INIC-1622TA2 
>> controller.  AFAIK, there's no driver yet. 
> 
> Any progress? I acquired two of those beasts today and *really* would like
> to get them up&running ASAP. :-/
> 
> There seems to be a driver for Linux 2.4 at
> http://www.sunix.com.tw/it/en/down/driver/SATA/SATA2100/Linux%202.4.zip
> which might be helpful in writing a 2.6 driver.

Yeah, I saw that.  The problem with the driver is that it doesn't
contain any license notice.  I'm not sure if it would be okay to read
the driver and use the acquired info to implement GPL driver.  I asked
sunix about it but got no useful answer.

>> http://initio.com/products/sata.htm
> 
> The documentation on that page doesn't mention the 1622 any more, only the
> 1623. Does anybody still have the "old" data sheet?
> 
> Which of the sata_*.c drivers would be a good sample code / starting point
> for writing a new driver?

For controllers which support NCQ, ahci and sata_sil24 are pretty good
examples.

-- 
tejun
