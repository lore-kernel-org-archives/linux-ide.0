Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B8B1A285
	for <linux-ide@vger.kernel.org>; Sun, 28 Dec 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766941284; cv=none; b=rcn66e1w6FiAyhOBvFGONQu7nUJLGwHeq7VPn7WI+aBw1/VpHV1myNB0SBr8aK14B5RIY5D6Ad2f3CW2SKMnAmxCljLVKbItPfkKd0TAc7Y1p4GJHHkH6AeTIy9ujasMc48mjAOmc2wsrs17u89dREmwKcj+2PuDFMzmKyjpvkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766941284; c=relaxed/simple;
	bh=lCxl2n5aD6Bb9zv77JM6BQ3kRr5ZEjbzp3hesNEVqg0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OXmxHOHDIWjSb5Q3J/bK4J6+zRWsm+sZDnDqgFY94+SMMYItDDWqp9ap6Q4HNRXhKA0t/gAEXDhPG4qQXuOvueazRKzK9nHOBChoCRoPA1UcoQIgASAnqVfwkJu2uZX2cHDNPsRppXWPERZu0CyDysDss/zPxVOW57/FMk9kCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyhN8Fj4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B+CxNqKk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyhN8Fj4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B+CxNqKk"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSEk3e03296599
	for <linux-ide@vger.kernel.org>; Sun, 28 Dec 2025 17:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=b+7B9SJgNJm4sR8RVhnBTK
	Tux/7l5bt1WKzbOSx4CCM=; b=SyhN8Fj4JfHu2Pn5S+cFk04tl0u/LNelNQf+tY
	D2gcvLE7719Dh6nEBEZyegB0lRiLMOqRL4/+JA2FAV34djTh1Us+Z40oyReEUmy5
	NOuNfooaYh0JMWMI86yhVYU8/7+zRAG77lMlX3iKJVErQQN/TgcA905uta4+J/KH
	hFLFH6GHLA+HE0KBHA2JZeuhYuzvfUCuE0g5MHLPwEd6wOFCE1onkjnRw/N5tU6j
	XCAC8+LFXY9/AUQQxutMAELNIGWC2kL8QSD1+ebG5V9ya4O4bGmiCfx+HZ69Vz5V
	+cg+xMoXfm909Qj7iZoOMO4EQhJ0Oaiux74uFt4Nt7psYACg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba71wtffu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Sun, 28 Dec 2025 17:01:21 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so10080955b3a.1
        for <linux-ide@vger.kernel.org>; Sun, 28 Dec 2025 09:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766941281; x=1767546081; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b+7B9SJgNJm4sR8RVhnBTKTux/7l5bt1WKzbOSx4CCM=;
        b=B+CxNqKkfUuFkuNLzmcYxim2GGhWr2/QQCl6LY76LrqF16FYjTsF/CONREVjN5K7Vb
         a9vGRBfZAh7S9VsGZPmrwwA7V+aOsmHNVGmCGqQbfkhRjMXOpgezQtOzb1KTr98h5830
         9WHhhxN47a9V0XodGpeCn9cSy06g9z8S9Us5upZzATzH0p2uD0wYBz5YyslipRVF4uMj
         Y0tx4q6RxCFwZiwEX7u7bp7+KJf0xg7g1feTZSvwUxK0nEpzUEE265xzyqSM/EnoniBS
         lYPYTG6dFCdJqBx8cNmFhrnNb8hBRxlqN0G73dwi7VLB28G5lbJS6Ojq8OGOWCWWOnmm
         7dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766941281; x=1767546081;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+7B9SJgNJm4sR8RVhnBTKTux/7l5bt1WKzbOSx4CCM=;
        b=LY1v+LD7yHYxVOKkFw0HOk7nLqsHC3H3phv4Z1x+XWynTLgDY3R2AIMLlID/s202wZ
         UKnW+lD1GXEJ1BkNpCVcnhcSqNx9vY0h6z4OUtfTlHxm1NoMLIrq1zFyQgX93bEXd1yj
         QSkgQ5rLHpAi06hpPQnURDmjgpQyF3f98bMJnHbuesAKIWEsOKuffFMqYqUgOQAjiEuF
         YgRgmB+qYZBT+saGU8K1H079SIHHwXO1+mDRPLCKps2kV9ZgZ6/Zxb9k5BIv5EgLamo2
         mINQDb9lDAgZlZo/fqL5b/lBdC7L9o8L5uoa39NCIfG09gbhqP8HHhgSN5w7L2UlV3q4
         l3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI6t9JplvOb/a5aSv8jqCmzM5q0nb7G7+u4ZaKy67FwfKOAn7iu/I63U20Heg9kEOEbrWmLz+9o9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM21Pf6QZ7Bfq75qgcvQqncTZFYGMTr/tCUP4tYk/OekZKJNNE
	9vLLpXCg5CTXD3u47lX3WCvOIKli5QsMQ4FYonioKnalPFOAMWPo5+WGJP/n/nGvL45/9H85JgT
	zj8cnMHfg6W3WB6OqMGbx10ke1xyPMja8Ih9w5iYZIeAxAWLKFtmFzca/QPWMntU=
