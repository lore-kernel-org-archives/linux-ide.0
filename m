From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-dev-2.6-ncq: rewrite __ata_qc_complete
Date: Mon, 27 Jun 2005 22:21:08 +0900
Message-ID: <42BFFD44.7020402@gmail.com>
References: <20050626144110.GD24968@htj.dyndns.org> <42BEE593.7050004@pobox.com> <20050627082709.GO19550@suse.de> <42BFC68E.3020707@tw.ibm.com> <42BFDF66.3010402@gmail.com> <42BFF158.9060203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:2758 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262052AbVF0NVS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jun 2005 09:21:18 -0400
Received: by zproxy.gmail.com with SMTP id i11so179771nzh
        for <linux-ide@vger.kernel.org>; Mon, 27 Jun 2005 06:21:15 -0700 (PDT)
In-Reply-To: <42BFF158.9060203@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>>  Ah... I see.  Sorry, I didn't check the ATAPI code (Is any SATA ATAPI 
>> device selling in retail shops?  I want one for testing but cannot 
>> find one).  I'll remove that removal ;-) and add some comment there to 
>> clarify things.  it also means that ATAPI handling of my NCQ helpers 
>> is broken
> 
> Yep, SATA ATAPI is selling in retail shops now.
> 
>     Jeff

  Yay, just found Plextor PX-716SA in an online shop.  I think it's the 
only model available here. :-)

  Thanks.

-- 
tejun
