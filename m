From: for_spam@gmx.de
Subject: ICH6 / SATA performance problems
Date: Thu, 21 Apr 2005 21:04:09 +0200 (MEST)
Message-ID: <12540.1114110249@www24.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.net ([213.165.64.20]:4755 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261794AbVDUTEL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2005 15:04:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Hello, 

i have a strange sata performance problem with my new system:

MoBo:    Gigabyte GA-8I915G-MF
Chipset: Intel i915G (Intel ICH6 Southbridge)

OS is SuSE 9.3 Professional with Kernel 2.6.11.4-20a-smp (with HT) or
2.6.11.4-20a-default (without HT) - I installed and tried both (switched off
HT in Bios and installed default kernel)

Initially, performance seemed quite ok, but as i did some of my usual tests
(dd if=/dev/zero of=test.dat bs=1024k count=8192) i wondered about the bad
performance values.

For writing i get just below 7 MB/sec !!!

ata_piix on SuSE 9.3 (2.6.11.4-20a) is version 1.03

For comparison, I booted my knoppix 3.7, Kernel 2.6.9 and surprisingly I get
43 MB/sec - that`s ~6 times faster and a value i would have expected.

ata_piix on Knoppix 3.7 (2.6.9) is version 1.02

Any hints what`s going wrong here and how to fix this issue ?

thanks in advance
roland

P.S.: 
please put me on CC because i`m not on this list.


-- 
+++ NEU: GMX DSL_Flatrate! Schon ab 14,99 EUR/Monat! +++

GMX Garantie: Surfen ohne Tempo-Limit! http://www.gmx.net/de/go/dsl
