From: Jeff Garzik <jeff@garzik.org>
Subject: Re: IDE driver in polling mode
Date: Tue, 10 Apr 2007 12:18:15 -0400
Message-ID: <461BB8C7.9050900@garzik.org>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>	<461B9D04.2000109@ru.mvista.com> <20070410171125.3aeed29d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36890 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031017AbXDJQS0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Apr 2007 12:18:26 -0400
In-Reply-To: <20070410171125.3aeed29d@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Michael <michaelzwrk@gmail.com>, linuxppc-embedded@ozlabs.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>>     Ah, no interrupts at all...
>>     The old IDE core in drivers/ide/ certainly doesn't support polling mode 
>> and IRQ-less devices. AFAICS, libata also doesn't support the latter...
> 
> libata has much of the framework to do this as it originally did all of
> its PIO work much this way. That is probably the most productive place to
> start hacking.

Yep.

The only real restriction in libata is in ata_device_add(), which 
unconditionally registers an irq handler.  Make a few changes there, add 
a few flags, and the existing polling code will kick in.

Once we have higher priority stuff sorted, I would like to look into 
things like activating the polling code when it becomes obvious that the 
system is not delivering interrupts.

	Jeff



