Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8837FC48BC2
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 05:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726636141E
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 05:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhFFF5q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Jun 2021 01:57:46 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:42797 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFFF5p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jun 2021 01:57:45 -0400
Received: by mail-pf1-f181.google.com with SMTP id s14so9765776pfd.9;
        Sat, 05 Jun 2021 22:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LqikQHxG7iEVA7mrbuxUHzdlLvZ5ezXbP+1aLN74F2A=;
        b=CqnJDa5A7RJKxCEUmvxCjJ0pfxfs3MNN9T8QeCZBCTa+BtQDtnc8bEQi75LR+CKHgL
         J3rYlCjLWeIYhzlgWNZmObTapfUaPj/ZOw8F2zF2m9ILNXIxw4oyPrOzjRhWKWFjHaXF
         3opMHPhbtUHHapS5dsS6Egv3AXNSTwop5xW4xFBjl5WU3+nhxyjDMcuE+pWZc84oFkhO
         +8jkBk3l/Y4OYahI4PZHFaOHzFrnpxywCB1tvP7ETvOg+V0NhVwcvJP+KF8B8ZJ5cDCL
         lanYEUAmSfFxxcGV+b5Tg1UIag0bdsRKaESpANNZtfEuTH1LM3BH2Rv6/5ogv7fC+moj
         LwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LqikQHxG7iEVA7mrbuxUHzdlLvZ5ezXbP+1aLN74F2A=;
        b=JVRMY/YfyRS+WC9cIKnlGm3pZV16DkqzOrai7U3oA8Als0z1gv0tUnLjoO1+RZQ1/C
         2h/1YwqsbUltpYpLI9iT2mZCHFKPa9myJyTeIXgcqx+v5kSy/ScCoDjbeWODbg+Tjp1a
         U696iw4+MstIe3euWsro27xRFJDsnqGoX510vILEVBgCi75K9VoVVQsKJva1WIz7P+/x
         HbcOFAuzQxqAP+nVdEhOXk2cgKDOKOL/kD+2TVXmIS0FZ64NVJkMFGYqSaeZmn0Fhsbo
         1O3lG7sXUL7KGXoOZ3he77czIX6b+v6GKFfuJn5uh138pqT4Toirmb3iDu6xFGiJgTTX
         hWVQ==
X-Gm-Message-State: AOAM533ixNKT5JTbaPtws9+2F3cNIO6hmkYt9UvdDsOnnziem46u/wnr
        iBQ1q7AW2v2y3fF30yDqpgs=
X-Google-Smtp-Source: ABdhPJx/rJp3lzEQ69iFjwrSZxUIfxwypzsxWPLFXEdf0Cuiyanqpu6YU7Uz27zryxkz2VgDaOeLRw==
X-Received: by 2002:aa7:8392:0:b029:2db:4a7:d866 with SMTP id u18-20020aa783920000b02902db04a7d866mr11851638pfm.66.1622958887478;
        Sat, 05 Jun 2021 22:54:47 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id e24sm5779310pgi.17.2021.06.05.22.54.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 22:54:47 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id A5B7B3603D9; Sun,  6 Jun 2021 17:54:43 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH RFC 1/2] m68k: io_mm.h - add APNE 100 MBit support
Date:   Sun,  6 Jun 2021 17:54:36 +1200
Message-Id: <1622958877-2026-2-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
References: <20210605060447.GA18461@allandria.com>
 <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add code to support 10 Mbit and 100 Mbit mode for APNE driver.

A new ISA type ISA_TYPE_AG100 switches the Amiga ISA inb accessor
to word access as required by the 100 Mbit cards.

Patch modified after patch "[PATCH RFC net-next] Amiga PCMCIA
100 MBit card support" submitted to netdev 2018/09/16 by Alex
Kazik <alex@kazik.de>.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 arch/m68k/include/asm/io_mm.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index f6b487b..71f694a 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -101,6 +101,11 @@
 #define ISA_TYPE_Q40  (1)
 #define ISA_TYPE_AG   (2)
 #define ISA_TYPE_ENEC (3)
+#define ISA_TYPE_AG100 (4)	/* for 100 MBit APNE card */
+
+#if defined(CONFIG_APNE100MBIT)
+#define MULTI_ISA 1
+#endif
 
 #if defined(CONFIG_Q40) && !defined(MULTI_ISA)
 #define ISA_TYPE ISA_TYPE_Q40
@@ -135,6 +140,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
 #ifdef CONFIG_Q40
     case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
 #endif
+#if defined(CONFIG_APNE100MBIT)
+    case ISA_TYPE_AG100: fallthrough;
+#endif
 #ifdef CONFIG_AMIGA_PCMCIA
     case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
 #endif
@@ -153,6 +161,9 @@ static inline u16 __iomem *isa_itw(unsigned long addr)
 #ifdef CONFIG_Q40
     case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_IO_W(addr);
 #endif
+#if defined(CONFIG_APNE100MBIT)
+    case ISA_TYPE_AG100: fallthrough;
+#endif
 #ifdef CONFIG_AMIGA_PCMCIA
     case ISA_TYPE_AG: return (u16 __iomem *)AG_ISA_IO_W(addr);
 #endif
@@ -168,6 +179,9 @@ static inline u32 __iomem *isa_itl(unsigned long addr)
 {
   switch(ISA_TYPE)
     {
+#if defined(CONFIG_APNE100MBIT)
+    case ISA_TYPE_AG100: fallthrough;
+#endif
 #ifdef CONFIG_AMIGA_PCMCIA
     case ISA_TYPE_AG: return (u32 __iomem *)AG_ISA_IO_W(addr);
 #endif
@@ -181,6 +195,9 @@ static inline u8 __iomem *isa_mtb(unsigned long addr)
 #ifdef CONFIG_Q40
     case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_MEM_B(addr);
 #endif
+#if defined(CONFIG_APNE100MBIT)
+    case ISA_TYPE_AG100: fallthrough;
+#endif
 #ifdef CONFIG_AMIGA_PCMCIA
     case ISA_TYPE_AG: return (u8 __iomem *)addr;
 #endif
@@ -199,6 +216,9 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
 #ifdef CONFIG_Q40
     case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_MEM_W(addr);
 #endif
+#if defined(CONFIG_APNE100MBIT)
+    case ISA_TYPE_AG100: fallthrough;
+#endif
 #ifdef CONFIG_AMIGA_PCMCIA
     case ISA_TYPE_AG: return (u16 __iomem *)addr;
 #endif
@@ -212,13 +232,16 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
 }
 
 
-#define isa_inb(port)      in_8(isa_itb(port))
 #define isa_inw(port)      (ISA_SEX ? in_be16(isa_itw(port)) : in_le16(isa_itw(port)))
 #define isa_inl(port)      (ISA_SEX ? in_be32(isa_itl(port)) : in_le32(isa_itl(port)))
 #define isa_outb(val,port) out_8(isa_itb(port),(val))
 #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) : out_le16(isa_itw(port),(val)))
 #define isa_outl(val,port) (ISA_SEX ? out_be32(isa_itl(port),(val)) : out_le32(isa_itl(port),(val)))
 
+/* for APNE 100 Mbit cards - hope the APNE 100 case will be eliminated as
+ * dead code if MULTI_ISA is not set */
+#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG100) ? ((port) & 1 ? isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port))
+
 #define isa_readb(p)       in_8(isa_mtb((unsigned long)(p)))
 #define isa_readw(p)       \
 	(ISA_SEX ? in_be16(isa_mtw((unsigned long)(p)))	\
-- 
2.7.4

