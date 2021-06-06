Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904A6C4743D
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 02:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6472C61260
	for <linux-ide@archiver.kernel.org>; Sun,  6 Jun 2021 02:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFFCVc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 5 Jun 2021 22:21:32 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:41966 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhFFCVb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jun 2021 22:21:31 -0400
Received: by mail-pj1-f52.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso8259273pji.0;
        Sat, 05 Jun 2021 19:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NfifK5jNkMyg/MkZQuumdoix1pLzzTNd9s11rUOD238=;
        b=Mj4KwlHjrrXOWyVkIbMtf/CZI3lL7J2eFyiV5nVYzLuSV6dKMSRImthuzYVOefIpk+
         HTaoEivBBIdY77oQnxIal48geVO+g1/QKI1Kmb9s1cmOXrB6M27+dgbtjA4vKECf9UV9
         oAtPAiKmkyyvLsGvg3D/s5vHmqrrRdMw2PVsKqV2EvF62NoFB9enuUPW7/NIIo2w2Iwq
         +COA4ROMXo7aM0GYMk+0KHzgumkNGluLdLkTKGymT3wmPSfWg2XvLPAQITLRFRMde0dM
         LT0ZswoVhrDNwPAdJQSAVrnb5cAEXox6YhXb/+D0WPIXqjL740JMR5zqpRBXwxkcb5x9
         3SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NfifK5jNkMyg/MkZQuumdoix1pLzzTNd9s11rUOD238=;
        b=tQmP2Xq9cuEKnFXZy3rn/SGJQuhWwIYKkTdwL4bh81Z5NFepEjPGs3oSMuQvLngf3S
         KrVXf/79u2BY3sRbAVLYV2uCyWoVcgA6Ml/lXYzFQoQJSJ9nsmnF+1UUCP71vvVI95lm
         j1CdCY+RbsJwVxjvySmqaJEbEEkGunl+5eQZSHritUf/O3wH6NlUjpXKwOwX1ARt7NZl
         4q/NT0dkfrKgiPn/qnjlXOxrTBmW+qBeDoB4pnGq7NlOvcVLg8T2UleoD5D74JaLMscW
         OU1Tkqb4O+EiifGMJzF/t65D+SK7mkS693NWtF0UUXtYuvQKAgB/MKbhyT3RtHKt9giQ
         ZYyg==
X-Gm-Message-State: AOAM533IQpV+08YDUnGJzXkXRrDNXgYkUIaNYpz6LZDZtgg6tzmSru7C
        IXw6ukfV81IsR3ZWUlI+waea4HW6oT8=
X-Google-Smtp-Source: ABdhPJwDw5YI7t2JAWg8rLsdUh14bgKb6lJOsl9a1ZvK9us2tGynH11BDkrTPYuIa9B2GqiviGeQ5Q==
X-Received: by 2002:a17:90b:1094:: with SMTP id gj20mr12670354pjb.45.1622945907660;
        Sat, 05 Jun 2021 19:18:27 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id x36sm4847168pfu.39.2021.06.05.19.18.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 19:18:27 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
To:     Brad Boyer <flar@allandria.com>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com>
 <d7165fdd-9269-7bd2-185-c6193f864722@linux-m68k.org>
 <535b7829-f16f-4ddc-a676-dbb10c7a4a35@gmail.com>
 <20210604224955.GA12141@allandria.com>
 <eefa79e9-01d3-9179-9ca6-57500b9ab7c2@gmail.com>
 <20210605060447.GA18461@allandria.com>
Cc:     Finn Thain <fthain@linux-m68k.org>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-ide@vger.kernel.org,
        ALeX Kazik <alex@kazik.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <5bed9868-2cb6-6604-abb9-faa9361fa3e3@gmail.com>
Date:   Sun, 6 Jun 2021 14:18:21 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20210605060447.GA18461@allandria.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Brad,

Am 05.06.2021 um 18:04 schrieb Brad Boyer:
> On Sat, Jun 05, 2021 at 01:41:22PM +1200, Michael Schmitz wrote:
>> Am 05.06.2021 um 10:49 schrieb Brad Boyer:
>>> I don't see anything in drivers/pcmcia that is obviously an m68k
>>> system even though I'm pretty sure I remember discussions of supporting
>>> such hardware in the past.
>>
>> There's the APNE driver (Amiga PCMCIA NE2000 clone), which is already
>> catered for by the current code in io_mm.h. I remember seeing patches for
>> that driver that would allow support of a variant of the APNE card that were
>> hard to integrate in the current NE clone code framework. Didn't consider
>> adding another isa_type for that card at the time - I'll revisit these
>> patches if I can find them again.

