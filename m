From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 0/3] Enable ahci_st for stih407 and fix hang
Date: Mon,  2 Mar 2015 12:48:36 +0000
Message-ID: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:42304 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581AbbCBMso (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2015 07:48:44 -0500
Received: by wghl2 with SMTP id l2so33201897wgh.9
        for <linux-ide@vger.kernel.org>; Mon, 02 Mar 2015 04:48:43 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, tj@kernel.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org

Hi,

Now that miphy28lp phy is present upstream we can add sata DT nodes for
stih407 family silicon. As part of testing this I found a hang
with the current driver implmentation which does some register writes
before enabling the IP clock. Presumably on stih416 devices the sata
clock must have already been enabled by the targetpack/bootloader.

This series also tidys up some inaccuracies in the DT documentation
where the doc hasn't kept aligned with the driver. In addtion to these
fixes I've also added an example for stih407 silicon.

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

