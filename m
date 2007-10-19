From: Stanislav Semakin <Stanislav.Semakin@blancco.com>
Subject: ATA_GET_STATUS ioctl crashes on AHCI devices
Date: Fri, 19 Oct 2007 11:55:22 +0300
Message-ID: <1192784122.7832.88.camel@blanccoss>
Reply-To: Stanislav.Semakin@blancco.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.blancco.com ([62.240.70.187]:53037 "EHLO smtp.blancco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965767AbXJSJHZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Oct 2007 05:07:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


Hi,

I use 2.6.21 kernel. If I call the ATA_GET_STATUS to the disks connected
to ahci card then my app crashes.

ata_check_status() function does ioread8(ap->ioaddr.status_addr) where
ap->ioaddr.status_addr is 0.

If I change it in the following way everything works:
u8 ata_check_status(struct ata_port *ap)
{
        if (ap->ops->check_status)
                return ap->ops->check_status(ap);

        return ioread8(ap->ioaddr.status_addr);
}

I checked latest 2.6.23.1 and looks like there is the same problem.


BR,
Stanislav


