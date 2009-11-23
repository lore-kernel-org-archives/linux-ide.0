From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: drivers/ide/au1xxx-ide.c: use resource_size()
Date: Mon, 23 Nov 2009 13:37:05 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901EE5C0C@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901EE5BFD@mi8nycmail19.Mi8.com> <20091123.102817.157628485.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755380AbZKWShB@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20091123.102817.157628485.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday, November 23, 2009 11:28 AM, David Miller wrote:
> From: "H Hartley Sweeten" <hartleys@visionengravers.com>
> Date: Mon, 23 Nov 2009 13:15:32 -0500
>
>> Use resource_size() for {request/release}_mem_region and ioremap.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
> Applied to ide-next-2.6, thanks.
>
>>  
>> -	ahwif->regbase = (u32)ioremap(res->start, res->end - res->start + 1);
>> +	ahwif->regbase = (u32)ioremap(res->start, resource_size(res));
>>  	if (ahwif->regbase == 0) {
>>  		ret = -ENOMEM;
>>  		goto out;
>
> That needs some fixing.  ioremap()'s return value is an
> "__iomem" pointer, not an integer.  ->regbase's type should be
> changed to something like "void __iomem *" etc.

Agree.  But that was already in the driver.

I don't have to hardware to test this so I didn't want to dig to deeply
into fixing that.

Thanks,
Hartley
