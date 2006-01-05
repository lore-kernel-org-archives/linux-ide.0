From: Diego Calleja <diegocg@gmail.com>
Subject: [PATCH] documentation typo
Date: Thu, 5 Jan 2006 13:20:14 +0100
Message-ID: <20060105132014.d72f61db.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.193]:40126 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751484AbWAEMUX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jan 2006 07:20:23 -0500
Received: by uproxy.gmail.com with SMTP id s2so925282uge
        for <linux-ide@vger.kernel.org>; Thu, 05 Jan 2006 04:20:21 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

According to a bug reported in bugzilla...

--- 2.6/Documentation/ide.txt.wrong	2006-01-05 13:16:06.000000000 +0100
+++ 2.6/Documentation/ide.txt	2006-01-05 13:16:10.000000000 +0100
@@ -244,7 +244,7 @@ Summary of ide driver parameters for ker
 
  "hdx=bswap"		: same as above..........
 
- "hdx=scsi"		: the return of the ide-scsi flag, this is useful for
+ "hdx=ide-scsi"		: the return of the ide-scsi flag, this is useful for
  			  allowing ide-floppy, ide-tape, and ide-cdrom|writers
  			  to use ide-scsi emulation on a device specific option.
 
