From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_vsc.c cache line size question
Date: Sun, 14 Jan 2007 14:47:22 +0000
Message-ID: <20070114144722.73fe0b49@localhost.localdomain>
References: <92952AEF1F064042B6EF2522E0EEF43703EE316A@EXNA.corp.stratus.com>
	<20070114080301.GD61246@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52973 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751137AbXANOgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Jan 2007 09:36:07 -0500
In-Reply-To: <20070114080301.GD61246@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: "Dailey, Nate" <Nate.Dailey@stratus.com>, linux-ide@vger.kernel.org

> So I suppose the driver should be modified to set it to 0x80 only
> if it's 0.  I believe that most PCI implementations will set it in
> the BIOS or whatever.

pci_set_master should handle this automtically on most platforms.

On x86-32 you also need to check "pcibios_max_latency" if you write the
latency yourself directly AND the card could be plugged into an arbitary
PCI slot on a 32bit PC.

Alan

