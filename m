Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D70C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 01:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiDYBh4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 21:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240179AbiDYBha (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 21:37:30 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2715BEE989
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 18:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650850468; x=1682386468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2gb9ZbRuGLhgbilCIjbrPF15OV9shU7ZieMSAoKjS8w=;
  b=ggiWl/+PCMCRqu/Td8QwrgmoW/ug5OoF6VPhIMUsDlu0yAQ5YPgK6KUO
   +ptAWbpf7PK2OdppjtIVetJirTlY+/D2hk0mo4b90lhy4NXEk2kwUi+6M
   3z+nCcbZV/O3CIUYG22a2fBLiTECKw5stAIU1icap53g5DOGLxGrx3FKs
   Ia4rFzzrl86fLGuNn5fXOJfhv73O0icMkgjXVe8kEDE4ue7umbtbZJt5f
   MagvlDiemO9Oro7A4FzWFo9thJhEJqS8hF1uBT+7isLtkAc766OcT0oT7
   FAE2Jt/PSKHfNWD6CtPPvpJfgC+lKnERh5vC2u18A0WImg+bnzhEkWt9u
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="302917798"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 09:34:26 +0800
IronPort-SDR: s3ALqgxsVoCOaMHr5jTSgVsjzQlEfC+zk7JTnIzb7G1y8q7kP7lGD1ikUatxt553rf9l3oW3e5
 M/k9I1Po5rNWkCD9Z6NBYcydBVqAos3cpIdGCmP56bbebXxNMUKjJR1fKmAzCmbjtjq66/2EV1
 qoXLxgMXPL2iVRxdCV1CxODIDY6x42Sr48OxdS07xcVrPRo0fE/sxpwhvha3AgxHZ6rGETTj+t
 oSjBJe4K5JNfL7LKeYDv1To4GsC9FWBpeNY8WThlwe9i1+v7G5hBCauoIW7P/cPM/6/oOnFaB5
 IDmifG6CCtKZyICOWcrrUNkQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 18:05:23 -0700
IronPort-SDR: IT9i3sSvIi3YtnfiFSU1w6FIXKs71LGxBfxPRO5fQf+FYB040Ii2WJnu8HIhytevYr2XFcK6U2
 J3hp/BgQtK00fbluzqp+8REjd3iKBV8ea2xv1OakEBBkHCQPNUY5/paCnJEHbu/9hEQ5Sb/UKA
 sUaNmXtZlr0mToqVyLvBEm/q/nbMdmdst/wXKc2immzK/n/cDq1NuZKZRcS7DnTGFihC/oaKsw
 YLRw4Mbx8vugaB1ByiK6mcGBvT1GBc5tD0t70L3teWZ9YDW4zBaoGOWuP1ZE8PpgblUvGBAZiT
 waE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 18:34:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KmncL0n4Rz1Rvlx
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 18:34:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650850465; x=1653442466; bh=2gb9ZbRuGLhgbilCIj
        brPF15OV9shU7ZieMSAoKjS8w=; b=IZZvGWR4CF3CHcDWnV5Wc1aR4pQ1zfF/8a
        Ef7Qzg6RyC4egI2mboX54OtnDwXZsw1UdIslfjlVC4mRH5eSaSEfKYz/+drIMhgK
        PpnOJ+4tunSvm6F3tobgSFmNBdGn0GMl9+1EJQZYTKmpKBXfW7JkMNO870Wfmjws
        26Jp/ejqYz2bSQeVxFarzKENp845AF7aXorqTlHHsPXbZATCd01GQrT+F/wpebbu
        jfFYmIKZ3/LmMUGvqUgx5i25O5VUky3QBVpt4yyT1kVoHYK409JUtq7RAIwT0JcN
        wm6sBY53jDlc6S4ppjUcPFFTqkv+EbfOp//AYwG8HYLFypNuMg+g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tQfRr8Eln9xb for <linux-ide@vger.kernel.org>;
        Sun, 24 Apr 2022 18:34:25 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KmncJ6MHSz1Rwrw;
        Sun, 24 Apr 2022 18:34:24 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 5/5] doc: admin-guide: Update libata kernel parameters
