From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/3] ahci: add ports-implemented dt bindings
Date: Fri,  1 Apr 2016 08:52:55 +0100
Message-ID: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36713 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458AbcDAHxG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Apr 2016 03:53:06 -0400
Received: by mail-wm0-f43.google.com with SMTP id 127so10550991wmu.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Apr 2016 00:53:04 -0700 (PDT)
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

Can you take all the patches via libata tree, I have collected the
acks required for DT.

Changes since v2:
	- reordered compatible strings in DT spotted by Sergei.

Changes since RFC:
	- Remove DT example as suggested by Rob.
	- Fixed comments on DT binding patch as suggested by Rob.
	- removed unused variable spotted by kernel test robot.

Thanks,
srini
[1] 566d18 "libata: disable forced PORTS_IMPL for >= AHCI 1.3"

Srinivas Kandagatla (3):
  libahci: save port map for forced port map
  ata: ahci-platform: Add ports-implemented DT bindings.
  ARM: dts: apq8064: add ahci ports-implemented mask

 Documentation/devicetree/bindings/ata/ahci-platform.txt | 4 ++++
 arch/arm/boot/dts/qcom-apq8064.dtsi                     | 3 ++-
 drivers/ata/ahci_platform.c                             | 3 +++
 drivers/ata/libahci.c                                   | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.5.0

