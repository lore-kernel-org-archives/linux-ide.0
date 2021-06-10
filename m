Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAADC48BCD
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 02:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38E0613BC
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 02:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFJCHF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 22:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJCHD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 22:07:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75394C061574;
        Wed,  9 Jun 2021 19:04:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p13so324768pfw.0;
        Wed, 09 Jun 2021 19:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HHAxP0hOGSJ1IRyI1cn4uIcL8e4bANLQWvBJcz4lwSM=;
        b=sPF33VxBIajWoEsxIAsBFvh3dFjlJWAVuaeVALLjX5UY9srSNbzrsKESQWLUXkKji7
         sT+GXojOtxHPYZ/dt6TtR/l1bys7EyMVf//AbyMauX6u/ptOwFAXphhD/WQfP5apKZKt
         ZVS8xsKYpI8kgw44G9R3qxBCiqHAK9eVlraN1SUYa/hzNI1ERm9kahCU5KE1RDu21nKu
         pwIt706VZtMqr7pBZfpoEORixlKNGXtxtrhwBk751pUQMv3ExmxTRjVVqkOG9zXtMMd5
         +0uVQuqxh/76jXeyk8Y0o80yHotz1ZpNOBQCIqXdv5NzLS6RTTEkN3XjsX2bJe28UWnu
         tLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HHAxP0hOGSJ1IRyI1cn4uIcL8e4bANLQWvBJcz4lwSM=;
        b=djGyUzPA+azstdpnhtDKVSdhyEpSVlhyNYJnUUtn9oV+oL5d4Lei+60UL1eeKNJPuZ
         6gi3rgFy2AhDC3C4ZggwYMjCNcEgdpCHvQib1x13l7QVFn9Izox7CyaH15AxxPQJrZhY
         Cqzi60f7Bt55UqTBpj7jlGYYvOeyScUt5GAf6VNolIt+7+BGlYgApqnxOqZFrbQ95u4m
         VvxWVdzFiTIbZ4dVykaFTP8XxcCbF+Dg5W8++PNoA/JNVEpWEV+rQS+7psetBrbccxNP
         gbyS0r6gK0xfNJTslid+0Sx+rPFcAMaaRY9zx4aPVlntsfN8+MTFvjvhkMWNA1rnQoBC
         G3Xg==
X-Gm-Message-State: AOAM533zkFMi9m6SD+GGkZnYcBx51DzxXh59eZ0XCa2a9I4NJbuWQixt
        R4501CZguJ5j2aAJSa+ivBg=
X-Google-Smtp-Source: ABdhPJwtmfzqbTg6P/3lMxVWtEdJb8FyZWtDlrquvEFvhpAafkcUl3DqawR2piogf5tygehVgeWHiA==
X-Received: by 2002:a63:4b0f:: with SMTP id y15mr2554460pga.227.1623290690596;
        Wed, 09 Jun 2021 19:04:50 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id f13sm668667pfa.207.2021.06.09.19.04.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 19:04:49 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id B42B83603D8; Thu, 10 Jun 2021 14:04:45 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v3] m68k: io_mm.h: conditionalize ISA address translation on Atari
Date:   Thu, 10 Jun 2021 14:04:43 +1200
Message-Id: <1623290683-17859-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623223322-4242-1-git-send-email-schmitzmic@gmail.com>
References: <1623223322-4242-1-git-send-email-schmitzmic@gmail.com>
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

Fixes:  84b16b7b0d5c818f ("m68k/atari: ROM port ISA adapter support")
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

--
Changes from v2:

Andreas Schwab:
- drop misleading default return comment

Changes from v1:

Geert Uytterhoeven;
- fix Fixes tag
- remove comment about isa_sex zero initialization
- move default return outside switch statement in address
  translation functions to allow other code to break to default.
- fix indentation in switch statement

Changes from RFC:

Geert Uytterhoeven;
- drop setup_mm.c patch

Finn Thain:
- Add 'Fixes' tag
- Annotate rationale for MULTI_ISA setting on Atari
- Use fallthrough macro annotation in Atari address translation
---
 arch/m68k/include/asm/io_mm.h | 66 +++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index d41fa48..9c521b0 100644
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
@@ -135,10 +139,13 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
     case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
+    case ISA_TYPE_ENEC:
+	if (addr < 1024)
+		return (u8 __iomem *)ENEC_ISA_IO_B(addr);
+	break; /* not ROM port? fallback below! */
 #endif
-    default: return NULL; /* avoid warnings, just in case */
     }
+    return (u8 __iomem *)(addr);
 }
 static inline u16 __iomem *isa_itw(unsigned long addr)
 {
@@ -151,10 +158,13 @@ static inline u16 __iomem *isa_itw(unsigned long addr)
     case ISA_TYPE_AG: return (u16 __iomem *)AG_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u16 __iomem *)ENEC_ISA_IO_W(addr);
+    case ISA_TYPE_ENEC:
+	if (addr < 1024)
+		return (u16 __iomem *)ENEC_ISA_IO_W(addr);
+	break; /* not ROM port? fallback below! */
 #endif
-    default: return NULL; /* avoid warnings, just in case */
     }
+    return (u16 __iomem *)(addr);
 }
 static inline u32 __iomem *isa_itl(unsigned long addr)
 {
@@ -163,8 +173,8 @@ static inline u32 __iomem *isa_itl(unsigned long addr)
 #ifdef CONFIG_AMIGA_PCMCIA
     case ISA_TYPE_AG: return (u32 __iomem *)AG_ISA_IO_W(addr);
 #endif
-    default: return 0; /* avoid warnings, just in case */
     }
+    return 0; /* avoid warnings, just in case */
 }
 static inline u8 __iomem *isa_mtb(unsigned long addr)
 {
@@ -177,10 +187,13 @@ static inline u8 __iomem *isa_mtb(unsigned long addr)
     case ISA_TYPE_AG: return (u8 __iomem *)addr;
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_MEM_B(addr);
+    case ISA_TYPE_ENEC:
+	if (addr < 1024)
+		return (u8 __iomem *)ENEC_ISA_MEM_B(addr);
+	break; /* not ROM port? fallback below! */
 #endif
-    default: return NULL; /* avoid warnings, just in case */
     }
+    return (u8 __iomem *)(addr);
 }
 static inline u16 __iomem *isa_mtw(unsigned long addr)
 {
@@ -193,10 +206,13 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
     case ISA_TYPE_AG: return (u16 __iomem *)addr;
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u16 __iomem *)ENEC_ISA_MEM_W(addr);
+    case ISA_TYPE_ENEC:
+	if (addr < 1024)
+		return (u16 __iomem *)ENEC_ISA_MEM_W(addr);
+	break; /* not ROM port? fallback below! */
 #endif
-    default: return NULL; /* avoid warnings, just in case */
     }
+    return (u16 __iomem *)(addr);
 }
 
 
@@ -344,31 +360,31 @@ static inline void isa_delay(void)
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