Date:   Mon, 25 Apr 2022 10:34:17 +0900
Message-Id: <20220425013417.3947791-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
References: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Cleanup the text text describing the libata.force boot parameter and
update the list of the values to include all supported horkage and link
flag that can be forced.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 .../admin-guide/kernel-parameters.txt         | 71 ++++++++++++++-----
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..00fb37cab649 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2622,14 +2622,14 @@
 			when set.
 			Format: <int>
=20
-	libata.force=3D	[LIBATA] Force configurations.  The format is comma-
-			separated list of "[ID:]VAL" where ID is
-			PORT[.DEVICE].  PORT and DEVICE are decimal numbers
-			matching port, link or device.  Basically, it matches
-			the ATA ID string printed on console by libata.  If
-			the whole ID part is omitted, the last PORT and DEVICE
-			values are used.  If ID hasn't been specified yet, the
-			configuration applies to all ports, links and devices.
+	libata.force=3D	[LIBATA] Force configurations.  The format is a comma-
+			separated list of "[ID:]VAL" where ID is PORT[.DEVICE].
+			PORT and DEVICE are decimal numbers matching port, link
+			or device.  Basically, it matches the ATA ID string
+			printed on console by libata.  If the whole ID part is
+			omitted, the last PORT and DEVICE values are used.  If
+			ID hasn't been specified yet, the configuration applies
+			to all ports, links and devices.
=20
 			If only DEVICE is omitted, the parameter applies to
 			the port and all links and devices behind it.  DEVICE
@@ -2639,7 +2639,7 @@
 			host link and device attached to it.
=20
 			The VAL specifies the configuration to force.  As long
-			as there's no ambiguity shortcut notation is allowed.
+			as there is no ambiguity, shortcut notation is allowed.
 			For example, both 1.5 and 1.5G would work for 1.5Gbps.
 			The following configurations can be forced.
=20
@@ -2652,19 +2652,58 @@
 			  udma[/][16,25,33,44,66,100,133] notation is also
 			  allowed.
=20
+			* nohrst, nosrst, norst: suppress hard, soft and both
+			  resets.
+
+			* rstonce: only attempt one reset during hot-unplug
+			  link recovery.
+
+			* [no]dbdelay: Enable or disable the extra 200ms delay
+			  before debouncing a link PHY and device presence
+			  detection.
+
 			* [no]ncq: Turn on or off NCQ.
=20
-			* [no]ncqtrim: Turn off queued DSM TRIM.
+			* [no]ncqtrim: Enable or disable queued DSM TRIM.
+
+			* [no]ncqati: Enable or disable NCQ trim on ATI chipset.
+
+			* [no]trim: Enable or disable (unqueued) TRIM.
+
+			* trim_zero: Indicate that TRIM command zeroes data.
+
+			* max_trim_128m: Set 128M maximum trim size limit.
+
+			* [no]dma: Turn on or off DMA transfers.
+
+			* atapi_dmadir: Enable ATAPI DMADIR bridge support.
+
+			* atapi_mod16_dma: Enable the use of ATAPI DMA for
+			  commands that are not a multiple of 16 bytes.
+
+			* [no]dmalog: Enable or disable the use of the
+			  READ LOG DMA EXT command to access logs.
+
+			* [no]iddevlog: Enable or disable access to the
+			  identify device data log.
+
+			* [no]logdir: Enable or disable access to the general
+			  purpose log directory.
+
+			* max_sec_128: Set transfer size limit to 128 sectors.
+
+			* max_sec_1024: Set or clear transfer size limit to
+			  1024 sectors.
=20
-			* nohrst, nosrst, norst: suppress hard, soft
-			  and both resets.
+			* max_sec_lba48: Set or clear transfer size limit to
+			  65535 sectors.
=20
-			* rstonce: only attempt one reset during
-			  hot-unplug link recovery
+			* [no]lpm: Enable or disable link power management.
=20
-			* dump_id: dump IDENTIFY data.
+			* [no]setxfer: Indicate if transfer speed mode setting
+			  should be skipped.
=20
-			* atapi_dmadir: Enable ATAPI DMADIR bridge support
+			* dump_id: Dump IDENTIFY data.
=20
 			* disable: Disable this device.
=20
--=20
2.35.1

