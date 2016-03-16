From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 0/2] ARM: dts: r8a7773/gose: enable SATA
Date: Wed, 16 Mar 2016 18:11:06 +0100
Message-ID: <1458148268-22028-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33568 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487AbcCPRLN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Mar 2016 13:11:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: horms@verge.net.au
Cc: linux-renesas-soc@vger.kernel.org, linux-ide@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

This enables SATA on the Gose board.

CU
Uli


Ulrich Hecht (2):
  ARM: dts: r8a7793: Add SATA controller node
  ARM: dts: gose: Enable SATA controller

 arch/arm/boot/dts/r8a7793-gose.dts |  4 ++++
 arch/arm/boot/dts/r8a7793.dtsi     | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.6.4

