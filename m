From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: IDE driver in polling mode
Date: Tue, 10 Apr 2007 18:19:48 +0400
Message-ID: <461B9D04.2000109@ru.mvista.com>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:41685 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1030587AbXDJOSw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Apr 2007 10:18:52 -0400
In-Reply-To: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael <michaelzwrk@gmail.com>
Cc: linuxppc-embedded@ozlabs.org, linux-ide@vger.kernel.org

Hello.

Michael wrote:

> I'd like to know whether it is possible to use IDE driver (ide-disk)
> in polling mode, instead of using IRQ.

    I generally wouldn't recommend using this mode since the ATA polling 
protocol had been racy for years, WRT to the interrupt pending condition.

> In case you wonder - the reason why I need this weired thing is that I
> have a compact flash connected directly to the host local bus using
> memory mode. It is more-or-less IDE-compatible, except that it doesn't
> issue interrupts.

    Ah, no interrupts at all...
    The old IDE core in drivers/ide/ certainly doesn't support polling mode 
and IRQ-less devices. AFAICS, libata also doesn't support the latter...

MBR, Sergei
