From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 14/14] ahci: add softreset
Date: Mon, 19 Dec 2005 15:12:42 +0900
Message-ID: <43A64F5A.1010002@gmail.com>
References: <20051218133305.GA31571@htj.dyndns.org> <20051218135149.GO31571@htj.dyndns.org> <43A646C7.3050503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:9668 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750737AbVLSGMr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 01:12:47 -0500
Received: by zproxy.gmail.com with SMTP id 14so1845462nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 22:12:47 -0800 (PST)
In-Reply-To: <43A646C7.3050503@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Now that libata is smart enought to handle both soft and hard resets,
>> add softreset method.
> 
> 
> I'm a bit skeptical that polling is what should be done here.  SATA is 
> inherently event-driven...
> 

Well, I'm a bit skeptical the other way around.  :-)

What benefits would making softreset event-driven bring?  It would be 
much more complex and softreset is so not a hot-path.

Also, AHCI does not report events for CLO and START manipulation.  They 
need to be polled.  They can be done by dancing with timers, but....

-- 
tejun
