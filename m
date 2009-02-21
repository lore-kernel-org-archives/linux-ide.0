From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] hdparm: Show form factor and media rotation rate
Date: Fri, 20 Feb 2009 20:01:25 -0500
Message-ID: <yq1fxi8eh7e.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet11.oracle.com ([141.146.126.233]:25759 "EHLO
	acsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbZBUBBf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Feb 2009 20:01:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org


Make hdparm display form factor and media rotation rate when using -I.

Surprisingly, I have a few devices that export these already.

diff -purN -X /home/mkp/bin/dontdiff hdparm-9.11.orig/identify.c hdparm-9.11/identify.c
--- hdparm-9.11.orig/identify.c	2009-01-27 12:48:41.000000000 -0500
+++ hdparm-9.11/identify.c	2009-02-20 19:56:12.000000000 -0500
@@ -96,6 +96,7 @@
 #define RM_STAT 		127 /* removable media status notification feature set support */
 #define SECU_STATUS		128 /* security status */
 #define CFA_PWR_MODE		160 /* CFA power mode 1 */
+#define FORM_FACTOR		168 /* device nominal form factor */
 #define START_MEDIA             176 /* media serial number */
 #define LENGTH_MEDIA            20  /* 20 words (40 bytes or characters)*/
 #define START_MANUF             196 /* media manufacturer I.D. */
@@ -103,6 +104,7 @@
 #define SCT_SUPP		206 /* SMART command transport (SCT) support */
 #define TRANSPORT_MAJOR		222 /* PATA vs. SATA etc.. */
 #define TRANSPORT_MINOR		223 /* minor revision number */
+#define NMRR			217 /* nominal media rotation rate */
 #define INTEGRITY		255 /* integrity word */
 
 /* bit definitions within the words */
@@ -897,6 +899,35 @@ void identify (__u16 *id_supplied)
 	}
 	putchar('\n');
 
+	/* Form factor */
+	if(val[FORM_FACTOR] > 0) {
+		printf("\tForm Factor: ");
+		switch(val[FORM_FACTOR]) {
+		case 1:
+			printf("5.25 inch");
+			break;
+		case 2:
+			printf("3.5 inch");
+			break;
+		case 3:
+			printf("2.5 inch");
+			break;
+		case 4:
+			printf("1.8 inch");
+			break;
+		default:
+			printf("unknown");
+			break;
+		}
+		printf("\n");
+	}
+
+	/* Spinning disk or solid state? */
+	if(val[NMRR] == 1)
+		printf("\tNominal Media Rotation Rate: Solid State Device\n");
+	else if(val[NMRR] > 0x401)
+		printf("\tNominal Media Rotation Rate: %u\n", val[NMRR]);
+
 	/* hw support of commands (capabilities) */
 	printf("Capabilities:\n");
 	printf("\t");
