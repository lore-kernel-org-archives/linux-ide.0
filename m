From: Tejun Heo <tj@kernel.org>
Subject: Re: questions regarding possible violation of AHCI spec in AHCI driver
Date: Wed, 08 Dec 2010 20:55:08 +0100
Message-ID: <4CFFE29C.7080205@kernel.org>
References: <E18F441196CA634DB8E1F1C56A50A874319F70C1F2@IRVEXCHCCR01.corp.ad.broadcom.com> <4CFEE569.4030204@gmail.com> <4CFF58D2.4040006@kernel.org> <E18F441196CA634DB8E1F1C56A50A874319FA38C43@IRVEXCHCCR01.corp.ad.broadcom.com>,<4CFFCD56.6050608@kernel.org> <E18F441196CA634DB8E1F1C56A50A874319FA7E36E@IRVEXCHCCR01.corp.ad.broadcom.com>,<4CFFD3EB.10800@kernel.org> <E18F441196CA634DB8E1F1C56A50A874319FA7E36F@IRVEXCHCCR01.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E18F441196CA634DB8E1F1C56A50A874319FA7E36F@IRVEXCHCCR01.corp.ad.broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jian Peng <jipeng@broadcom.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On 12/08/2010 08:49 PM, Jian Peng wrote:
> I agree. I have AHCI based PCI card using HBA from Marvell, Via and
> Silicon Image, and am going to test my patch.  Before this patch can
> be applied universally, I like to use it for specific PCI_VENDOR_ID
> first. Here is my new patch to limit it to Broadcom's AHCI core

Hmmm... is the change actually necessary for broadcom controllers?  As
I wrote before, any ahci controller should just work without the above
checks because,

> +	/* avoid race condition per spec (end of section 10.1.2) */
> +	if (pdev->vendor == PCI_VENDOR_ID_BROADCOM) {
> +		u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
> +
> +		if (status & (ATA_BUSY | ATA_DRQ) ||
> +		    ahci_scr_read(&ap->link, SCR_STATUS, &tmp) ||
> +		    (tmp & 0x0f) != 0x03)
> +			return;

PHY event can occur here which causes the device to send D2H Reg FIS
w/ BSY set.

1. So, the controller _MUST NOT_ fail in irrecoverable way even if the
   driver sets ST while BSY is set.

2. The driver guarantees the final ST setting before entering normal
   operation is done when the prerequisites are met.

If you combine 1 and 2, the current behavior is perfectly fine.  Do
broadcom controllers actually fail without the above change?

Thanks.

-- 
tejun
