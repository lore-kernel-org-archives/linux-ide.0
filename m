From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata-core Use more robust parsing for multi_count
Date: Wed, 18 Mar 2009 10:26:05 -0400
Message-ID: <49C1047D.4000008@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:44670 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755362AbZCRO0M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Mar 2009 10:26:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Gents,

I am debugging a drive hang issue for a client,
which involves "multiple sector" read/write commands (PIO).

Libata does not appear (as of current #upstream at least)
to correctly implement this functionality.

Specifically, libata doesn't reset dev->multi_count to zero
on drive resets (whereas the drive firmware often *does*),
and libata does not deal well with dubious IDENTIFY data.

So, on resets, we should either clear dev->multi_count,
or re-probe it from the drive, or issue a SET_MULTIPLE command
to restore the old value.

When probing:

If (dev->id[59] == 0xffff), ignore it.
If (dev->id[59] & 0x00ff) is not an even power of two, ignore it.
it should also be ignored (this catches the 0xffff case too).

The powers of two is from the ATA8 standard, which strongly suggests
that only powers of two are valid for use with SET_MULTIPLE.

The probe stuff is trivial to fix (below), but I'm not really
up to speed on figuring out how to get this code re-invoked
after drive resets, and on how to ensure that a SET_MULTIPLE
gets issued to restore the previous working value (with eventual
fallback to not using it after repeated errors).   Tejun?

<--- snip --->

Make libata a little more robust in parsing the multi_count
field from a drive's identify data.  This prevents libata from
attempting to use dubious multi_count values ad infinitum.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- upstream/drivers/ata/libata-core.c	2009-03-18 10:21:07.000000000 -0400
+++ new/drivers/ata/libata-core.c	2009-03-18 10:22:05.000000000 -0400
@@ -2426,9 +2426,20 @@
 
 		dev->n_sectors = ata_id_n_sectors(id);
 
-		if (dev->id[59] & 0x100)
-			dev->multi_count = dev->id[59] & 0xff;
-
+		dev->multi_count = 0;
+		if (dev->id[59] & 0x100) {
+			switch (dev->id[59] & 0xff) {
+			case 1:
+			case 2:
+			case 4:
+			case 8:
+			case 16:
+			case 32:
+			case 64:
+			case 128:
+				dev->multi_count = dev->id[59] & 0xff;
+			}
+		}
 		if (ata_id_has_lba(id)) {
 			const char *lba_desc;
 			char ncq_desc[20];
