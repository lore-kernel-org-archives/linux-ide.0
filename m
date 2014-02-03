From: Michael Marley <michael@michaelmarley.com>
Subject: [PATCH] ACHI: Attempt to enable a single MSI if block enable fails
Date: Mon, 03 Feb 2014 15:39:27 -0500
Message-ID: <52EFFE7F.6050807@michaelmarley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:61913 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751114AbaBCUj3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 15:39:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

From: Michael Marley <michael@michaelmarley.com>

Commit 7b92b4f61ec49cb1a5813298f35258bd7ecd3667 ("PCI/MSI: Remove
pci_enable_msi_block_auto()") causes the AHCI driver to immediately
switch to INTx mode if the pci_enable_msi_block() call fails to
allocate the requested number of MSIs. This behavior causes some
systems (for example, the Lenovo ThinkCentre m57p) to begin using
INTx when they worked fine in single MSI mode before.  This patch
makes the driver try to enable a single MSI if the
pci_enable_msi_block() call fails instead of switching directly
to INTx.

Signed-off-by: Michael Marley <michael@michaelmarley.com>

- ---

- --- drivers/ata/ahci.c.orig	2014-02-03 20:00:04.834008843 +0000
+++ drivers/ata/ahci.c	2014-02-03 19:34:53.737257483 +0000
@@ -1171,7 +1171,7 @@ static int ahci_init_interrupts(struct p
 	nvec = rc;
 	rc = pci_enable_msi_block(pdev, nvec);
 	if (rc)
- -		goto intx;
+		goto single_msi;

 	return nvec;

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS7/5/AAoJEANTUn3blhEaLo8P/31AEbD9b61h2zFAcGlqZmN/
OEp69smHl9DbciaL0nQGIY4TRUpjA2XVxT/ZC3Fdz0huqX226g2D2G7/LLk299r3
m/GC89640FBRaVqNTASNKvIANlq0t2vgdOXGsgLXCD3EAigMdCVLiKNvdDYpUdXo
uaUg7WTVM12U+bWCrTB0RVgU7kKqkPSWb59kUPFaInjrTWzZ4jf4SZEzOr1b6mB0
Ihn/BsMf76q9rzGEwTaKPV+BrS/QZY5oz23r8+Pqw+lNVgtnmCQ7UkRJ40MI3roS
lU68syoG/CjI6imO/TQcr54eHMTBRl55Ut4VO/iLYaJKhXGGsuP43oPrJM0LZzpi
jjwzgz4Bij0Hi5Wx7AS0sDNEERi+w4At/+eKQmUkjA6qUblzIKCpMMCmp0CvodXH
8J9TU9CqcnQs2hgGy990nFxdmiLh+Ee5NFBfKxpTGxv4eAjuK6RbxMLfndF6rRXO
MpMoFMK3BdFnQoi6We5er7HKPcbqOpR2hrw8mALhWDxgv+N2pq1J5uG69mc5vwxJ
YV7N0tnCtVTyxGavtMP669YCNH0KvRzXJvzJRE1TuuTvNu+oudMWJinilyhPnYJk
U5DYzLWj4t42qEsGr3QjFBEv90DG/LNc5YavI9XOfepjGFbdlcGQPAe3HnaE86KD
s9JiFcvAixL295414PRN
=f6LE
-----END PGP SIGNATURE-----