Refreshed my memory - Alex submitted a patch to netdev three years ago 
that essentially boiled down to changing our isa_inb() to use isa_inw().

This patch to io_mm.h (on top of my current patch), plus setting 
isa_type to ISA_TPYE_AG100 using a module parameter, should do the trick:

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index f6b487b..6f79a5e 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -102,6 +102,11 @@
  #define ISA_TYPE_AG   (2)
  #define ISA_TYPE_ENEC (3)

+#if defined(CONFIG_AMIGA_PCMCIA_100)
+#define ISA_TYPE_AG100 (4)     /* for 100 MBit APNE card */
+#define MULTI_ISA 1
+#endif
+
  #if defined(CONFIG_Q40) && !defined(MULTI_ISA)
  #define ISA_TYPE ISA_TYPE_Q40
  #define ISA_SEX  0
@@ -135,6 +140,9 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
  #ifdef CONFIG_Q40
      case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_IO_B(addr);
  #endif
+#if defined(CONFIG_AMIGA_PCMCIA_100)
+    case ISA_TYPE_AG100: fallthrough;
+#endif
  #ifdef CONFIG_AMIGA_PCMCIA
      case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
  #endif
@@ -153,6 +161,9 @@ static inline u16 __iomem *isa_itw(unsigned long addr)
  #ifdef CONFIG_Q40
      case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_IO_W(addr);
  #endif
+#if defined(CONFIG_AMIGA_PCMCIA_100)
+    case ISA_TYPE_AG100: fallthrough;
+#endif
  #ifdef CONFIG_AMIGA_PCMCIA
      case ISA_TYPE_AG: return (u16 __iomem *)AG_ISA_IO_W(addr);
  #endif
@@ -168,6 +179,9 @@ static inline u32 __iomem *isa_itl(unsigned long addr)
  {
    switch(ISA_TYPE)
      {
+#if defined(CONFIG_AMIGA_PCMCIA_100)
+    case ISA_TYPE_AG100: fallthrough;
+#endif
  #ifdef CONFIG_AMIGA_PCMCIA
      case ISA_TYPE_AG: return (u32 __iomem *)AG_ISA_IO_W(addr);
  #endif
@@ -181,6 +195,9 @@ static inline u8 __iomem *isa_mtb(unsigned long addr)
  #ifdef CONFIG_Q40
      case ISA_TYPE_Q40: return (u8 __iomem *)Q40_ISA_MEM_B(addr);
  #endif
+#if defined(CONFIG_AMIGA_PCMCIA_100)
+    case ISA_TYPE_AG100: fallthrough;
+#endif
  #ifdef CONFIG_AMIGA_PCMCIA
      case ISA_TYPE_AG: return (u8 __iomem *)addr;
  #endif
@@ -199,6 +216,9 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
  #ifdef CONFIG_Q40
      case ISA_TYPE_Q40: return (u16 __iomem *)Q40_ISA_MEM_W(addr);
  #endif
+#if defined(CONFIG_AMIGA_PCMCIA_100)
+    case ISA_TYPE_AG100: fallthrough;
+#endif
  #ifdef CONFIG_AMIGA_PCMCIA
      case ISA_TYPE_AG: return (u16 __iomem *)addr;
  #endif
@@ -219,6 +239,11 @@ static inline u16 __iomem *isa_mtw(unsigned long addr)
  #define isa_outw(val,port) (ISA_SEX ? out_be16(isa_itw(port),(val)) : 
out_le16(isa_itw(port),(val)))
  #define isa_outl(val,port) (ISA_SEX ? out_be32(isa_itl(port),(val)) : 
out_le32(isa_itl(port),(val)))

+#if defined(CONFIG_AMIGA_PCMCIA_100)
+#undef isa_inb
+#define isa_inb(port)      ((ISA_TYPE == ISA_TYPE_AG100) ? ((port) & 1 
? isa_inw((port) - 1) & 0xff : isa_inw(port) >> 8) : in_8(isa_itb(port))
+#endif
+
  #define isa_readb(p)       in_8(isa_mtb((unsigned long)(p)))
  #define isa_readw(p)       \
         (ISA_SEX ? in_be16(isa_mtw((unsigned long)(p))) \

(linebreak-mangled, sorry).

The card reset patch hunk from Alex' patch can probably go into the APNE 
driver regardless?

It's been quite a while - can you still try and build/test this change, 
Alex?

Cheers,

	Michael

