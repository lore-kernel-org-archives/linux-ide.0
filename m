From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] scsi/ahci: Add support for ULi M5287
Date: Sun, 06 Feb 2005 01:55:23 -0500
Message-ID: <4205BF5B.7050006@pobox.com>
References: <OF3919B280.9034BA70-ON48256FA0.002238C1@uli.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7608 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S267518AbVBFGzi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Feb 2005 01:55:38 -0500
In-Reply-To: <OF3919B280.9034BA70-ON48256FA0.002238C1@uli.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer.Chen@uli.com.tw
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andrebalsa@mailingaddress.org, Clear.Zhang@uli.com.tw, Emily.Jiang@uli.com.tw, Eric.Lo@uli.com.tw

Peer.Chen@uli.com.tw wrote:
> Hi,Jeff:
> I think you are not necessary add the m5287 support to ahci.c now, the code
> I add is to
> correct the two bugs of our controller, now we have designed a new AHCI
> controller name M5288(device id is 0x5288),
> it work perfectly with the linux ahci driver only add the PCI ID to ahci.c.

Thanks, I will add this PCI ID to ahci.c.


> Another question,if the SATA SCSI driver and AHCI driver both support the
> same controller, which driver
> has the priority in linux.

Two answers:

a) For the upstream kernel -- when the drivers are built into the kernel
-- the order in which the drivers are listed in drivers/scsi/Makefile
affects the probe order (priority).  When the drivers are built as
kernel modules, the contents of /etc/modprobe.conf (or /etc/modules.conf
for kernel 2.4.x) determines which driver to load.

b) For distributors (Red Hat, SuSE, Mandrake, etc.), the installer
engineers at each company choose which driver to load.

To simplify matters, it is recommended to avoid situations where
multiple drivers have the same PCI ID listed.  The "more advanced"
driver (AHCI) is preferred of course ;-)

Regards,

	Jeff


