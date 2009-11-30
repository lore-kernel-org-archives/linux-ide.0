From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: libata PM question
Date: Mon, 30 Nov 2009 13:22:44 +1100
Message-ID: <1259547765.2076.48.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58101 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbZK3CX3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Nov 2009 21:23:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>

Hi there !

So I (finally !) resumed work on pata_macio.c to replace ide/pmac.c :-)

I've started looking at the suspend/resume stuff. It looks like most of
it just comes for free thanks to libata, yay ! :-)

One quick nit tho, in libata-eh.c, in ata_eh_handle_port_suspend(), any
reason why you always call ata_acpi_set_state(ap, PMSG_SUSPEND) rather
than ata_acpi_set_state(ap, ap->pm_mesg) ?

Not directly related to my pmac driver but it seems like it would cause
calls into ACPI suspend/resume code even when doing freeze/thaw for
hibernation which doesn't sound totally right to me ... or do I miss
something ?

Cheers,
Ben.


