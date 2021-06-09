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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2625CC48BD1
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 07:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1081E61361
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 07:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhFIHkO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:40:14 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:34434 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFIHkO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 03:40:14 -0400
Received: by mail-pg1-f174.google.com with SMTP id l1so18744699pgm.1;
        Wed, 09 Jun 2021 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m6BQeygwdufdV9h+iSLPUeIxQ7I6Fb52GLs3OuHXhNM=;
        b=SNfPwaunWFA/fMxg9S+4ubJTkYFxz9lrOOh68efko3QNkKXKM68M1m3k4VFq6LwuNa
         q33ObOuBEmCu8sPCf7amzJ5zR8it4ZLSghOFfI6fkt1YqDcVvCN6Z5IofGyvCat45vpm
         wrjiPChcBvEG1PrnjpGOdl+b6DNZBolTSFU8ZKy6Wn/SFJpqQMxw8/cd5zzRzt8O4Qpl
         T6mCyhF3vEc5xHlNYHYVswnQ+TB1chZn+LE6DNi0Oh3TqNa+mugZFSm9SS/1nCmSG3kx
         D4csPqNMHjxvMsSD+5ZKcFAXuTZlIjAI40l37P2qeHnYOyTGIG14hcUREJH0RKigRVaL
         r2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m6BQeygwdufdV9h+iSLPUeIxQ7I6Fb52GLs3OuHXhNM=;
        b=oqMY03cHYPCurihTW3BEjI56tuaK4gAUAYMqaAdDQ2+xVlkswOhBdiwkEcR8/6XiR7
         BI+WDBq+AZ35nU/DIr4jg12lOIVRQSZ3iFO42lGhx2twgSdebQ5Om8aLcde7XeM6QcYe
         jqSG0lihhv7LKvC3kdUPfpnN1/lRtngfeFhr2FEHk7IuJSAiWu6v+aoPGkXg/oL3bXU0
         8sqBDiy0r5vr8eDwxTfyjZkuHuszUfqxBOjP1lVCLwhmupgptoYHgimdW4Ox39UixUF+
         I/UOIMNiooGzQhkDv914rYZdFH3TgyyCpPq75W7f0qnOzW2C03AW4M2pJ/C693FdednU
         WAwA==
X-Gm-Message-State: AOAM532aF2sqp1fkSO5TicJjG4AB10ubENZ5E1BWwWPLIuTURUQYc/qR
        u9IB8Z06SeYrhBfZbh92C34=
X-Google-Smtp-Source: ABdhPJzBn2FIoB/tlIi8tkoLYaPPvPIvBihFnuWK7CNDyRBpg/0N5kIk4RPCu1i+LIOyXYiRBG79Dg==
X-Received: by 2002:a62:b401:0:b029:2ec:a3ed:9494 with SMTP id h1-20020a62b4010000b02902eca3ed9494mr3835993pfn.56.1623224224809;
        Wed, 09 Jun 2021 00:37:04 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id c190sm12549836pfc.26.2021.06.09.00.37.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 00:37:04 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 296E73603D9; Wed,  9 Jun 2021 19:37:01 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     linux-ide@vger.kernel.org, fthain@linux-m68k.org, alex@kazik.de,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v1 1/2] m68k: io_mm.h - add APNE 100 MBit support
Date:   Wed,  9 Jun 2021 19:36:53 +1200
Message-Id: <1623224214-4836-2-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
References: <1622958877-2026-1-git-send-email-schmitzmic@gmail.com>
 <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
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
Changes from RFC:

Geert Uytterhoeven:
- rename ISA_TYPE_AG100 to ISA_TYPE_AG16 (16 bit cards)
- move ISA_TYPE_AG16 case inside #ifdef CONFIG_AMIGA_PCMCIA
- change #if defined(CONFIG_APNE_100MBIT) to #ifdef
- fix parentheses in isa_inb() define
- omit comment about compiler optimization

- add ISA_TYPE_AG16 case to isa_delay()
---
 arch/m68k/include/asm/io_mm.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index 6eae9ec..a965a0e 100644
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
+    case ISA_TYPE_AG16: fallthrough;
+#endif
     case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
@@ -155,6 +163,9 @@ static inline u16 __iomem *isa_itw(unsigned long addr)
     case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
+#ifdef CONFIG_APNE100MBIT
+    case ISA_TYPE_AG16: fallthrough;
+#endif
     case ISA_TYPE_AG: return (u16 __iomem *)AG_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
@@ -171,6 +182,9 @@ static inline u32 __iomem *isa_itl(unsigned long addr)
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_AMIGA_PCMCIA
+#ifdef CONFIG_APNE100MBIT
+    case ISA_TYPE_AG16: fallthrough;
+#endif
     case ISA_TYPE_AG: return (u32 __iomem *)AG_ISA_IO_W(addr);
 #endif
     }
@@ -184,6 +198,9 @@ static inline u8 __iomem *isa_mtb(unsigned long addr)
     case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_MEM_B(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
+#ifdef CONFIG_APNE100MBIT
+    case ISA_TYPE_AG16: fallthrough;
+#endif
     case ISA_TYPE_AG: return (u8 __iomem *)addr;
 #endif
 #ifdef CONFIG_ATARI_ROM_ISA
@@ -203,6 +220,9 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
     case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_MEM_W(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
+#ifdef CONFIG_APNE100MBIT
+    case ISA_TYPE_AG16: fallthrough;
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

