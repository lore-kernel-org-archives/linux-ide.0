From: Joe Thomas <Joe.Thomas@dothill.com>
Subject: Bug (?) in ata (ahci) driver can lead to panic with ZPODD and unbind
Date: Wed, 12 Mar 2014 05:30:26 -0600
Message-ID: <235852D532FB204FB039DAF645E587C7B506036AFA@dc-ex1.power.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.dothill.com ([155.254.1.50]:42980 "EHLO mail1.dothill.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754079AbaCLLab convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2014 07:30:31 -0400
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I'm seeing a panic in the ATA driver when the platform supports ZPODD, and I'm trying to determine if it's a true bug or if we're doing things wrong...


Background:

We are installing a 3rd party ATA driver that supports ZPODD. With Ubuntu based systems (specifically 13.04 and 13.10), we need to unbind the kernel driver before the new driver can replace it.
                i.e. 'echo "0000:00:11.0" > /sys.bus/pci/drivers/ahci/unbind'

Issue:
                If platform has an optical device (ODD) that supports Zero Power (ZPODD), then the driver installs a NOTIFY handler...
                                acpi_install_notify_handler() call in libata-zpodd.c/ata_acpi_add_pm_notifier()
                When the driver unbinds, acpi_remove_notify_handler() is never called...
                If replacement driver places the ODD in zero power state (or if original driver does so before the driver is unbound), then if the USER initiates a NOTIFY (by inserting media in a slot device or pressing eject on tray device), then the kernel will attempt to call the NOTIFY handler in ata/ahci and will panic (zpodd_wake_dev() is called but the context is no longer valid, etc.). [If the platform/kernel wakes the device, then the NOTIFY handler isn't called and it's not an issue. It MUST be the user initiated NOTIFY.]

Analysis:
                On unbind, call path is:
                                ata_pci_remove_one()
                                calls ata_host_detach()
                                calls ata_port_detach()
                                also calls ata_acpi_dissociate()

                In order to remove the NOTIFY handler, ata_acpi_remove_pm_notifier() needs to be called from zpodd_exit()
                zpodd_exit() is called from ata_scsi_remove_dev() but that doesn't seem to ever be called during 'unbind'.


Question:
                Is this really a bug? i.e. 'unbind' should cause zpodd_exit() (or ata_scsi_remove_dev()) to be called...
or
                Are we missing a step before the 'unbind' where we need to cause the attached devices to be removed first (thus ensuring ata_scsi_remove_dev() be called)?


Have not seen this on SLES based systems.

Have not tried to "produce" this with running off USB but one might be able to boot Ubuntu from USB stick, allow ODD to enter zpodd state, unbind the achi driver, signal the notify (press button/insert media)...
Requires ODD capable device and some means to know that device is actually in ZPODD state... [My platform has led on motherboard for ODD power as well as bios setting codes on diag 7-seg led when ACPI _PS0() or _PS3() are called.]

Thanks.



// Joseph Thomas
// Principal Software Engineer
// Dot Hill Systems
// 2905 NorthWest Blvd., Suite 20
// Plymouth, MN 55441
// 763.226.2640

