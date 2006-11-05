From: Jeff Garzik <jeff@garzik.org>
Subject: Re: More Promise chipset specs opened
Date: Sun, 05 Nov 2006 04:41:18 -0500
Message-ID: <454DB1BE.7030103@garzik.org>
References: <454C6767.3090901@gmx.net> <454C92D2.8060809@garzik.org> <454DA7A9.7000608@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:972 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932604AbWKEJlV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Nov 2006 04:41:21 -0500
In-Reply-To: <454DA7A9.7000608@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: otto Meier <gf435@gmx.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

otto Meier wrote:
> Jeff Garzik schrieb:
>> otto Meier wrote:
>>> In which controller classes does it belong?
>>> Promise claims it should  have NCQ  how to enable ?
>> If it claims NCQ and 3.0Gbps support, I would guess 205xx
>>
>>     Jeff
>>
> Does this mean, changing :
> 
>  { PCI_VDEVICE(PROMISE, 0x3d17), board_20319 },
> to
>  { PCI_VDEVICE(PROMISE, 0x3d17), board_2057X },
> 
> in sata_promise.c would do the trick to activate NCQ of this board?
> 
> Does this hurt?
> Do I need to do something else to get NCQ working?

Heh, no, a lot more than that...  NCQ is not supported at all in the 
driver.  If someone is looking for a project, the docs are now available 
for them to work on NCQ.

	Jeff



