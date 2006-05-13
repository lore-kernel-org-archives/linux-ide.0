From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Date: Sat, 13 May 2006 00:12:09 -0400
Message-ID: <44655C99.5050609@garzik.org>
References: <200605121534.k4CFYodu020885@harpo.it.uu.se> <446515F0.7070702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:23266 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932321AbWEMEMO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 00:12:14 -0400
In-Reply-To: <446515F0.7070702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Mikael Pettersson wrote:
>> On Fri, 12 May 2006 22:24:37 +0900, Tejun Heo wrote:
>>> The following drivers support new features.
>>>
>>> ata_piix:	new EH, irq-pio, warmplug (hardware restriction)
>>> sata_sil:	new EH, irq-pio, hotplug
>>> ahci:		new EH, irq-pio, NCQ, hotplug
>>> sata_sil24:	new EH, irq-pio, NCQ, hotplug, Port Multiplier
>> If you were to add new EH and NCQ support to sata_promise,
>> then I'd test it on my News server.
>>
> 
> I have a promise card and played with it a little bit but I don't have
> access to hardware doc.  So...

I have Promise NCQ info, just waiting for the chance to use it :)

Plus I have a nagging suspicion that the SATA II cards have a few
differences from the SATA I cards that have yet to be coded into
sata_promise.c.

	Jeff



