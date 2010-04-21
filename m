From: Roman Fietze <roman.fietze@telemotive.de>
Subject: [PATCH] libata: port and device of libata.force ID separated by point
Date: Wed, 21 Apr 2010 12:17:12 +0200
Message-ID: <201004211217.12697.roman.fietze@telemotive.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coyote.quickmin.net ([217.14.112.24]:59434 "EHLO
	coyote.quickmin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910Ab0DUKX6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Apr 2010 06:23:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello,

If I understand libata-core correctly, esp. arround line 6572:

	/* parse id */
	p =3D strchr(id, '.');
	...

the optional device is separated from the port in the libata.force ID
by a point or dot instead of by a colon.

If my assumption is correct, this patch will fix the documentation:

Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
---
 Documentation/kernel-parameters.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel=
-parameters.txt
index e7848a0..ea5a826 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1193,7 +1193,7 @@ and is between 256 and 4096 characters. It is def=
ined in the file
=20
 	libata.force=3D	[LIBATA] Force configurations.  The format is comma
 			separated list of "[ID:]VAL" where ID is
-			PORT[:DEVICE].  PORT and DEVICE are decimal numbers
+			PORT[.DEVICE].  PORT and DEVICE are decimal numbers
 			matching port, link or device.  Basically, it matches
 			the ATA ID string printed on console by libata.  If
 			the whole ID part is omitted, the last PORT and DEVICE
--=20
1.7.0.3




Roman

--=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
