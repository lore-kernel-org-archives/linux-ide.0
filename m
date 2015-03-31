From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH RESEND 0/3] Enable ahci_st for stih407 and fix hang
Date: Tue, 31 Mar 2015 08:35:06 +0100
Message-ID: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:34082 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbbCaHfO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2015 03:35:14 -0400
Received: by wgbdm7 with SMTP id dm7so9179989wgb.1
        for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2015 00:35:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, tj@kernel.org, srinivas.kandagatla@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

Now that miphy28lp phy is present upstream we can add sata DT nodes for
stih407 family silicon. As part of testing this I found a hang
with the current driver implmentation which does some register writes
before enabling the IP clock. Presumably on stih416 devices the sata
clock must have already been enabled by the targetpack/bootloader.

This series also tidys up some inaccuracies in the DT documentation
where the doc hasn't kept aligned with the driver. In addtion to these
fixes I've also added an example for stih407 silicon.

Changes in RESEND:
- Rebased on v4.0-rc6 (Pete)
- Applied Acks (Pete)

Peter Griffin (3):
  ahci: st: Update the ahci_st DT documentation
  ARM: DT: STi: STiH407: Add sata DT nodes.
  ahci: st: st_configure_oob must be called after IP is clocked.

 Documentation/devicetree/bindings/ata/ahci-st.txt | 45 ++++++++++++++++-------
 arch/arm/boot/dts/stih407-family.dtsi             | 44 ++++++++++++++++++++++
 drivers/ata/ahci_st.c                             |  6 ++-
 3 files changed, 80 insertions(+), 15 deletions(-)

-- 
1.9.1

