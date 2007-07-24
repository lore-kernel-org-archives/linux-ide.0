From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] ata_piix: fix suspend/resume for some TOSHIBA
 laptops
Date: Tue, 24 Jul 2007 22:57:47 +0100
Message-ID: <20070724225747.1dd4d141@the-village.bc.nu>
References: <20070710063605.GA21994@htj.dyndns.org>
	<20070710065543.GA23568@htj.dyndns.org>
	<46A66842.6040803@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36709 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755274AbXGXVvB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jul 2007 17:51:01 -0400
In-Reply-To: <46A66842.6040803@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, greg@kroah.com, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

> A more generalized rule to consider for the future would be to ensure 
> that ALL suspend routines put the hardware back into its pre-Linux init 
> mode before suspending.  i.e. that means if we turned on some enhanced 
> mode, we must switch back to legacy mode before calling pci_xxx to 
> suspend our device.

This sounds good but for some hardware you can't get it back into that
state and there is no guarantee some laptops don't have ACPI suspend
paths that "know" Windows will have reconfigured the hardware.
