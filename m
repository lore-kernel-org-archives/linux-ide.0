From: Faik Uygur <faik@pardus.org.tr>
Subject: [PATCH] kernel-parameters.txt: ATAPI enabled by default
Date: Wed, 14 Mar 2007 11:07:40 +0200
Message-ID: <200703141107.41168.faik@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.uludag.org.tr ([193.140.100.220]:41346 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965268AbXCNJGU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Mar 2007 05:06:20 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

In case of libata, discovery of ATAPI devices is the default behaviour.

Signed-off-by: Faik Uygur <faik@pardus.org.tr>

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 856c8b1..96b6ec5 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -695,11 +695,9 @@ and is between 256 and 4096 characters. It is defined in the file
 			Format: <irq>
 
 	combined_mode=	[HW] control which driver uses IDE ports in combined
-			mode: legacy IDE driver, libata, or both
-			(in the libata case, libata.atapi_enabled=1 may be
-			useful as well).  Note that using the ide or libata
-			options may affect your device naming (e.g. by
-			changing hdc to sdb).
+			mode: legacy IDE driver, libata, or both. Note that
+			using the ide or libata options may affect your device
+			naming (e.g. by changing hdc to sdb).
 			Format: combined (default), ide, or libata
 
 	inttest=	[IA64]