X-Gm-Gg: AY/fxX7qE597MZj/HqK3oRaui2LTuy5K5qOuw5f9W3GSg3Y7Szbqj1v60riC654aogp
	tw/uhSNxDqzFbmsktpAi5WNaTwhc9L2USgD6wxhvCdPsmVHW+evFv/lzJsUEvUih69RgR1yzy0L
	8IL3cf8kuNKdvD6pwFjfx9khj1HaL6CXC2p8x6Zaa2PEUSQQLOy8t5ThN6IlQamezFVlvyKJHzo
	gCGnqewomo/rfjBt5RjOz3aW75T69tAIAGFY3Zx6Kd3PuUkhfRoQZCwwoQq7xxttDcDfe39EL+N
	EA8mNGiwAZS80prE/DByMw2d6RfxTgqJZLw8SVnpAdRDDtQlMKo36X3u9Kx8bxv1ui4QB78JXx0
	1saTYFu0ARyQlGhtKEIsCRVGF+6mCJEMblp8=
X-Received: by 2002:a05:6a00:ac85:b0:7ab:3454:6f22 with SMTP id d2e1a72fcca58-7ff648e4b26mr29080845b3a.16.1766941280338;
        Sun, 28 Dec 2025 09:01:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb9mwgHytfvSq+b5K7BOcjZZAV6Gx7cYLWysZuXgYYAy05VYXb5dQJbI15XSLOV5ECpUVkXw==
X-Received: by 2002:a05:6a00:ac85:b0:7ab:3454:6f22 with SMTP id d2e1a72fcca58-7ff648e4b26mr29080783b3a.16.1766941279755;
        Sun, 28 Dec 2025 09:01:19 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:90aa:5191:e297:e185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7ae354easm27053925b3a.16.2025.12.28.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:01:19 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v4 0/5] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Date: Sun, 28 Dec 2025 22:31:00 +0530
Message-Id: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExiUWkC/3WNQQ6CMBAAv0J6toRuW2g8+Q/joZStNBHBVhsN4
 e8WEpSDXjaZzc7sSAJ6h4Hss5F4jC64/ppA7DJiWn09I3VNYgIFSMYKTgfjaAe0KjkvOatLqzV
 Jx4NH655L6HhK3Lpw7/1r6UY2b9eEXBOR0YIqUUvLLEOJ6tCHkN8e+mL6rsvTIHMpwtZWHxuSj
 ao2oqlqK6D5Y/ONDd/fPNlGgioEaNSi+mFP0/QGNszM1R8BAAA=
X-Change-ID: 20251103-pci-m2-7633631b6faa
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4147;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=lCxl2n5aD6Bb9zv77JM6BQ3kRr5ZEjbzp3hesNEVqg0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUWJZyvHz/45h4posumn1eViZOd0E2qGRJDadW
 VpJVYQe0AOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVFiWQAKCRBVnxHm/pHO
 9XXJB/9VGjuweTs1AAQWECsLaA3eY7wzGJFn+vbSYPinXe47ogqWEn4NoAHg6C08SUvgrNYdAKv
 XP7Drzzma8hav/IYwzhAHA+uRUebMvbiFVtbvio49KAFO4YNm/tb9IOoWGxoZUrKScGKOnnCieW
 SWdreBMlvafOu/CRTCc/gVCc1j29qsqdVKQ4bEO/7as9VT2gJDh0b9vVpBbz7Rq80zpByeGYVKM
 dQuJm4h9KdeUWLPTxRNylnpVwINpQz2q/tgC3RpMPd1hL9dVPOF/9VF6tqblzQpruMYpdLpaU2r
 odu8CdUoZryRE+YQeC2kL7TCwVzAlsvzUAi5GoxQ27L2Z8Kp
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1NiBTYWx0ZWRfX1E3Z7AgOmYth
 6Gu9mTtcbIi+Ood9HtNh3qKBv7rIuwa9z4OYux2X6rJkQSeMBbadQ3K5bux+j/Zt4JVqUT853k0
 tj2YxFA8qxV/lvjpp4uaLvZ6cDJ+wXHExaxF0JUKP5uW/ANrz46bFdh21u5eoG721lU77zn+AB5
 GegTI1ICI7pBJcRZeaPllqAJP9GY+fb1MgnfuUOg2Jk6sDH8+mZUaDJ3yEE/b0X8YkcTdoflDub
 puUw9x8WqizYRxv4RwThAgpu1IkfoO0OIqeY/O3OmTqqOqrdwXlUYyXrRapOsgGvA9/H3XLSo0V
 os40ye6ZBolCshSeeTo8jPOefXvrAaGLqVVwPEQl+IQVrwSfujuplGRCt4H8IBWJg5+5n3gyyer
 vu3Rj9kB5A1yUIxIYDFhis1aVIV2ep0fodp0xS4wyN7aaK+7xdJcaVScQJiUrmXsVAo+9OA1HOP
 DYIrGkm1Ur/NPNuSz5w==
