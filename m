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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B91EC48BCF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 02:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A57613EF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 02:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhFJCMZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 22:12:25 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:47069 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhFJCMY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 22:12:24 -0400
Received: by mail-pj1-f53.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso2831741pjb.5;
        Wed, 09 Jun 2021 19:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eWB1M8mXOkRZXtMwwlZeHzR+WSj1aGwPLzSUUqVXtf4=;
        b=nHya4Et8BAobXgHqxgJWyqekKi5Knoh/6wS4l6GPBUWUZQ4XGtNVJfNsjG+mYwbjSc
         fzKmC3f8J/bOnXbdw0UuPYODSi6cMfuCWM72Vssit+UbgzmxvLJeHvcmlTImBsCoHzvc
         j0rXnh03Uhw6SwuvN+hOAyYQ6iiY7C97Rf6mWQjmvLtPu6F3cwuacYnggTZW6eJMxXW6
         KDgZJlOQhXN67vyd0gHInRGZXNVIAfKRSYuevlT8d8NtO/GrPlvi7A+nwTNCCZz72TTi
         KNiVRTro9TzcqEx3lchqdAIusfi3bOwN2phg+InEm1cbWcGou62WVytt0c8LOs4vBLuQ
         BLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eWB1M8mXOkRZXtMwwlZeHzR+WSj1aGwPLzSUUqVXtf4=;
        b=oSlecZHBvIh7+iMlAsxvWh6CAZP9y6pUg/VTbdDrclWR74w/VeDHgARRKjoLGlFzMi
         DF9C+2XpHteypOW4k/BIKZALoIvgh4xdrpzbBU/j5LHEypA8yEvGptpDuWukP905hQJl
         pAyf73zr4fAzeLZKztP9DZn0lHEuJAa0GyEa3csR3egYVDmD8KEbH+k+Yu5Nbs6D8bSH
         A+z4ohM4mkTM4gq+/lHjxPJqypc0+LZ/t88jWj7tvD8NOpZWkeAy86lJwOjHDunBcdWD
         1X7MtQcljMcXngmoZQ0Y+g9UkvhMQlPXMk9uT9WlAppsDd0iaN+DXCCl5JBOCtXnQsjZ
         jz3Q==
X-Gm-Message-State: AOAM533g+HURRktino4sf2dur1Ftso5WQ0Hjrabp2XWHrqnllbGNV9Hq
        qBXPDSVd638Ql03TmChGTxE=
X-Google-Smtp-Source: ABdhPJy/1+EFzTs5QCX9ypO7DPpBrL3Q9BZfdXQJZ84oE0r5P2EQ3Gvc20OngPSmHghm4zgJOUeppA==
X-Received: by 2002:a17:90a:1b8f:: with SMTP id w15mr754476pjc.101.1623290960029;
        Wed, 09 Jun 2021 19:09:20 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id s11sm6103405pjz.42.2021.06.09.19.09.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 19:09:19 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id F3ABB3603D9; Thu, 10 Jun 2021 14:09:15 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v2 1/2] m68k: io_mm.h - add APNE 100 MBit support
Date:   Thu, 10 Jun 2021 14:09:12 +1200
Message-Id: <1623290953-18000-2-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623290953-18000-1-git-send-email-schmitzmic@gmail.com>
References: <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
 <1623290953-18000-1-git-send-email-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add code to support 10 Mbit and 100 Mbit mode for APNE driver.

A new ISA type ISA_TYPE_AG16 dynamically switches the Amiga
ISA inb accessor to word access as required by the 100 Mbit cards.

Patch modified after patch "[PATCH RFC net-next] Amiga PCMCIA
100 MBit card support" submitted to netdev 2018/09/16 by Alex
Kazik <alex@kazik.de>.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

--
Changes from v1:

Andreas Schwab:
- remove redundant fallthrough annotations

Changes from RFC:

Geert Uytterhoeven:
- rename ISA_TYPE_AG100 to ISA_TYPE_AG16 (16 bit cards)
- move ISA_TYPE_AG16 case inside #ifdef CONFIG_AMIGA_PCMCIA
- change #if defined(CONFIG_APNE_100MBIT) to #ifdef
- fix parentheses in isa_inb() define
- omit comment about compiler optimization

- add ISA_TYPE_AG16 case to isa_delay()

fixup - review comment Andreas Schwab (fallthrough)
---
 arch/m68k/include/asm/io_mm.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index 9c521b0..3ab2f1d 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -101,6 +101,11 @@
 #define ISA_TYPE_Q40  (1)
 #define ISA_TYPE_AG   (2)
 #define ISA_TYPE_ENEC (3)
+#define ISA_TYPE_AG16 (4)	/* for 100 MBit APNE card */
+
+#if defined(CONFIG_APNE100MBIT)
+#define MULTI_ISA 1
+#endif
 
 #if defined(CONFIG_Q40) && !defined(MULTI_ISA)
 #define ISA_TYPE ISA_TYPE_Q40
@@ -136,6 +141,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
     case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
+#ifdef CONFIG_APNE100MBIT
+    case ISA_TYPE_AG16:
+#endif
     case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
@@ -155,6 +163,9 @@ static inline u16 __iomem *isa_itw(unsigned long addr)
     case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
+#ifdef CONFIG_APNE100MBIT
+    case ISA_TYPE_AG16:
+#endif
     case ISA_TYPE_AG: return (u16 __iomem *)AG_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
@@ -171,6 +182,9 @@ static inline u32 __iomem *isa_itl(unsigned long addr)
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_AMIGA_PCMCIA
+#ifdef CONFIG_APNE100MBIT
+    case ISA_TYPE_AG16:
+#endif
     case ISA_TYPE_AG: return (u32 __iomem *)AG_ISA_IO_W(addr);
 #endif
     }
@@ -184,6 +198,9 @@ static inline u8 __iomem *isa_mtb(unsigned long addr)
     case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_MEM_B(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
+#ifdef CONFIG_APNE100MBIT
+    case ISA_TYPE_AG16:
+#endif
     case ISA_TYPE_AG: return (u8 __iomem *)addr;
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
@@ -203,6 +220,9 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
     case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_MEM_W(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
+#ifdef CONFIG_APNE100MBIT
+    case ISA_TYPE_AG16:
+#endif
     case ISA_TYPE_AG: return (u16 __iomem *)addr;
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
@@ -216,13 +236,14 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
 }
 
 
-#define isa_inb(port)      in_8(isa_itb(port))
 #define isa_inw(port)      (ISA_SEX ? in_be16(isa_itw(port)) : in_le16(isa_itw(port)))
 #define isa_inl(port)      (ISA_SEX ? in_be32(isa_itl(port)) : in_le32(isa_itl(port)))
 #define isa_outb(val,port) out_8(isa_itb(port),(val))
 #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) : out_le16(isa_itw(port),(val)))
 #define isa_outl(val,port) (ISA_SEX ? out_be32(isa_itl(port),(val)) : out_le32(isa_itl(port),(val)))
 
+#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG16) ? ((port) & 1 ? isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port)))
+
 #define isa_readb(p)       in_8(isa_mtb((unsigned long)(p)))
 #define isa_readw(p)       \
 	(ISA_SEX ? in_be16(isa_mtw((unsigned long)(p)))	\
@@ -270,6 +291,9 @@ static inline void isa_delay(void)
     case ISA_TYPE_Q40: isa_outb(0,0x80); break;
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
+#ifdef CONFIG_APNE100MBIT
+    case ISA_TYPE_AG16: break;
+#endif
     case ISA_TYPE_AG: break;
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-- 
2.7.4

