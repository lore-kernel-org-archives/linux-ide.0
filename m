From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Tue, 12 Aug 2008 18:18:42 +0400
Message-ID: <48A19BC2.8060008@ru.mvista.com>
References: <48A05152.7020508@harris.com>	<20080811151913.GA14690@oksana.dev.rtsoft.ru>	<48A0676E.5020308@harris.com>	<20080811170756.GA29827@oksana.dev.rtsoft.ru>	<1218492032.8041.11.camel@pasglop> <48A19788.6050502@harris.com> <20080812140457.GA9103@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:25788 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751227AbYHLOSu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Aug 2008 10:18:50 -0400
In-Reply-To: <20080812140457.GA9103@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: "Steven A. Falco" <sfalco@harris.com>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, "Sparks, Sam" <SSparks@aclaratech.com>, linuxppc-dev@ozlabs.org

Anton Vorontsov wrote:

>>>>1. IDE status read does not work. (But am I understand correctly
>>>>   that IDE works well if IRQ is unspecified? Then this is hardly
>>>>   an issue.)
>>>>2. IDE interrupt comes when it should not. I'd recommend to use
>>>>   oscilloscope to find out what is happening there, that is, if
>>>>   the drive actually deasserts its irq line after status read.
>>>>   If so, than this could be a PIC problem.

>>>>What is the platform on which you're observing the issue, btw?

>>>Another possibility is that you got the wrong interrupt number
>>>in the device-tree...

>>>Ben.

>>The platform is the AMCC Sequoia board.  We've built a little adapter to
>>connect a compact flash card to the processor bus.  I believe the
>>interrupt selection in the device tree is correct, and I've checked over
>>the u-boot settings for the IRQ line (active high, level sensitive). 

> IDE IRQs are active-low.

    Only on the PCI and only in the native mode. Natively, the IDE INTRQ 
signal is active-high, rising edge triggering, as on ISA. You seem to have an 
invertor somewhere, if it's not a PCI chip...

WBR, Sergei
