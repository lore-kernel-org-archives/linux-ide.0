From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105
 interfaces
Date: Mon, 15 May 2006 18:32:16 +0400
Message-ID: <446890F0.3020408@ru.mvista.com>
References: <20051112165548.GB28987@flint.arm.linux.org.uk> <1131818615.18258.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:6342 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S964907AbWEOOdU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 10:33:20 -0400
In-Reply-To: <1131818615.18258.6.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:
 > On Sad, 2005-11-12 at 16:55 +0000, Russell King wrote:
 >
 >>We must _never_ _ever_ on pain of death enable IDE DMA on SL82C105
 >>chipsets where the southbridge revision is <= 5, otherwise data
 >>corruption will occur.

 > If you are fixing this driver also set ->serialize = 1; before someone
 > with dual channel device gets burned.

    Heh, this driver also tries to cache the single PCI register per-channel 
like hpt366.c... This buglet concerns using fast PIO timings and is probably 
harmless though but needs to be fixed -- I'll send a patch soon...
    I wonder what is otherwise wrong with using 2 channels concurrently?

MBR, Sergei
