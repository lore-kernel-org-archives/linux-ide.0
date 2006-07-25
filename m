From: "Steve Brown" <sbrown25@gmail.com>
Subject: PCI ID addition to sata_promise.c
Date: Tue, 25 Jul 2006 13:17:58 -0500
Message-ID: <1f4ef0970607251117i116b8466ma42a6d27c117196e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:59217 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964801AbWGYSR7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Jul 2006 14:17:59 -0400
Received: by ug-out-1314.google.com with SMTP id m3so2816712ugc
        for <linux-ide@vger.kernel.org>; Tue, 25 Jul 2006 11:17:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

I just bought a Promise FastTrack TX2300 SATAII RAID Controler and had
some problems getting it working.  I found that the driver did not
recognize the card b/c the PCI ID was not listed in the source.  Below
is a patch to add the PCI ID to the driver so hopefully others won't
have this problem in the future.  Patch if you like, discard if you
don't.  Just trying to make the world a little easier for the next
guy.

--- sata_promise.c.orig 2006-07-25 12:59:44.000000000 -0500
+++ sata_promise.c      2006-07-25 13:00:29.000000000 -0500
@@ -267,6 +267,9 @@

        { PCI_VENDOR_ID_PROMISE, 0x3570, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_20771 },
+       { PCI_VENDOR_ID_PROMISE, 0x3577, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_20771 },
+
        { }     /* terminate list */
 };
