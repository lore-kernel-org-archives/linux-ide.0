From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 2.6.15-rc1] libata: fix comments on ata_tf_from_fis()
Date: Sat, 12 Nov 2005 18:55:45 -0500
Message-ID: <43768101.5000704@rtr.ca>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <43764904.5030309@rtr.ca> <4376788E.9010503@pobox.com> <437680BA.40707@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080409000106010101010805"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:23519 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964888AbVKLXzq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Nov 2005 18:55:46 -0500
In-Reply-To: <437680BA.40707@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080409000106010101010805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix description on comments for ata_tf_from_fis().

Signed-off-by: Mark Lord <mlord@pobox.com>

--------------080409000106010101010805
Content-Type: text/x-patch;
 name="comments.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="comments.patch"

--- linux-2.6.15-rc1/drivers/scsi/libata-core.c.orig	2005-11-11 20:43:36.000000000 -0500
+++ linux/drivers/scsi/libata-core.c	2005-11-12 18:46:40.000000000 -0500
@@ -532,8 +532,7 @@
  *	@fis: Buffer from which data will be input
  *	@tf: Taskfile to output
  *
- *	Converts a standard ATA taskfile to a Serial ATA
- *	FIS structure (Register - Host to Device).
+ *	Converts a serial ATA FIS structure to a standard ATA taskfile.
  *
  *	LOCKING:
  *	Inherited from caller.

--------------080409000106010101010805--
