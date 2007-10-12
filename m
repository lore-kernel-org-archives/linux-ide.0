From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AHCI: using bios after linux
Date: Fri, 12 Oct 2007 21:57:34 +0100
Message-ID: <20071012215734.4b5b4bce@the-village.bc.nu>
References: <20071012182726.37EFB4702DA@web2mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55835 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757822AbXJLUyT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Oct 2007 16:54:19 -0400
In-Reply-To: <20071012182726.37EFB4702DA@web2mail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: msundius@u1.netgate.com
Cc: msundius@sundius.com, xuxiang_ins@yahoo.com, linux-ide@vger.kernel.org

> 3) related to #1 above, we want to be invisable. so we're not looking to
> switch from AHCI (to legacy), we are looking to continue in whatever mode
> the BIOS started in. Thus we just want BIOS to be able to handle int13 calls
> after the Linux AHCI driver has run (this works when BIOS is setup in 
> legacy mode initially).

So load the ata_piix driver and not the AHCI one and I think it'll work
out ?
