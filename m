From: Andy Whitcroft <apw@canonical.com>
Subject: [PATCH 0/2] Hyper-V disk support V4
Date: Thu, 19 Apr 2012 15:33:08 +0100
Message-ID: <1334845990-13418-1-git-send-email-apw@canonical.com>
References: <20120419074018.GA3342@shadowen.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120419074018.GA3342@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

Add support for ignoring disks devices on specific host controllers to
libata.  Use this support to trigger us to ignore Hyper-V disk devices
on the emulated SATA device based on the system DMI information.

I have cleaned up the Hyper-V detection so it is only included when the
paravirtualised drivers are enabled.  I have also reintroduced the
override which had mysteriously gone missing in V3.

Comments?

-apw

V4
  - only enable the quirk when the paravirtualised drivers are compiled
  - fix up the command line flag to disable this support

V3
  - switch detection method to DMI information

V2 
  - create a generic libata quirk
  - switch detection to piix_init_one

Andy Whitcroft (2):
  libata: add a host flag to ignore detected ATA devices
  ata_piix: defer disks to the Hyper-V drivers by default

 drivers/ata/ata_piix.c    |   20 ++++++++++++++++++++
 drivers/ata/libata-core.c |    7 +++++++
 include/linux/libata.h    |    1 +
 3 files changed, 28 insertions(+)

-- 
1.7.9.5
