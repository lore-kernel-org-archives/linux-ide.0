From: =?ISO-8859-1?Q?Ren=E9_Bolldorf?= <xsecute@googlemail.com>
Subject: [PATCH]drivers/ata/libata-eh.c:1509 unneeded memset()
Date: Wed, 30 Dec 2009 23:59:50 +0100
Message-ID: <4B3BDB66.6000008@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:39295 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbZL3W74 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Dec 2009 17:59:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

We don't need this ;-).

Best regards Ren=E9 Bolldorf & a happy new year in advance.

--- ./drivers/ata/libata-eh.c  2009-12-30 23:44:05.578988545 +0100
+++ ./drivers/ata/libata-eh.c  2009-12-30 23:45:06.991987607 +0100
@@ -1505,9 +1505,6 @@ static unsigned int atapi_eh_request_sen

  	DPRINTK("ATAPI request sense\n");

-	/* FIXME: is this needed? */
-	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
-
  	/* initialize sense_buf with the error register,
  	 * for the case where they are -not- overwritten
  	 */
