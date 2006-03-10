From: Adrian Bunk <bunk@stusta.de>
Subject: drivers/scsi/ahci.c:ahci_interrupt(): NULL pointer dereference
Date: Fri, 10 Mar 2006 20:34:14 +0100
Message-ID: <20060310193414.GT21864@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932073AbWCJTeQ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The Coverity checker spotted this bug (note the ap dereference)

<--  snip  -->

...
                if (ap) {
...
                } else {
                        VPRINTK("port %u (no irq)\n", i);
                        if (ata_ratelimit()) {
                                struct pci_dev *pdev =
                                        to_pci_dev(ap->host_set->dev);
...

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
