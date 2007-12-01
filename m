From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] Several fixes for the AVR32 PATA driver
Date: Sat, 01 Dec 2007 17:37:19 -0500
Message-ID: <4751E21F.5040503@garzik.org>
References: <200711291201.51598.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41928 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbXLAWh2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 17:37:28 -0500
In-Reply-To: <200711291201.51598.kngregertsen@norway.atmel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, gregerts@stud.ntnu.no, Haavard Skinnemoen <hskinnemoen@atmel.com>, kernel@avr32linux.org

Kristoffer Nyborg Gregertsen wrote:
> Several fixes for the AVR32 PATA driver:
> 
> * Updated to use new AVR32 SMC timing API. This removes the need for "magic"
> constants in signal timing.
> 
> * Removed the ATA_FLAG_PIO_POLLING, the driver should use interrupts.
> 
> * Removed .port_disable and .irq_ack as these are no longer needed.
> 
> * Improved some comments.
> 
> Signed-off-by: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>

applied #upstream-fixes


