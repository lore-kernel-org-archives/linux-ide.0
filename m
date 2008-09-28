From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE
	driver
Date: Sun, 28 Sep 2008 12:47:11 +0100
Message-ID: <20080928114711.GB9207@linux-mips.org>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:39704
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751231AbYI1LrY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Sep 2008 07:47:24 -0400
Content-Disposition: inline
In-Reply-To: <48DA1F9D.6000501@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org

On Wed, Sep 24, 2008 at 03:08:13PM +0400, Sergei Shtylyov wrote:

>> +{
>>   
> [...]
>> +	pdev = platform_device_register_simple(DEV_NAME, -1,
>> +		       swarm_ide_resource, ARRAY_SIZE(swarm_ide_resource));
>>   
>
>   If you have the resources as static array anyway, why not have the  
> device in the static variable too and use platform_device_register()?

It saves a few lines of code.

>> -static struct platform_device *swarm_ide_dev;
>>   
>
>   Platform device in the driver itself? Interesting... :-)

It works and isn't a too bad idea for certain drivers where adding one half
of the code to a platform file, another to the driver file is just too
much fuzz.  It's just that this wasn't done right in case of the Swarm so
I'm gluing that now.

  Ralf
