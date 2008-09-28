From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] IDE: Fix platform device registration in Swarm IDE
	driver
Date: Sun, 28 Sep 2008 22:57:56 +0100
Message-ID: <20080928215756.GA12949@linux-mips.org>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <200809271859.55304.bzolnier@gmail.com> <20080928113931.GA9207@linux-mips.org> <20080928175450.GA8478@linux-mips.org> <48DFFC62.9050300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:34441
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751670AbYI1V6K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Sep 2008 17:58:10 -0400
Content-Disposition: inline
In-Reply-To: <48DFFC62.9050300@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org

On Mon, Sep 29, 2008 at 01:51:30AM +0400, Sergei Shtylyov wrote:

>> +	{
>> +		.name	= "Swarm GenBus IDE",
>> +		.flags	= IORESOURCE_MEM,
>> +	}, {
>> +		.name	= "Swarm GenBus IDE",
>> +		.flags	= IORESOURCE_MEM,
>> +	}, {
>> +		.name	= "Swarm GenBus IDE",
>> +		.flags	= IORESOURCE_IRQ,
>> +		.start	= K_INT_GB_IDE,
>> +		.end	= K_INT_GB_IDE,
>>   
>
>   Giving the resources similar names is pointless. You can just leave  
> the 'name' field uninitialized.

I could - but I prefer things to have reasonable names in /proc/iomem or
wherever.  Unfortunately the IRQ resources name isn't yet being used to
for the interrupt but there's always something left to do :)

  Ralf
