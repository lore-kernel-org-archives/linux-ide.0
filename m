From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 00/14] ahci/libata: clean up platform device removal
Date: Fri,  2 Nov 2012 00:46:14 -0700
Message-ID: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56817 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179Ab2KBHqv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 03:46:51 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2297937pbb.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 00:46:51 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>, Kevin Cernekee <cernekee@broadcom.com>

Hi,

This is a revision and extension of an RFC series I sent out a few times. Here
are links to the previous patches, discussion, and questions.

    http://article.gmane.org/gmane.linux.ide/53159
    http://article.gmane.org/gmane.linux.ide/53143
    http://article.gmane.org/gmane.linux.ide/52951

The major change from RFC v2 is that I rebased to the current libata/NEXT, then
added new patches (PATCH 04/14 through PATCH 14/14).

This series does the following:

(1) Allows ahci_platform to unbind a device from the driver. This is useful for
    allowing total power-off of the device, for instance.
(2) Adds ahci_platform ata_port_operations.host_stop() hook, so that
    platform-device exit() can power down the device at the appropriate point
    in the removal sequence.
(3) Adds a common ata_platform_remove_one() function so that we don't
    re-implement a simple host detach across many platform drivers
(4) Switches many platform drivers to the new .remove function from (3)

Thanks to Tejun for the comments, which suggested that ahci_platform (not
libata-core) was broken.

Note that patch 13 provides untested new functionality to the pata_octeon_cf
driver. It was missing a .remove function, so I took the liberty to add the
common one. Feel free to exclude this patch.

Thanks,
Brian

P.S. A related but distinct issue: someting is still broken in the
ata_host_detach() function, for shutting down the host, spinning down disks,
etc. When I rmmod the driver or unbind the device, I get the following
failures, and the HDD doesn't spin down:

   # echo strict-ahci.0 > /sys/bus/platform/drivers/ahci/unbind 
   ata2.00: disabled
   sd 1:0:0:0: [sda] Synchronizing SCSI cache
   sd 1:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00
   sd 1:0:0:0: [sda] Stopping disk
   sd 1:0:0:0: [sda] START_STOP FAILED
   sd 1:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00

This is reproducible on my laptop (v3.2 kernel, AHCI PCI driver) and on my SoC
AHCI core (v3.3 kernel, AHCI platform driver). I haven't been able to try a
more recent kernel, but nothing I see in the changelogs suggests that there
would be any difference.

I have narrowed down the error messages to the following info, although I am
not yet familiar enough with these codepaths to make a recommendation:

ata_host_detach
|_ ata_port_detach
  |_ ata_port_schedule_eh => SCSI error handler calls ata_dev_disable()
  | ...
  |_scsi_remove_host()
    | ...
    |__..._ sd_start_stop_device() => failure!

Brian Norris (14):
  ahci_platform: enable hotplug unbinding
  ahci_platform: convert to module_platform_driver
  ahci_platform: perform platform exit in host_stop() hook
  libata: implement ata_platform_remove_one()
  ahci_platform: utilize common ata_platform_remove_one()
  pata_ixp4xx_cf: utilize common ata_platform_remove_one()
  pata_mpc52xx: utilize common ata_platform_remove_one()
  pata_of_platform: utilize common ata_platform_remove_one()
  pata_platform: utilize common ata_platform_remove_one()
  ata_platform: remove unused remove function
  pata_palmld: utilize common ata_platform_remove_one()
  sata_highbank: utilize common ata_platform_remove_one()
  pata_octeon_cf: perform host detach, removal on exit
  libata: use pci_get_drvdata() helper

 drivers/ata/ahci_platform.c    | 44 +++++++++++++++++++-----------------------
 drivers/ata/libata-core.c      | 30 ++++++++++++++++++++++++----
 drivers/ata/pata_ixp4xx_cf.c   | 11 +----------
 drivers/ata/pata_mpc52xx.c     | 17 +++-------------
 drivers/ata/pata_octeon_cf.c   |  1 +
 drivers/ata/pata_of_platform.c |  7 +------
 drivers/ata/pata_palmld.c      |  4 +---
 drivers/ata/pata_platform.c    | 24 +----------------------
 drivers/ata/sata_highbank.c    | 12 +-----------
 include/linux/ata_platform.h   |  2 --
 include/linux/libata.h         |  4 ++++
 11 files changed, 59 insertions(+), 97 deletions(-)

-- 
1.7.11.3

