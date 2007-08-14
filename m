From: Karim 'Kasi Mir' Senoucci <ks@double-you.de>
Subject: Should sata_mv work with Highpoint RocketRAID 2300?
Date: Tue, 14 Aug 2007 18:47:55 +0200
Message-ID: <46C1DCBB.9020308@double-you.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.melzone.de ([81.169.156.183]:41266 "EHLO mx1.melzone.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398AbXHNR2u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Aug 2007 13:28:50 -0400
Received: from [85.177.103.65] (helo=[10.0.2.181])
	by mx1.melzone.de with esmtpa (Exim 4.60)
	(envelope-from <ks@double-you.de>)
	id 1IKzYf-0001vX-AF
	for linux-ide@vger.kernel.org; Tue, 14 Aug 2007 18:47:53 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello all,
sorry if this it too dumb a question, but since I haven't gotten any 
results with the sata_mv driver (kernel 2.6.22.2), I was wondering if 
the Highpoint RocketRaid 2300 controller - which features a Marvell chip 
- is even supposed to work with sata_mv.

lspci shows in regard to the controller card:

06:00.0 SCSI storage controller [0100]: Triones Technologies, Inc. 
Unknown device [1103:2300] (rev 02)
        Subsystem: Marvell Technology Group Ltd. Unknown device [11ab:11ab]
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at fd500000 (64-bit, non-prefetchable) [size=1M]
        I/O ports at 4800 [size=256]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
        Capabilities: [60] Express Legacy Endpoint IRQ 0

Is this one of the cards the sata_mv driver should handle, or do I need 
to use another kernel module, or is that chip without linux support so far?

Thanks for any insight into the matter.

Greetings, Karim.
