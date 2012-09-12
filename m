From: Gwendal Grignou <gwendal@google.com>
Subject: Change in sysfs topology for libata
Date: Wed, 12 Sep 2012 13:02:28 -0700
Message-ID: <CAMHSBOV360yPM6+aMSNKK_iNfMKCnu8dgz4kQLysA6fpo8R7aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51992 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab2ILUC3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Sep 2012 16:02:29 -0400
Received: by qcro28 with SMTP id o28so1391153qcr.19
        for <linux-ide@vger.kernel.org>; Wed, 12 Sep 2012 13:02:28 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>, Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Lin,

 Commit 9a6d6a2ddabbd32c07f6a38b659e5f3db319fa5a introduces a change
in sysfs directory for ata controller:

Before:
           /sys/devices/pci0000:00/0000:00:1f.2    (ahci controller)
           |-- ata1                                (ata port)
           |-- host0                               (scsi host)
              |-- target0:0:0                      (scsi target)
                  |-- 0:0:0:0                      (disk)

After:
           /sys/devices/pci0000:00/0000:00:1f.2    (ahci controller)
           |-- ata1                                (ata port)
               |-- host0                           (scsi host)
                   |-- target0:0:0                 (scsi target)
                       |-- 0:0:0:0                 (disk)

The problem is an ata controller, managed by libata, is still
considered by the kernel as a SCSI controller: diverging even more
from other SCSI controller sysfs layout is not a good idea.
When I wrote libata-transport.c, my plan was to be consistent with SAS
objects: for instance, for a SAS controller with a simple SAS topology
we have:


/sys/bus/pci/devices/0000\:0c\:00.0/
|-- host7/
    |-- phy-7:0
    |-- phy-7:1
..
    |-- phy-7:7
    |-- port-7:0
        |-- end_device-7\:0
            |-- target7:0:0/
                |-- 7:0:0:0
    |-- port-7:1
..

Similarly, I wanted to represent an ata_port [equivalent to SAS phy]
and ata_link [equivalent to SAS port] under scsi_host hostX object,
but as far as i remember, when I wrote the code that was not possible,
I could not find a clean way to share object references between libata
and scsi layer. That's why ata_port object was sitting alongside to
the scsi_host object. I have to see if it is possible now.

In the meantime, what would be the impact to revert that commit?
Do you think melting libata sysfs object into scsi sysfs objects would
work with your changes related to pm?

Thanks,

Gwendal.
