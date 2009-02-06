From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Fri, 06 Feb 2009 20:20:03 +0300
Message-ID: <498C7143.3090508@ru.mvista.com>
References: <200902031147.22827.stf_xl@wp.pl> <498B0F22.3090403@ru.mvista.com> <498C173F.4000908@ru.mvista.com> <200902061750.24258.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:25113 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753021AbZBFRTi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Feb 2009 12:19:38 -0500
In-Reply-To: <200902061750.24258.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Bartlomiej Zolnierkiewicz wrote:

>>>>   Can you answer the simple question: why we should try to support 
>>>>two incompatible chips with a single driver? Because the driver name 
>>>>will be shorter? :-)

>>>>Very funny. I think patch adding RM9200 support to this driver will 
>>>>have less
>>>>than 50 lines changeset,  whereas writing new driver would be about 
>>>>500 lines.

>>>   This approach is so broken-minded that I'm just out words to argue 
>>>any more.

>>>   Let's then support say all the PCI IDE chipsets with the single 
>>>driver (actully, there was a driver that tried to support 2 
>>>incompatible Promise chip families but it got split finally).

> Actually it was the case for Linux during early 2.4.x days. :)

    And I've spent considerable time fixing this driver in 2.4.20. :-)

> [ Probably for historical reasons. ]

>>   To say the truth, there are stil at least 2 examples of such drivers: 
>>hpt366 and aec6210. While the former is justified by the bogus chip 

> The former can be probably still improved with hpt3xx_main.c and chipset
> family specific code separated into hpt36x.c etc.

    Don't think that there's even enough common code for hpt3xx_main.c.

>>identification poilicy used by the vendor, the latter has no 
>>justification at all.

> Patches are always warmly welcomed.

    There is just to much I'd like to be done with this driver and too little 
time to do that. :-)

> Thanks,
> Bart

MBR, Sergei
