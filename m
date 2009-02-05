From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Thu, 05 Feb 2009 23:03:23 +0300
Message-ID: <498B460B.20205@ru.mvista.com>
References: <200902031147.22827.stf_xl@wp.pl> <200902041547.44149.stf_xl@wp.pl>	 <4989BC8B.4010105@ru.mvista.com> <200902051601.50822.stf_xl@wp.pl>	 <498B0F22.3090403@ru.mvista.com> <cd73a99e0902051200ob1787e2v73e750344ca44ec9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:60774 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754723AbZBEUC6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Feb 2009 15:02:58 -0500
In-Reply-To: <cd73a99e0902051200ob1787e2v73e750344ca44ec9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Victor <avictor.za@gmail.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Andrew Victor wrote:

>>>>>>AT91SAM9.

>>>>>Ok, currently only SAM9 can be used with driver. However I think adding
>>>>>support to AT91RM9200 to this driver will be not much effort.

>>>>  Can you answer the simple question: why we should try to support two
>>>>incompatible chips with a single driver? Because the driver name will be
>>>>shorter? :-)

>>>Very funny. I think patch adding RM9200 support to this driver will have
>>>less
>>>than 50 lines changeset,  whereas writing new driver would be about 500
>>>lines.

>>  This approach is so broken-minded that I'm just out words to argue any
>>more.

> This driver should also work on the Atmel AT91CAP9 and AT572D940HF processors.
> So I see no valid reason why the driver cannot be called at91_ide.

    I've already said: call it whatever you want. Just don't try to add 
support for an incompatible AT91 SMC.

> Regards,
>   Andrew Victor

MBR, Sergei
