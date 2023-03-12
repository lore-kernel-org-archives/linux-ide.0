Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB45C6FD1F
	for <linux-ide@archiver.kernel.org>; Sun, 12 Mar 2023 23:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCLX4I (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Mar 2023 19:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCLX4H (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2023 19:56:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A330294;
        Sun, 12 Mar 2023 16:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qEMbQl2Qv6g66qdNT3wlbLmVyaW+mXSdO7SM3E7aHeo=; b=S7RTbYbFj5gW7oiAaCBXHZ5hw5
        coS4p/FQbo7dgSsvroDZr/nYxuudIBkqZfWLSDRhbRqNGeGrjDzpqAjoNcOLY44RrTYzjko3lLUA0
        lQl+mjBv6+4M5dwXJQIQuPczbASEfDK+MDS02DS41q8ByzIGmapMkvhLVJPZuual0aEWgOR1OL1Sm
        bQmqijt3AmOpAGNL4qI8J3LYh0PXMhzip4FibxmHCM4nr72clxX5E3Z0Y9joEuXKIQa96IF+AnP47
        bkQLfv4RBwsebu9kvPXiB1wkLF+lHD2oHfAsxN/Fo0H6C5Q64hSpuqHyMELQLZiqnoPdQBQ37fYWC
        WGyaagIQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbVXg-003qDa-9l; Sun, 12 Mar 2023 23:55:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-um@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] UML: pata_cs5536: fix build for X86_32 UML with TRACEPOINTS
Date:   Sun, 12 Mar 2023 16:55:53 -0700
Message-Id: <20230312235553.26298-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Current build of pata_cs5536 for i386 UML fails with:

ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!

Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-ide@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/x86/um/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/x86/um/Makefile b/arch/x86/um/Makefile
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -21,7 +21,7 @@ obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
-subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
+subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o ../lib/msr.o
 subarch-y += ../kernel/sys_ia32.o
 
 else
