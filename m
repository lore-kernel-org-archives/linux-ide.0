From: Steffen Koehler <stk@mail.inf.tu-dresden.de>
Subject: AHCI PATCH
Date: Sun, 06 Aug 2006 12:46:16 +0200
Message-ID: <44D5C878.5070800@ite.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.inf.tu-dresden.de ([141.76.2.1]:56516 "EHLO
	mail.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S1750834AbWHFKne (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 06:43:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com, stk@ite.inf.tu-dresden.de

Hi all Linux ATA developers,

using the latest stable kernel 2.6.17.7 in conjunction with the AHCI 
SATA driver it can happen that the driver tries to identify a drive
although no drive is present at the corrosponding channel and the
physical link is down. This causes command timeouts on every unconnected
SATA channel and unnecessarily stalls the kernel boot-process.
The problem is related to an interaction issue between the generic
(libata-core) and the chip-specific (AHCI) driver and the fact,
that the ahci_dev_classify function returns a wrong class in case
of a not established physical link (at least on my ATI/ULi chipset
of my ASUS A8R32-MVP board). The issue can be removed by applying the
following patch to the ahci_hardreset method of the AHCI driver.

Regards
Steve

static int ahci_hardreset(struct ata_port *ap, int verbose,
                           unsigned int *class)
{
         int rc;

         DPRINTK("ENTER\n");

         ahci_stop_engine(ap);
         rc = sata_std_hardreset(ap, verbose, class);
         ahci_start_engine(ap);

-       if (rc == 0)
+       if ((rc == 0) && sata_dev_present(ap))
                 *class = ahci_dev_classify(ap);
         if (*class == ATA_DEV_UNKNOWN)
                 *class = ATA_DEV_NONE;

         DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
         return rc;
}
