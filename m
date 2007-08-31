From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] AVR32 PATA driver
Date: Fri, 31 Aug 2007 05:38:40 -0400
Message-ID: <46D7E1A0.2050002@garzik.org>
References: <200708071126.08735.kngregertsen@norway.atmel.com> <200708071127.09751.kngregertsen@norway.atmel.com> <20070807165409.4c2a4451@the-village.bc.nu> <200708081657.08448.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41852 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753730AbXHaJir (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 05:38:47 -0400
In-Reply-To: <200708081657.08448.kngregertsen@norway.atmel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, gregerts@stud.ntnu.no

Kristoffer Nyborg Gregertsen wrote:
> Updated and simplified driver. Use only register transfer timing for both
> data and register transfers. This gives poorer performance in PIO1 and 2,
> but should not be a problem in PIO3 and 4, correct me if I'm wrong :)
> 
> The driver works very we'll but I still wonder about the interrupts. I have
> an interrupt line, that works nicely when POLLING flag is not set. The
> problem is the number of interrupts that eat away my CPU cycles.
> 
> When using the POLLING flag there seem to be some interrupts that dosen't get
> cleared. Furthermore the device dosen't drive INTRQ high, it stays at 2.5 volts
> and generates a lot of interrupts due to ripple / noise. What to do?
> 
> Signed-off-by: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>

applied


