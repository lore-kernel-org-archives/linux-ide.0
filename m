From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
Subject: Re: [PATCH V3] AHCI: Workaround for ThunderX Errata#22536
Date: Thu, 25 Feb 2016 12:31:53 -0800
Message-ID: <56CF64B9.4080605@caviumnetworks.com>
References: <1455653329-4934-1-git-send-email-tchalamarla@caviumnetworks.com>
 <alpine.DEB.2.11.1602171710350.19512@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1on0058.outbound.protection.outlook.com ([157.56.110.58]:56347
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751818AbcBYUcB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Feb 2016 15:32:01 -0500
In-Reply-To: <alpine.DEB.2.11.1602171710350.19512@nanos>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: tj@kernel.org, stripathi@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 02/17/2016 08:12 AM, Thomas Gleixner wrote:
> On Tue, 16 Feb 2016, tchalamarla@caviumnetworks.com wrote:
>> +#ifdef CONFIG_ARM64
>> +/* Due to ERRATA#22536, ThunderX need to handle
>> + * HOST_IRQ_STAT differently.
>> + * Work around is to make sure all pending IRQs
>> + * are served before leaving handler
>> + */
>> +static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
>> +{
>> +	struct ata_host *host = dev_instance;
>> +	struct ahci_host_priv *hpriv;
>> +	unsigned int rc = 0;
>> +	void __iomem *mmio;
>> +	u32 irq_stat, irq_masked;
>> +	unsigned int handled = 1;
>> +
>> +	VPRINTK("ENTER\n");
>
> Come on. This VPRINK stuff is really pointless. Enable irq tracepoints, they
> already track the enter/exit of interrupt handlers ....
>

sure. waiting for some more comments if any.
> Thanks,
>
> 	tglx
>
>
