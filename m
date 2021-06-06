Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B90CC4743E
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 05:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F32260E09
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 05:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhFFFas (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Jun 2021 01:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFFFar (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jun 2021 01:30:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1797C061766;
        Sat,  5 Jun 2021 22:28:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 6so11267692pgk.5;
        Sat, 05 Jun 2021 22:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r6UeGe/7Cg79XEjJM1M+qtZ81uPZsFSrf7FEoC33DJU=;
        b=qvuBjxH6shTRQfhhSBAgqb3bZnZ3h13kc6X+A2ZGHKQNTg8CNhTw79gVtaoHzE3Gn5
         dQejyNuLIvNKNtSwdWLaNGWWuwLwNpE8MSF3u0rUaR8+8yzz+NxUsD4HFTudouXjQisQ
         e/ruXoXelHjPIlwMQ4Yh8yWzG8TbPnx1fHuqRBayI3S36bJ+rSUEMFaoxY1xiItw+oeU
         so/8SQc6cY2QSSwrHEq/x+hL62s/9XlhKs37+GT8cEPNzf3uCLbluDkB49H3G9DGzESh
         umqvmJ43EhXInKSqHeaiZpUsGqwrWRR2Aph68TMhnKn6YOs9goOIkMEJ2tA+JZWWPdCS
         i5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r6UeGe/7Cg79XEjJM1M+qtZ81uPZsFSrf7FEoC33DJU=;
        b=pJ64wXE4cjYpWC+Pwkfpli9K9Cz4Ejg6SiJTx2wFj/1PFltEp/8lCwTI8+89iqKLbV
         1dEcEkmegeFe0/XXmeLTinTJ+x+sFzKaDE/b67KpW8MV3JwxxViTFVCebpoefZn+RNWg
         2tBKFoJ0l/MwDTyCqfeZP1YwKElXAtto5vHV/f9Hha3ImZE0KkMduUqgDEfqDx8j72N4
         a2z/C8zitRT3wYHUQF8ck8NUPbLwDPm8EGaKv+hxI4uz9s6kNPllc11z0RgJOkcslAPm
         zYJhHZ6dALMKOUFDApkk1aMFMmBNIzAYnATZ4zDvzIzJ2Cg7YczYptCM/3XdcCRznUCV
         dpaw==
X-Gm-Message-State: AOAM5325hpsjkzxzNBrbIU6Pur6DuIEDu8PNhV+l219f+1mj4leEaoWh
        iy2mXOXFzNlULEDfg8Tucaxro7om7YU=
X-Google-Smtp-Source: ABdhPJzhpZalhpE5LsTxyfo4T8qeeH98KzGUsCucMzmKLY+4IsFTZGaDCWVyudFxaawz/TT1W30XwA==
X-Received: by 2002:a63:4386:: with SMTP id q128mr12639704pga.397.1622957320274;
        Sat, 05 Jun 2021 22:28:40 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id s15sm8381769pjr.18.2021.06.05.22.28.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 22:28:39 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 909223603D8; Sun,  6 Jun 2021 17:28:35 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH] m68k: Fix multiplatform ISA support
Date:   Sun,  6 Jun 2021 17:28:33 +1200
Message-Id: <1622957313-321-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
References: <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Current io_mm.h uses address translation and ROM port IO primitives when
port addresses are below 1024, and raw untranslated MMIO IO primitives
else when CONFIG_ATARI_ROM_ISA is set. This is done regardless of the
m68k machine type a multi-platform kernel runs on. As a consequence,
the Q40 IDE driver in multiplatform kernels cannot work.
Conversely, the Atari IDE driver uses wrong address translation if a
multiplatform Q40 and Atari kernel does _not_ set CONFIG_ATARI_ROM_ISA.

Replace MMIO by ISA IO primitives for addresses > 1024 (if isa_type
is ISA_TYPE_ENEC), and change the ISA address translation used for
Atari to a no-op for those addresses.

Switch readb()/writeb() and readw()/writew() to their ISA equivalents
also. Change the address translation functions to return the identity
translation if CONFIG_ATARI_ROM_ISA is not defined, and set MULTI_ISA
for kernels where Q40 and Atari are both configured so this can actually
work (isa_type set to Q40 at compile time else).

Fixes:  84b16b7b0d5c818fadc731a69965dc76dce0c91e
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

--
Changes from RFC:

Geert Uytterhoeven;
- drop setup_mm.c patch

Finn Thain:
- Add 'Fixes' tag
- Annotate rationale for MULTI_ISA setting on Atari
- Use fallthrough macro annotation in Atari address translation
---
 arch/m68k/include/asm/io_mm.h | 62 ++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index d41fa48..f6b487b 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -52,7 +52,11 @@
 #define Q40_ISA_MEM_B(madr)  (q40_isa_mem_base+1+4*((unsigned long)(madr)))
 #define Q40_ISA_MEM_W(madr)  (q40_isa_mem_base+  4*((unsigned long)(madr)))
 
+#ifdef CONFIG_ATARI
+#define MULTI_ISA 1	/* Need MULTI_ISA if Atari drivers (IDE) present !! */
+#else
 #define MULTI_ISA 0
+#endif /* Atari */
 #endif /* Q40 */
 
 #ifdef CONFIG_AMIGA_PCMCIA
@@ -113,7 +117,7 @@
 
 #ifdef MULTI_ISA
 extern int isa_type;
-extern int isa_sex;
+extern int isa_sex;	/* Atari relies on this to be zero-initialized */
 
 #define ISA_TYPE isa_type
 #define ISA_SEX  isa_sex
@@ -135,9 +139,11 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
     case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
+    case ISA_TYPE_ENEC: if (addr < 1024)
+				return (u8 __iomem *)ENEC_ISA_IO_B(addr);
+			fallthrough; /* not ROM port? fallback below! */
 #endif
-    default: return NULL; /* avoid warnings, just in case */
+    default: return (u8 __iomem *)(addr); /* avoid warnings, just in case */
     }
 }
 static inline u16 __iomem *isa_itw(unsigned long addr)
