From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] blacklist NCQ on Seagate Barracuda ST380817AS
Date: Sun, 30 Sep 2007 11:43:38 -0400
Message-ID: <46FFC42A.9080300@garzik.org>
References: <20070930160548.235be972@localhost>	<20070930152908.1f58d39d@the-village.bc.nu>	<20070930164610.20818867@localhost>	<46FFBB2D.6060004@garzik.org> <20070930172859.7fd44eab@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52339 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807AbXI3Pnm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Sep 2007 11:43:42 -0400
In-Reply-To: <20070930172859.7fd44eab@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Paolo Ornati wrote:
> On Sun, 30 Sep 2007 11:05:17 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>>> I have this problem only with XFS, and even with XFS it goes away
>>> mounting with "nobarrier"...  
>> This last is an interesting datapoint.
>>
>> I wonder if libata has a generic problem with NCQ + FLUSH CACHE.
>>
>> What happens if you enable the 'fua' module parameter?  (libata.fua on 
>> kernel command line, if built in)
> 
> it isn't supported here:
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

Did you actually try my suggestion?

That message is normal, because libata defaults to FUA==off.

	Jeff



