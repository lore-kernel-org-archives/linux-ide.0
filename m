From: "Shawn Starr" <sstarr@platform.com>
Subject: [PATCH][2.6.12-rc4][SATA] sil driver - Blacklist Maxtor disk - Redux
Date: Tue, 24 May 2005 13:13:35 -0400
Message-ID: <9CD190F4AD92EC499A9397F49C8B0E4E01E8EC86@catoexm04.noam.corp.platform.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailtir.platform.com ([192.219.104.248]:63112 "EHLO
	mailtir.platform.com") by vger.kernel.org with ESMTP
	id S261292AbVEXRNh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 May 2005 13:13:37 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Yes, I know we shouldn't do this, but at the current
time, this seems to fix DMA READ/WRITE timeout
problems. This also may fix the sata_nv driver as
well, but this seems indicate that there is a lowlevel
problem with the SATA subsystem. 

Signed-off-by: Shawn Starr <shawn.starr@rogers.com>

--- sata_sil.c.old      2005-05-24 12:19:20.312197269 -0400
+++ sata_sil.c  2005-05-11 14:05:26.000000000 -0400
@@ -93,6 +93,7 @@ struct sil_drivelist {
        { "ST380011ASL",        SIL_QUIRK_MOD15WRITE },
        { "ST3120022ASL",       SIL_QUIRK_MOD15WRITE },
        { "ST3160021ASL",       SIL_QUIRK_MOD15WRITE },
+       { "Maxtor 6Y080M0",     SIL_QUIRK_MOD15WRITE },
        { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },
        { }
 };