@@ -151,9 +157,11 @@ static inline u16 __iomem *isa_itw(unsigned long addr)
     case ISA_TYPE_AG: return (u16 __iomem *)AG_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u16 __iomem *)ENEC_ISA_IO_W(addr);
+    case ISA_TYPE_ENEC: if (addr < 1024)
+				return (u16 __iomem *)ENEC_ISA_IO_W(addr);
+			fallthrough; /* not ROM port? fallback below! */
 #endif
-    default: return NULL; /* avoid warnings, just in case */
+    default: return (u16 __iomem *)(addr); /* avoid warnings, just in case */
     }
 }
 static inline u32 __iomem *isa_itl(unsigned long addr)
@@ -177,9 +185,11 @@ static inline u8 __iomem *isa_mtb(unsigned long addr)
     case ISA_TYPE_AG: return (u8 __iomem *)addr;
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_MEM_B(addr);
+    case ISA_TYPE_ENEC: if (addr < 1024)
+				return (u8 __iomem *)ENEC_ISA_MEM_B(addr);
+			fallthrough; /* not ROM port? fallback below! */
 #endif
-    default: return NULL; /* avoid warnings, just in case */
+    default: return (u8 __iomem *)(addr); /* avoid warnings, just in case */
     }
 }
 static inline u16 __iomem *isa_mtw(unsigned long addr)
@@ -193,9 +203,11 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
     case ISA_TYPE_AG: return (u16 __iomem *)addr;
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u16 __iomem *)ENEC_ISA_MEM_W(addr);
+    case ISA_TYPE_ENEC: if (addr < 1024)
+				return (u16 __iomem *)ENEC_ISA_MEM_W(addr);
+			fallthrough; /* not ROM port? fallback below! */
 #endif
