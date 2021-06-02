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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8280C47083
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 05:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8806A61246
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 05:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhFBFW6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFBFW5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 01:22:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615D1C06174A;
        Tue,  1 Jun 2021 22:21:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c12so1300762pfl.3;
        Tue, 01 Jun 2021 22:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=19Tgsoej0mu0AmbLeRotZAQZspI+XwauVWjSlpCxS8w=;
        b=LcP2QCdq4gzFsGzgOEK5EyUUM94rVRsX/6TN/lHXumXcEVFB+OIrLqy/sPOZE36VlL
         /dAv9rTz7B5/GlyefkGmdH9o5u6DVLM67vm3Am6XRaL1TDsED4D3S8v1kCDyAltvnUMe
         sFH0esb9tVFq2rjEzpM081p7nret20z3dG0Z1Fw6I3+z80pYNrkyTIkY1zd7cs6RpMIQ
         +ak6YKpDKVC6ZCb3h0gzlWTbs0cLhHzoJMrRau0RLcvFu+RCEH5ik9JGIHR16wnx+d5n
         vJSy7NWjXzi8MlSryhWWFp+0rxxhCD5os7PFfd57Xhd1wwzO6siwWeW3GbA930Nlvxh5
         Uaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=19Tgsoej0mu0AmbLeRotZAQZspI+XwauVWjSlpCxS8w=;
        b=YzIdFQl2imRkl1JBvsiDAY5XsqKnZRVB8B0tA3u5xMh7upqA5myKqhuMd0nSUSr0Lh
         m66k2hE0twcqK94Se/yw6pa/7/wvWgkGajhruCNirmgi6t2z47PHpG9ddFln9uh6ieSx
         vHQ8Q8GhbsMME/ucOODh75T/EdefwjXP4mhdZqwI4SFw7QOw5nQLxFCOw1WKqbgw0SOB
         IYmBM+ue3KZO9uj1Ky70h1sVb48ey2KC5e+rjNya/4KovlX1oPSC60yGdQRKGpyRmVow
         dWpADnTbPaU7yfVLQMJ4Vux/rThyL2Dece5r0zTDL6npAONfoq3x+1gN0Z8q/2U/dT3z
         CaFg==
X-Gm-Message-State: AOAM533kqsGh/WklQKZZzq3KHZYu5l7lHvgLkyKKH+RMn6DCwkjtWT1f
        W1Q7TX78M74n0wwXpsNb378=
X-Google-Smtp-Source: ABdhPJyjRNPQ3BBf/7eJTJYH4+F01I3Nn5QboxnlggbGp2oojQqO373MBIQZMhPjxAvQLjFBvW5Zow==
X-Received: by 2002:a63:5c01:: with SMTP id q1mr32028256pgb.447.1622611274911;
        Tue, 01 Jun 2021 22:21:14 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id e21sm3392722pjh.55.2021.06.01.22.21.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 22:21:14 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id E661A360410; Wed,  2 Jun 2021 17:21:10 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address translation on Atari
Date:   Wed,  2 Jun 2021 17:21:06 +1200
Message-Id: <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
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

Signed-off-by: Michael Schmity <schmitzmic@gmail.com>
---
 arch/m68k/include/asm/io_mm.h | 64 +++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index d41fa48..2275e54 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -52,7 +52,11 @@
 #define Q40_ISA_MEM_B(madr)  (q40_isa_mem_base+1+4*((unsigned long)(madr)))
 #define Q40_ISA_MEM_W(madr)  (q40_isa_mem_base+  4*((unsigned long)(madr)))
 
+#ifdef CONFIG_ATARI
+#define MULTI_ISA 1
+#else
 #define MULTI_ISA 0
+#endif /* Atari */
 #endif /* Q40 */
 
 #ifdef CONFIG_AMIGA_PCMCIA
@@ -135,9 +139,12 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
     case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
+    case ISA_TYPE_ENEC: if (addr < 1024) 
+				return (u8 __iomem *)ENEC_ISA_IO_B(addr);
+			else
+				return (u8 __iomem *)(addr);
 #endif
-    default: return NULL; /* avoid warnings, just in case */
+    default: return (u8 __iomem *)(addr); /* avoid warnings, just in case */
     }
 }
 static inline u16 __iomem *isa_itw(unsigned long addr)
@@ -151,9 +158,12 @@ static inline u16 __iomem *isa_itw(unsigned long addr)
     case ISA_TYPE_AG: return (u16 __iomem *)AG_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u16 __iomem *)ENEC_ISA_IO_W(addr);
+    case ISA_TYPE_ENEC: if (addr < 1024)
+				return (u16 __iomem *)ENEC_ISA_IO_W(addr);
+			else
+				return (u16 __iomem *)(addr);
 #endif
-    default: return NULL; /* avoid warnings, just in case */
+    default: return (u16 __iomem *)(addr); /* avoid warnings, just in case */
     }
 }
 static inline u32 __iomem *isa_itl(unsigned long addr)
@@ -177,9 +187,12 @@ static inline u8 __iomem *isa_mtb(unsigned long addr)
     case ISA_TYPE_AG: return (u8 __iomem *)addr;
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_MEM_B(addr);
+    case ISA_TYPE_ENEC: if (addr < 1024)
+				return (u8 __iomem *)ENEC_ISA_MEM_B(addr);
+			else
+				return (u8 __iomem *)(addr);
 #endif
-    default: return NULL; /* avoid warnings, just in case */
+    default: return (u8 __iomem *)(addr); /* avoid warnings, just in case */
     }
 }
 static inline u16 __iomem *isa_mtw(unsigned long addr)
@@ -193,9 +206,12 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
     case ISA_TYPE_AG: return (u16 __iomem *)addr;
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
-    case ISA_TYPE_ENEC: return (u16 __iomem *)ENEC_ISA_MEM_W(addr);
+    case ISA_TYPE_ENEC: if (addr < 1024)
+				return (u16 __iomem *)ENEC_ISA_MEM_W(addr);
+			else
+				return (u16 __iomem *)(addr);
 #endif
-    default: return NULL; /* avoid warnings, just in case */
+    default: return (u16 __iomem *)(addr); /* avoid warnings, just in case */
     }
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

