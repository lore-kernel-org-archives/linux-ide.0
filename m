From: Ben Hutchings <ben@decadent.org.uk>
Subject: Bug#634180: [PATCH] ahci: Add JMicron 362 device IDs
Date: Fri, 22 Jul 2011 01:43:22 +0200
Message-ID: <1311291802.28569.93.camel@localhost>
Reply-To: Ben Hutchings <ben@decadent.org.uk>, 634180@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.634180.B634180.131129181928776@bugs.debian.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>, 634180@bugs.debian.org
List-Id: linux-ide@vger.kernel.org

The JMicron JMB362 controller supports AHCI only, but some revisions
use the IDE class code.  These need to be matched by device ID.

These additions have apparently been included by QNAP in their NAS
devices using these controllers.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
This is basically the same change made by unknown persons at QNAP.
However, I think the only copyrightable part (if any) is the comment,
which is my own.  Therefore I believe I can sign this off myself.

Ben.

 drivers/ata/ahci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index fd318ac..67dbd6a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -263,6 +263,9 @@ static const struct pci_device_id ahci_pci_tbl[] =3D {
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },
+	/* JMicron 362B and 362C have an AHCI function with IDE class code */
+	{ PCI_VDEVICE(JMICRON, 0x2362), board_ahci_ign_iferr },
+	{ PCI_VDEVICE(JMICRON, 0x236f), board_ahci_ign_iferr },
=20
 	/* ATI */
 	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */
--=20
1.7.5.4
