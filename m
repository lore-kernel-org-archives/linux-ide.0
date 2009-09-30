From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: display all AHCI 1.3 HBA capability flags (v2)
Date: Wed, 30 Sep 2009 19:02:27 -0400
Message-ID: <4AC3E383.3030508@garzik.org>
References: <4AB6718C.2050107@gmail.com> <4AB69318.5050904@garzik.org>	 <4AB6B487.3010907@gmail.com> <51f3faa70909281934o38b23679w72b8231e762412ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43483 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099AbZI3XC0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Sep 2009 19:02:26 -0400
In-Reply-To: <51f3faa70909281934o38b23679w72b8231e762412ba@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: ide <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On 09/28/2009 10:34 PM, Robert Hancock wrote:
> On Sun, Sep 20, 2009 at 5:02 PM, Robert Hancock<hancockrwd@gmail.com>  wrote:
>> Update the AHCI driver to display all of the HBA capabilities defined in the
>> AHCI 1.3 specification. Some of these are in a new CAP2 (HBA Capabilities
>> Extended) register which is only defined on AHCI 1.2 or later. The spec says
>> that undefined registers should always return 0 on read, but to be safe we
>> assume a value of 0 unless the controller reports AHCI version 1.2 or later.
>> The value can also be retrieved through sysfs as with the existing capability
>> field.
>>
>> For example, on an Intel Ibex Peak (PCH) controller:
>>
>> ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ems
>> sxs apst
>>
>> We don't do anything special with the new flags yet.
>>
>> Also, change the code that displays the flags to use the same bit enumerations
>> that are used to control actual operation.
>>
>> Signed-off-by: Robert Hancock<hancockrwd@gmail.com>
>>
>
> Ping?

in the queue, but I want to get some serious libata testing (today) 
before pushing stuff.  I'm seeing some strange timeouts, on ICH7 AHCI 
ATAPI, and need to check and see whether (a) libata broke recently or 
(b) more likely, the hardware is dying.

	Jeff



