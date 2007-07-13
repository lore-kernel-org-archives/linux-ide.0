From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/6] icside: fix ->speedproc to return on unsupported
 modes
Date: Sat, 14 Jul 2007 00:54:35 +0100
Message-ID: <20070714005435.1507c17e@the-village.bc.nu>
References: <200707110200.37607.bzolnier@gmail.com>
	<200707112321.41597.bzolnier@gmail.com>
	<46967FA8.4090406@ru.mvista.com>
	<200707132302.04065.bzolnier@gmail.com>
	<20070713213948.GA18000@flint.arm.linux.org.uk>
	<20070714001523.2dafed67@the-village.bc.nu>
	<20070713232038.GA9352@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40279 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752246AbXGMXsW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 19:48:22 -0400
In-Reply-To: <20070713232038.GA9352@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

> We need to set the IRQ enable initially so that the identity information
> can be read and the drive accessed etc.  However, if no drives are
> detected on a port, there is no callback into the low level driver -
> the port_disable method is never called.  (I believe it is with SATA.)

No. It actually makes no sense to do so as libata is hot plug capable
thus the usual case is "no drives are currently detected"
 
> I tried asking about this several times before the driver was merged
> and every time it was completely ignored. 

Provide a private postreset method thats


static void my_postreset(struct ata_port *ap, unsigned int *classes)
{
	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
		force IRQ off [should be off anyway]
	} else {
		return ata_std_postreset(ap, classes);
	}
}