X-Proofpoint-ORIG-GUID: inXROwntekiqqHPD3x2BP21djJ2ddu-h
X-Proofpoint-GUID: inXROwntekiqqHPD3x2BP21djJ2ddu-h
X-Authority-Analysis: v=2.4 cv=CK4nnBrD c=1 sm=1 tr=0 ts=69516261 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=otkVNQseMVp4AOM4PXIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280156

Hi,

This series is an initial attempt to support the PCIe M.2 connectors in the
kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
in PCs). On the ACPI platforms, power to these connectors are mostly handled by
the firmware/BIOS and the kernel never bothered to directly power manage them as
like other PCIe connectors. But on the devicetree platforms, the kernel needs to
power manage these connectors with the help of the devicetree description. But
so far, there is no proper representation of the M.2 connectors in devicetree
binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
and fixed regulators in devicetree.

So to properly support the M.2 connectors in devicetree platforms, this series
introduces the devicetree binding for Mechanical Key M connector as an example
and also the corresponding pwrseq driver and PCI changes in kernel to driver the
connector.

The Mechanical Key M connector is used to connect SSDs to the host machine over
PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
support for driving the PCIe interface of the connector in the kernel.

Also, the optional interfaces supported by the Key M connectors are not
supported in the driver and left for the future enhancements.

Testing
=======

This series, together with the devicetree changes [2] [3] were tested on the
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the NVMe SSD connected
over PCIe.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts?h=v6.18-rc4&id=d09ab685a8f51ba412d37305ea62628a01cbea57
[2] https://github.com/Mani-Sadhasivam/linux/commit/40120d02219f34d2040ffa6328f0d406b1e4c04d
[3] https://github.com/Mani-Sadhasivam/linux/commit/ff6c3075836cc794a3700b0ec6a4a9eb21d14c6f

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v4:
- Added graph property to SATA in this series and PCI to dtschema:
  https://github.com/devicetree-org/dt-schema/pull/180
- Used 'i2c-parent' instead of SMBus port
- Reworded the -gpios property description
- Rebased on top of v6.19-rc1
- Link to v3: https://lore.kernel.org/r/20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com

Changes in v3:
- Changed the VIO supply name as per dtschema
- Added explicit endpoint properties to port 0 node for host I/F
- Used scope based cleanup for OF node in pwrseq driver
- Collected review tags
- Link to v2: https://lore.kernel.org/r/20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com

Changes in v2:
- Incorporated comments from Bartosz and Frank for pwrseq and dt-binding
  patches, especially adding the pwrseq match() code.
- Link to v1: https://lore.kernel.org/r/20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com

---
Manivannan Sadhasivam (5):
      dt-bindings: ata: sata: Document the graph port
      dt-bindings: connector: Add PCIe M.2 Mechanical Key M connector
      PCI/pwrctrl: Add support for handling PCIe M.2 connectors
      PCI/pwrctrl: Create pwrctrl device if the graph port is found
      power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors

 .../devicetree/bindings/ata/sata-common.yaml       |   3 +
 .../bindings/connector/pcie-m2-m-connector.yaml    | 133 +++++++++++++++++
 MAINTAINERS                                        |   7 +
 drivers/pci/probe.c                                |   3 +-
 drivers/pci/pwrctrl/Kconfig                        |   1 +
 drivers/pci/pwrctrl/slot.c                         |  35 ++++-
 drivers/power/sequencing/Kconfig                   |   8 ++
 drivers/power/sequencing/Makefile                  |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 160 +++++++++++++++++++++
 9 files changed, 345 insertions(+), 6 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251103-pci-m2-7633631b6faa

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

