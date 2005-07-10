From: kallol@nucleodyne.com
Subject: MSI question
Date: Sat, 09 Jul 2005 20:07:56 -0400
Message-ID: <20050709200756.s0t1g5qioav4kkw4@www.nucleodyne.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from easyspace.ezspl.net ([216.74.109.141]:40124 "EHLO
	easyspace.ezspl.net") by vger.kernel.org with ESMTP id S261783AbVGJAHx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jul 2005 20:07:53 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tom.l.nguyen@intel.com
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello Tom,
         I have been trying to enable MSI interrupt on a MIPs based network
processor plaform.

The adapter is based on Prommise PCI-X SATA controller. The configuration
is described below

CPU --- HOST Bridge ---- device bus ---- PCI-X bridge --- PCI-X slot


The PCI-X bridge is programmed to accept write transactions (address, and data)
from the Promise adapter and convert them to generate an interrupt to the PIC
that is on the host bridge.

I have been successful to generate one MSI interrupt. The CPU gets the
interrupt.
With a PCI-X analyzer I see the Promise adapter is writing a predefined pattern
(0x5a5a) to a predefined address. The PCI-X bridge claims the transaction and
then I see an interrupt on the CPU.


The problem is that the card generates the MSI transaction only once. I guess
we have to enable the card to generate another MSI transaction again, right?

I do not have access to the card's manual, so not sure what has to be done to
get MSI working again.

On this system, the pin based interrupt mechanism is not working yet, so MSI has
to work.

Any reply will be greatly appreciated.

Kallol


