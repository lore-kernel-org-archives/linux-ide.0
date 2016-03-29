From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 0/3] ahci: add ports-implemented dt bindings.
Date: Tue, 29 Mar 2016 14:11:12 +0100
Message-ID: <1459257075-21393-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35127 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbcC2NL2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Mar 2016 09:11:28 -0400
Received: by mail-wm0-f45.google.com with SMTP id 191so50264467wmq.0
        for <linux-ide@vger.kernel.org>; Tue, 29 Mar 2016 06:11:27 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Tejun,

On some SOCs PORTS_IMPL register value is never programmed by the BIOS
and left at zero value. Which means that no sata ports are available for
software. AHCI driver used to cope up with this by fabricating the
port_map if the PORTS_IMPL register is read zero, but recent patch [1]
broke this workaround as zero value was valid for nvme disks.

This patch adds ports-implemented dt bindings as workaround for this issue
in a way that DT can dictate the port_map incase where the SOCs does not
program it already.

Am sure that there are more than one SOC that hits this issue.

Without this patchset, ACHI on APQ8064 Qualcomm platform is broken in mainline.
With the below patchset am able to get back the functionality.

Thanks,
srini
[1] 566d18 "libata: disable forced PORTS_IMPL for >= AHCI 1.3"

Srinivas Kandagatla (3):
  libahci: save port map for forced port map
  ata: ahci-platform: Add ports-implemented dt bindings.
  ARM: dts: apq8064: add ahci ports-implemented mask

 Documentation/devicetree/bindings/ata/ahci-platform.txt | 11 +++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi                     |  1 +
 drivers/ata/ahci_platform.c                             |  4 ++++
 drivers/ata/libahci.c                                   |  1 +
 4 files changed, 17 insertions(+)

-- 
2.5.0

