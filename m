From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: How to cleanly setup legacy IDE irq ?
Date: Fri, 01 Oct 2004 13:51:34 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1096602694.11460.29.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:63661 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269681AbUJADzX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Sep 2004 23:55:23 -0400
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

Hi Bart !

I noticed that you are about to absolete the whole lot of IDE
default stuff

# define ide_default_io_base(index)	(0)
# define ide_default_irq(base)		(0)
# define ide_init_default_irq(base)	(0)

and others...

So how do I do to "cleanly" tell the IDE layer that my PCI IDE
controller that shows on the PCI bus and is in legacy mode is
using some IRQs (14 & 15 typically) that are _not_ the PCI irq
line for this device ?

Ben.



