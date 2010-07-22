From: Tejun Heo <tj@kernel.org>
Subject: Re: SIL24: pcie_set_readrq 4096
Date: Thu, 22 Jul 2010 15:18:37 +0200
Message-ID: <4C48452D.5070207@kernel.org>
References: <AANLkTinMJktVl28m-mL8i9N8_Q9V471LV3XsxsZlLIp7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53878 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759295Ab0GVNUj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jul 2010 09:20:39 -0400
In-Reply-To: <AANLkTinMJktVl28m-mL8i9N8_Q9V471LV3XsxsZlLIp7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Hello,

On 07/22/2010 04:47 AM, Jassi Brar wrote:
>   After implementing driver for PCIe RC controller of a SOC, I came
> across peculiarity
> while testing SIL3132 directly connected to the root port.
> 
> My RC IP is configured for maximum of 256bytes of payload size.
> The sata_sil24 driver unconditionally sets pcie_set_readrq(pdev, 4096)
> for the endpoint
> which apparently works for 'every' other host irrespective of their capacity.
> 
> In my case it works only if I change to
>   pcie_set_readrq(pdev, 256)
> 
> Shouldn't the Linux PCI have provision to allow max_read/payload_size
> not higher than
> the least of max capacities of all agents in the chain ?
> 
> I see similar use of pcie_set_readrq(pdev, 4096), so could be I am
> missing something ?

It's been a while since I read pci-e spec but IIUC readrq size and
payload size are independent and if readrq is larger than payload size
it's supposed to complete in multiple steps.  I could be wrong tho.

Thanks.

-- 
tejun
