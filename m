From: Richard Bland <rbland@combinedeffort.com>
Subject: HPA Problem in libata-core.c?
Date: Fri, 16 May 2008 19:26:01 +0100
Message-ID: <482DD1B9.6040408@combinedeffort.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010206050002040109080009"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c0mbinedeff0rt.demon.co.uk ([80.176.231.63]:57905 "EHLO
	mail.combinedeffort.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbYEPSzO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 May 2008 14:55:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010206050002040109080009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Apologies if I'm way off-base here, but I was having problems unlocking 
a HPA and took a look at the above.

It seemed the code was bailing before it unlocked the HPA, but would 
appreciate your feedback.

Cheers,

Rich

--------------010206050002040109080009
Content-Type: text/x-patch;
 name="libata-core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-core.patch"

--- libata-core.c~	2008-05-16 19:22:04.000000000 +0100
+++ libata-core.c	2008-05-16 19:08:42.000000000 +0100
@@ -1243,13 +1243,14 @@
 				"HPA detected: current %llu, native %llu\n",
 				(unsigned long long)sectors,
 				(unsigned long long)native_sectors);
-		else if (native_sectors < sectors)
+		else if (native_sectors < sectors) {
 			ata_dev_printk(dev, KERN_WARNING,
 				"native sectors (%llu) is smaller than "
 				"sectors (%llu)\n",
 				(unsigned long long)native_sectors,
 				(unsigned long long)sectors);
-		return 0;
+			return 0;
+		}
 	}
 
 	/* let's unlock HPA */

--------------010206050002040109080009--
