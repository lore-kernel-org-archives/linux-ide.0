From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: RFC Patch: Use x86 init_hwif in the alim15x3 for x86-like PowerPC
	systems
Date: Wed, 15 Apr 2009 16:34:22 +0200
Message-ID: <c8485d470904150734s47ce0f27y3ae984355e823d9f@mail.gmail.com>
References: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:39914 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbZDOOeY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Apr 2009 10:34:24 -0400
Received: by bwz17 with SMTP id 17so2938104bwz.37
        for <linux-ide@vger.kernel.org>; Wed, 15 Apr 2009 07:34:22 -0700 (PDT)
In-Reply-To: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm using a Xilinx ML510 it features a PowerPC 440 cpu inside a
Virtex-5 FPGA. The board also contains a ALI M1533 south bridge
for IDE, USB and Audio. I did a lot of work to get the pci bus working
on this board and it works correctly but the default init code
of the alim15x3 driver doesn't work for me. The driver explicitly
disabled some initialization code for powerpc after uncommenting this
code it works properly. Benjamin Herrenschmidt and I think this
!CONFIG_PPC check should be removed because the system behaves
like a real 'x86' system (also the i8259 interrupt controller is used).

Regards,
Roderick Colenbrander


=46rom 1c40c2f1485ecd3bc5ad7a3af537cb94de0877c3 Mon Sep 17 00:00:00 200=
1
=46rom: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Wed, 15 Apr 2009 10:45:17 +0200
Subject: [PATCH] Use the 'x86' init_hwif code in the alim15x3 for
x86-like PowerPC boards like Xilinx ML310/410/510.

---
=A0drivers/ide/alim15x3.c |=A0=A0=A0 9 +++++----
=A01 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
index 537da1c..9176c0f 100644
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -402,14 +402,15 @@ static u8 ali_cable_detect(ide_hwif_t *hwif)
=A0=A0=A0=A0 return cbl;
=A0}

-#if !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC)
+#if !defined(CONFIG_SPARC64)
=A0/**
=A0 *=A0=A0=A0 init_hwif_ali15x3=A0=A0=A0 -=A0=A0=A0 Initialize the ALI=
 IDE x86 stuff
=A0 *=A0=A0=A0 @hwif: interface to configure
=A0 *
=A0 *=A0=A0=A0 Obtain the IRQ tables for an ALi based IDE solution on t=
he PC
- *=A0=A0=A0 class platforms. This part of the code isn't applicable to=
 the
- *=A0=A0=A0 Sparc and PowerPC systems.
+ *=A0=A0=A0 class platforms. This part of the code isn't applicable to
+ *=A0=A0=A0 Sparc systems. It is usable on 'x86-like' PowerPC systems
+ *=A0=A0=A0=A0=A0 which use a Ali M15x3 south bridge like e.g. Xilinx =
ML310/410/510.
=A0 */

=A0static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
@@ -455,7 +456,7 @@ static void __devinit init_hwif_ali15x3 (ide_hwif_t=
 *hwif)
=A0}
=A0#else
=A0#define init_hwif_ali15x3 NULL
-#endif /* !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC) */
+#endif /* !defined(CONFIG_SPARC64) */

=A0/**
=A0 *=A0=A0=A0 init_dma_ali15x3=A0=A0=A0 -=A0=A0=A0 set up DMA on ALi15=
x3
--
1.5.6.3
