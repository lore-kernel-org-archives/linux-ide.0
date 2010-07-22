From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: SIL24: pcie_set_readrq 4096
Date: Thu, 22 Jul 2010 11:47:06 +0900
Message-ID: <AANLkTinMJktVl28m-mL8i9N8_Q9V471LV3XsxsZlLIp7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43344 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab0GVCrI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jul 2010 22:47:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, tj@kernel.org

Hi,
  After implementing driver for PCIe RC controller of a SOC, I came
across peculiarity
while testing SIL3132 directly connected to the root port.

My RC IP is configured for maximum of 256bytes of payload size.
The sata_sil24 driver unconditionally sets pcie_set_readrq(pdev, 4096)
for the endpoint
which apparently works for 'every' other host irrespective of their capacity.

In my case it works only if I change to
  pcie_set_readrq(pdev, 256)

Shouldn't the Linux PCI have provision to allow max_read/payload_size
not higher than
the least of max capacities of all agents in the chain ?

I see similar use of pcie_set_readrq(pdev, 4096), so could be I am
missing something ?

Thanks.
