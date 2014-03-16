From: Tim Gardner <tim.gardner@canonical.com>
Subject: linux-next: ahci_platform broken build
Date: Sun, 16 Mar 2014 08:05:38 -0600
Message-ID: <5325AFB2.4050505@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tpi.com ([74.45.170.26]:52419 "EHLO mail.tpi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbaCPOiH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Mar 2014 10:38:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dann frazier <dann.frazier@canonical.com>

Gents  - while reviewing some patches for arm64 in Ubuntu I noticed tha=
t=20
there is at least one patch sequence in linux-next that breaks the buil=
d.

156c5887948cd191417f18026aab9ce26e5a95da ahci-platform: Add support for=
=20
devices with more then 1 clock
039ece38da45f5e6a94be3aa7611cf3634bc2461 libahci: Allow drivers to=20
override start_engine

=46or example:

git reset --hard 156c5887948cd191417f18026aab9ce26e5a95da
echo "CONFIG_SATA_AHCI_PLATFORM=3Dy" >> .config
make oldconfig scripts prepare
make M=3Ddrivers/ata

   WARNING: Symbol version dump /home/rtg/linux/linux-next/Module.symve=
rs
            is missing; modules will have no dependencies and modversio=
ns.

   CC      drivers/ata/libata-core.o
   CC      drivers/ata/libata-scsi.o
   CC      drivers/ata/libata-eh.o
   CC      drivers/ata/libata-transport.o
   CC      drivers/ata/libata-sff.o
   CC      drivers/ata/libata-pmp.o
   CC      drivers/ata/libata-acpi.o
   LD      drivers/ata/libata.o
   CC      drivers/ata/ahci.o
   CC      drivers/ata/libahci.o
   CC      drivers/ata/ahci_platform.o
drivers/ata/ahci_platform.c: In function =91ahci_probe=92:
drivers/ata/ahci_platform.c:209:2: error: implicit declaration of=20
function =91ahci_enable_clks=92 [-Werror=3Dimplicit-function-declaratio=
n]
drivers/ata/ahci_platform.c:293:2: error: implicit declaration of=20
function =91ahci_disable_clks=92 [-Werror=3Dimplicit-function-declarati=
on]
cc1: some warnings being treated as errors
make[1]: *** [drivers/ata/ahci_platform.o] Error 1
make: *** [_module_drivers/ata] Error 2

The compile problem is then fixed in=20
96a01ba52c60fdd74dd6e8cf06645d06515b1396 (ahci-platform: Add enable_ /=20
disable_resources helper functions) which is not really kosher.

It seems like you ought to fix this before the 3.15 merge window opens.

rtg
--=20
Tim Gardner tim.gardner@canonical.com
