From: "Adrian POPA" <adrianp@aageneral.ro>
Subject: Fw: [Bug 163753] Strange ATA HD configuration
Date: Wed, 12 Nov 2008 19:16:09 +0200
Message-ID: <008c01c944ea$5d600660$8c00000a@aageneral.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0089_01C944FB.1EB888E0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl86-34-224-74.romtelecom.net ([86.34.224.74]:64427 "EHLO
	mail.aageneral.ro" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbYKLRXz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 12:23:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzic@pobox.com, Lionel.Bouton@inet6.fr
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0089_01C944FB.1EB888E0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi
I have reported this bug quite a while but it was marked as Won't fix
However, I have a patch that you can test and which I am using since then.
Is no big deal and maybe it can be included in new builds. All builds (last
2.6.22-15.40) have the same bug and I have to replace modules after each
update.
Adrian

P.S. If you had the time to read up to this point, I can explain in a few
words what's the issue.
In libata-core.c:
Cable detection (40/80 wire) is now made on each attached drive and this is
not what the standards say. If a drive does not offer detection support or
says "don't care", it will be downgraded with no reason. The patch is doing
the detection by port plus all (one or two) attached HD, using the ATA
standard table to decide if the cable (for ALL drives) is to be declared 40
or 80 wire.

In pata_sis.c
There is a parameter missing in the udma table. It was originaly build for
ATA64 and then included for ATA100_old too. The entry for UDMA100 is
missing, garbage data is used to setup drive parameters and a bunch of
errors will occur until the system decides to downgrade the drive to UDMA64.

That's all



----- Original Message ----- 
From: "Adi POPA" <adrianp@aageneral.ro>
To: <adrianp@aageneral.ro>
Sent: Monday, November 19, 2007 11:21 AM
Subject: [Bug 163753] Strange ATA HD configuration


Public bug reported:

Binary package hint: linux-source-2.6.22

Ubuntu 2.6.22-14.46-server (Ubuntu 4.1.2-16ubuntu2) Sun Oct 14 23:34:23 GMT
2007
MB chipset SIS 730. IDE interface SIS 5513.
Two HDD an the same ATA cable (master/slave by jumpers), ATA 133/100
detected by AMIBIOS and set to ATA100 (max board cap)
One CDROM on IDE2 (checked with both ATA and IDE-40wire cables), UDMA33 by
BIOS
libata 2.21, pata_sis version 0.5.1 detects HD as UDMA/100 and CDROM as
UDMA/33 --> OK
and sis900.c - v1.08.10 loads
--> ata1.00: ... 16Sec max UDMA/133
--> ata1.01: ... 8Sec max UDMA/100
--> ata2.00: ... max UDMA/33
....
ata1.00: configured for UDMA/100 --> normal, board limit
ata1.01: limited to UDMA/33 due to 40-wire cable --> why? same cable!?
ata1.01: configured for UDMA/33 --> is this a bug?
ata2.00: configured for UDMA/33
.... some long (30 sec) stops on ata1.00 exception ... (timeout)
and then ata1.00 is limited even lower
ata1.00 configured for UDMA/66

** Affects: linux-source-2.6.22 (Ubuntu)
     Importance: Undecided
         Status: New

-- 
Strange ATA HD configuration
https://bugs.launchpad.net/bugs/163753
You received this bug notification because you are a direct subscriber
of the bug.

------=_NextPart_000_0089_01C944FB.1EB888E0
Content-Type: application/octet-stream;
	name="aag_source.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="aag_source.diff"

--- linux-source-2.6.22-2.6.22/drivers/ata/libata-core.c=0A=
+++ linux-source-2.6.22/drivers/ata/libata-core.c=0A=
@@ -2180,6 +2180,31 @@=0A=
 	/* Now ask for the cable type as PDIAG- should have been released */=0A=
 	if (ap->ops->cable_detect)=0A=
 		ap->cbl =3D ap->ops->cable_detect(ap);=0A=
+	=0A=
+	//<< AAG=0A=
+	// Match result with drive(s) indicator if present=0A=
+	// Maybe test bit 3 in id[80] for ATA3 compliance and=0A=
+	// give more credit to compliant drives.=0A=
+	if(ap->cbl =3D=3D ATA_CBL_PATA80 ||=0A=
+	   ap->cbl =3D=3D ATA_CBL_PATA_UNK) {=0A=
+=0A=
+	    for(i =3D (ATA_MAX_DEVICES - 1); i >=3D 0 && ap->cbl !=3D =
ATA_CBL_PATA40; i--) {=0A=
+		dev =3D &ap->device[i];=0A=
+		if(!ata_dev_enabled(dev))=0A=
+		    continue;=0A=
+		if((dev->id[93] & 0xC000) =3D=3D 0x4000) {=0A=
+		    // drive offers detection support=0A=
+		    int devcbl =3D (dev->id[93] & 0x2000) ? ATA_CBL_PATA80 : =
ATA_CBL_PATA40;=0A=
+		    if(ap->cbl =3D=3D ATA_CBL_PATA_UNK)=0A=
+			ap->cbl =3D devcbl; // take whatever the drive says=0A=
+		    else if(ap->cbl !=3D devcbl)=0A=
+			ap->cbl =3D ATA_CBL_PATA40; // missmatched report=0A=
+		}=0A=
+	    }=0A=
+	    if(ap->cbl =3D=3D ATA_CBL_PATA_UNK)=0A=
+		ap->cbl =3D ATA_CBL_PATA40;=0A=
+	}=0A=
+	//>> AAG=0A=
 =0A=
 	/* After the identify sequence we can now set up the devices. We do=0A=
 	   this in the normal order so that the user doesn't get confused */=0A=
@@ -3906,10 +3931,7 @@=0A=
 	 */=0A=
 	if (xfer_mask & (0xF8 << ATA_SHIFT_UDMA))=0A=
 		/* UDMA/44 or higher would be available */=0A=
-		if((ap->cbl =3D=3D ATA_CBL_PATA40) ||=0A=
-   		    (ata_drive_40wire(dev->id) &&=0A=
-		     (ap->cbl =3D=3D ATA_CBL_PATA_UNK ||=0A=
-                     ap->cbl =3D=3D ATA_CBL_PATA80))) {=0A=
+		if(ap->cbl =3D=3D ATA_CBL_PATA40) {=0A=
 		      	ata_dev_printk(dev, KERN_WARNING,=0A=
 				 "limited to UDMA/33 due to 40-wire cable\n");=0A=
 			xfer_mask &=3D ~(0xF8 << ATA_SHIFT_UDMA);=0A=
=0A=
--- linux-source-2.6.22-2.6.22/drivers/ata/pata_sis.c=0A=
+++ linux-source-2.6.22/drivers/ata/pata_sis.c=0A=
@@ -371,7 +371,7 @@=0A=
 	u16 timing;=0A=
 =0A=
 	const u16 mwdma_bits[] =3D { 0x707, 0x202, 0x202 };=0A=
-	const u16 udma_bits[]  =3D { 0xF000, 0xD000, 0xB000, 0xA000, 0x9000};=0A=
+	const u16 udma_bits[]  =3D { 0xF000, 0xD000, 0xB000, 0xA000, 0x9000, =
0x8000 };=0A=
 =0A=
 	pci_read_config_word(pdev, drive_pci, &timing);=0A=
 =0A=

------=_NextPart_000_0089_01C944FB.1EB888E0--