-    default: return NULL; /* avoid warnings, just in case */
+    default: return (u16 __iomem *)(addr); /* avoid warnings, just in case */
     }
 }
 
@@ -344,31 +356,31 @@ static inline void isa_delay(void)
  * ROM port ISA and everything else regular ISA for IDE. read,write defined
  * below.
  */
-#define inb(port)	((port) < 1024 ? isa_rom_inb(port) : in_8(port))
-#define inb_p(port)	((port) < 1024 ? isa_rom_inb_p(port) : in_8(port))
-#define inw(port)	((port) < 1024 ? isa_rom_inw(port) : in_le16(port))
-#define inw_p(port)	((port) < 1024 ? isa_rom_inw_p(port) : in_le16(port))
+#define inb(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inb(port) : isa_inb(port))
+#define inb_p(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inb_p(port) : isa_inb_p(port))
+#define inw(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inw(port) : isa_inw(port))
+#define inw_p(port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_inw_p(port) : isa_inw_p(port))
 #define inl		isa_inl
 #define inl_p		isa_inl_p
 
-#define outb(val, port)	((port) < 1024 ? isa_rom_outb((val), (port)) : out_8((port), (val)))
-#define outb_p(val, port) ((port) < 1024 ? isa_rom_outb_p((val), (port)) : out_8((port), (val)))
-#define outw(val, port)	((port) < 1024 ? isa_rom_outw((val), (port)) : out_le16((port), (val)))
-#define outw_p(val, port) ((port) < 1024 ? isa_rom_outw_p((val), (port)) : out_le16((port), (val)))
+#define outb(val, port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outb((val), (port)) : isa_outb((val), (port)))
+#define outb_p(val, port) (((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outb_p((val), (port)) : isa_outb_p((val), (port)))
+#define outw(val, port)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outw((val), (port)) : isa_outw((val), (port)))
+#define outw_p(val, port) (((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outw_p((val), (port)) : isa_outw_p((val), (port)))
 #define outl		isa_outl
 #define outl_p		isa_outl_p
 
-#define insb(port, buf, nr)	((port) < 1024 ? isa_rom_insb((port), (buf), (nr)) : isa_insb((port), (buf), (nr)))
-#define insw(port, buf, nr)	((port) < 1024 ? isa_rom_insw((port), (buf), (nr)) : isa_insw((port), (buf), (nr)))
+#define insb(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_insb((port), (buf), (nr)) : isa_insb((port), (buf), (nr)))
+#define insw(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_insw((port), (buf), (nr)) : isa_insw((port), (buf), (nr)))
 #define insl			isa_insl
-#define outsb(port, buf, nr)	((port) < 1024 ? isa_rom_outsb((port), (buf), (nr)) : isa_outsb((port), (buf), (nr)))
-#define outsw(port, buf, nr)	((port) < 1024 ? isa_rom_outsw((port), (buf), (nr)) : isa_outsw((port), (buf), (nr)))
+#define outsb(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outsb((port), (buf), (nr)) : isa_outsb((port), (buf), (nr)))
+#define outsw(port, buf, nr)	(((port) < 1024 && ISA_TYPE == ISA_TYPE_ENEC) ? isa_rom_outsw((port), (buf), (nr)) : isa_outsw((port), (buf), (nr)))
 #define outsl			isa_outsl
 
-#define readb(addr)		in_8(addr)
-#define writeb(val, addr)	out_8((addr), (val))
-#define readw(addr)		in_le16(addr)
-#define writew(val, addr)	out_le16((addr), (val))
+#define readb   isa_readb
+#define readw   isa_readw
+#define writeb  isa_writeb
+#define writew  isa_writew
 #endif /* CONFIG_ATARI_ROM_ISA */
 
 #define readl(addr)      in_le32(addr)
-- 
2.7.4

