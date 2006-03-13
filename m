From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH] libata crashes on incorrectly initialised ports
Date: Mon, 13 Mar 2006 10:14:56 +0100
Message-ID: <44153810.10702@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040205030505070303060101"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:37601 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932380AbWCMJO5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 04:14:57 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040205030505070303060101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

Randy found an interesting usage of the label 'err_out' in
libata-core.c:ata_device_add().

'err_out' is meant to be called to teardown existing sysfs entries.
As such is it clearly wrong to call it if the sysfs registration fails.

Please apply.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstra=DFe 5				+49 911 74053 688
90409 N=FCrnberg				http://www.suse.de

--------------040205030505070303060101
Content-Type: text/plain;
 name="libata-host-add-failure"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-host-add-failure"

From: Hannes Reinecke <hare@suse.de>
Subject: libata crashes on incorrectly initialized ports

Randy Dunlap noted:
With the update ahci I am getting these messages (typed by
me, no serial port for console), but ata2 drive is not present (!?):

ata2: could not start DMA engine
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000

plus a Call Trace like so (names only transcribed here):
class_device_del
class_device_unregister
scsi_remove_host
ata_host_remove
ata_device_add
ahci_init_one
... normal pci driver init/register functions ...


The label 'err_out' is used twice; the first usage of which is wrong
as there is not host registered in sysfs which we could deregister.
In fact, we haven't done anything (yet) so we might as well return
here.

Signed-off-by: Hannes Reinecke <hare@suse.de>

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ab3257a..42e5c40 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4578,7 +4578,7 @@ int ata_device_add(const struct ata_prob
 
 		ap = ata_host_add(ent, host_set, i);
 		if (!ap)
-			goto err_out;
+			return 0;
 
 		host_set->ports[i] = ap;
 		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |

--------------040205030505070303060101--
