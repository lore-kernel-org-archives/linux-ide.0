From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata queue updated
Date: Mon, 30 Jan 2006 17:44:54 +0900
Message-ID: <43DDD206.6000502@gmail.com>
References: <20060128182522.GA31458@havoc.gtf.org> <200601291711.43426.ioe-lkml@rameria.de> <43DDBA71.6040402@gmail.com> <200601300936.43977.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:56926 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751266AbWA3IpC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2006 03:45:02 -0500
Received: by wproxy.gmail.com with SMTP id 57so1008406wri
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2006 00:45:01 -0800 (PST)
In-Reply-To: <200601300936.43977.ioe-lkml@rameria.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Ingo Oeser wrote:
> On Monday 30 January 2006 08:04, Tejun Heo wrote:
>> I object.  Using array is intentional.  Slave aware controllers (PATA / 
>> ata_piix) will use [0..1], most SATA controllers will use only [0], and 
>> PM aware ones will use [0..15].  The intention was requiring low level 
>> drivers of only what they know and normalize them in the core layer.
>>
>> eg. Current std SATA reset routines consider the argument as *class (a 
>> single class value) and it's intentional.  As long as a lldd is aware of 
>> only one device per port, it's allowed/recommeded to consider the passed 
>> classes argument as a pointer to single class value.  The rest is upto 
>> the core libata layer.
>  
> But what you pass along is basically an unbounded array, which is
> a bug waiting to happen.


Hello, again.

I'm a little bit lost here.

So, are you saying....

struct ata_classes {
	unsigned int classes[2];
|;

is safer than

unsigned int *class;

?

> 
> So please let the core layer pass a bounded array here or provide
> a function from core layer to set that and check the index.
> 

Can you show me what you have in mind as code?

-- 
tejun
