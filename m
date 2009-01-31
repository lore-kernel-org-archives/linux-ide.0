From: Mark Lord <liml@rtr.ca>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Sat, 31 Jan 2009 11:35:56 -0500
Message-ID: <49847DEC.80603@rtr.ca>
References: <20090131122500.f6817013.cjsthompson@gmail.com>	<4984636C.8050609@ru.mvista.com> <20090131172746.f9b02ca5.cjsthompson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:42723 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbZAaQf7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2009 11:35:59 -0500
In-Reply-To: <20090131172746.f9b02ca5.cjsthompson@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Christoph .J Thompson" <cjsthompson@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

The only difference between those two identify packets
seems to be that the drive write-cache was disabled
when dumped from the pata_cs5536, and enabled when
dumped from AMD_IDE.

[~] diff -u 1.id 2.id
--- 1.id        2009-01-31 11:33:58.000000000 -0500
+++ 2.id        2009-01-31 11:34:11.000000000 -0500
@@ -31,7 +31,7 @@
 Commands/features:
        Enabled Supported:
           *    Power Management feature set
-               Write cache
+          *    Write cache
           *    Look-ahead
           *    WRITE_BUFFER command
           *    READ_BUFFER command
@@ -40,4 +40,4 @@
           *    Advanced Power Management feature set
           *    Mandatory FLUSH_CACHE
           *    CFA Power Level 1  (max 256mA)
-Integrity word not set (found 0x0000, expected 0x4da5)
+Integrity word not set (found 0x0000, expected 0x24a5)
