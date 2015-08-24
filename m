From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci_imx: can read corrupted data successfully
Date: Mon, 24 Aug 2015 15:24:53 -0400
Message-ID: <20150824192453.GD28944@mtj.duckdns.org>
References: <20150824105501.GX7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35275 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbbHXTY5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Aug 2015 15:24:57 -0400
Received: by qkbm65 with SMTP id m65so83369613qkb.2
        for <linux-ide@vger.kernel.org>; Mon, 24 Aug 2015 12:24:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150824105501.GX7557@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hans de Goede <hdegoede@redhat.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, jon.nettleton@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

Hello, Russell.

On Mon, Aug 24, 2015 at 11:55:01AM +0100, Russell King - ARM Linux wrote:
> I've no idea how this is happening, but it appears that it's possible
> to read corrupted data over an eSATA link.
> 
> The setup is a Solid-run Cubox-i4pro connected to an external eSATA 2.5"
> enclosure with a Corsair Neutron 128GB SSD.
> 
> While the issue seems to be the generally poor quality of eSATA cables
> (I have two eSATA enclosures, the other enclosure's eSATA cable
> interferes with a Logitech wireless receiver - I've had to wrap the
> cable in aluminium foil.)  However, it shouldn't be possible to
> successfully read faulty data in that condition - and this is what I
> find most worrying.
> 
> What I've noticed is that at boot, the the SSD is sometimes properly
> detected, other times it isn't:
...
> ata1.00: ATA-8: Corsair Neutron SSD, M311, max UDMA/133
> ata1.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 31/32)
...
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: ATA-8: , , max UDMA/133
> ata1.00: 250069680 sectors, multi 1: LBA48
...

It'd be interesting to see the ID data being returned.
"libata.force=dump_id" should do it but bit flips during transfer or
outright incorrect DMA won't lead to the above result.  Looks more
like the firmware on the drive side getting terminally confused.

...
> How does SATA ensure command and data integrity over the link?  I'd
> assume that there's a CRC present on the data, like UDMA on PATA.  How
> are CRC errors supposed to be reported?  Is it possible that ahci_imx
> and other layers are not properly checking for CRC errors?

IIRC, the 8/10b encoding does running parity and there's per-frame
(packet) CRC too.  Link and frame integrity is always checked by
hardware.  Reporting and handling can be different depending on which
party detects the error tho.

> Any ideas what to look at?
> 
> Anyone got any suggestions on where to get a good quality, but not
> stupidly expensive eSATA cable from?
> 
> I'm waiting for it to happen again, and I'll dump out more of the drive's
> "contents" when the cable is bad.  If it is the drive's firmware, it
> should contain the manufacturer name/model somewhere in the image.

I highly doubt this is something happening on the controller / link
side.  Looks like a messed up drive firmware to me.

Thanks.

-- 
tejun
