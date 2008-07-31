From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_it821x: Driver updates and reworking
Date: Thu, 31 Jul 2008 02:05:20 -0400
Message-ID: <48915620.4020401@garzik.org>
References: <20080724171606.1c2a677c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55554 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbYGaGFX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 02:05:23 -0400
In-Reply-To: <20080724171606.1c2a677c@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> - Add support for the RDC 1010 variant
> - Rework the core library to have a read_id method. This allows the hacky
> bits of it821x to go and prepares us for pata_hd
> - Switch from WARN to BUG in ata_id_string as it will reboot if you get
> it wrong so WARN won't be seen
> - Allow the issue of command 0xFC on the 821x. This is needed to query
> rebuild status.
> - Tidy up printk formatting
> - Do more ident rewriting on RAID volumes to handle firmware provided
> ident data which is rather wonky
> - Report the firmware revision and device layout in RAID mode
> - Don't try and disable raid on the 8211 or RDC - they don't have the
> relevant bits
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


