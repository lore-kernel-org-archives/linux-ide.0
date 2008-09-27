From: John Clark <clarkjc@runbox.com>
Subject: Interoperability problem with Quantum CD72SH SATA tape drive and
 libata
Date: Sat, 27 Sep 2008 16:25:19 -0400
Message-ID: <48DE96AF.6090301@runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aibo.runbox.com ([193.71.199.94]:57181 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbYI0UwB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Sep 2008 16:52:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello,

I've discovered an issue with the Quantum CD72SH SATA tape drive.  I set 
it to variable block size, try to write a 5317 byte block with an ATAPI 
issued WRITE(6), and it hangs.  The drive is connected to an Intel ICH9R 
in AHCI mode.

My debugging efforts have determined that it's a problem with the 
drive's firmware.  It does not like ATAPI CDBs with odd (& 1) transfer 
lengths with PIO.  If I let it use DMA, even if it's not a multiple of 
16 bytes, then it seems to work:

--- libata-core.c.orig    2008-09-27 16:12:46.000000000 -0400
+++ libata-core.c    2008-09-27 16:11:29.000000000 -0400
@@ -4669,8 +4669,8 @@
     /* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
      * few ATAPI devices choke on such DMA requests.
      */
-    if (unlikely(qc->nbytes & 15))
-        return 1;
+    // if (unlikely(qc->nbytes & 15))
+    //     return 1;
 
     if (ap->ops->check_atapi_dma)
         return ap->ops->check_atapi_dma(qc);



This is an acceptable solution for my limited use, but I'd like to see 
it work out of the box.  It seems frightening that there are ATAPI 
devices out there that choke on PIO requests.  What would you like to do?

Thank you.

- John
