From: "Jian Peng" <jipeng@broadcom.com>
Subject: RE: questions regarding possible violation of AHCI spec in AHCI
 driver
Date: Wed, 8 Dec 2010 12:09:32 -0800
Message-ID: <E18F441196CA634DB8E1F1C56A50A874319FA38CD3@IRVEXCHCCR01.corp.ad.broadcom.com>
References: <E18F441196CA634DB8E1F1C56A50A874319F70C1F2@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4CFEE569.4030204@gmail.com> <4CFF58D2.4040006@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA38C43@IRVEXCHCCR01.corp.ad.broadcom.com>,<4CFFCD56.6050608@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA7E36E@IRVEXCHCCR01.corp.ad.broadcom.com>,<4CFFD3EB.10800@kernel.org>
 <E18F441196CA634DB8E1F1C56A50A874319FA7E36F@IRVEXCHCCR01.corp.ad.broadcom.com>
 <4CFFE29C.7080205@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CFFE29C.7080205@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

The controller may take much longer time to recover in this case, and leads to wrong HW state after stop_engine() inside ahci_hardreset() and cause device type checking failure due to unfinished HW state change and missing D2H FIS after start_engine() again inside ahci_hardreset(). I guess this is the reason why AHCI spec try to emphasize.

Yes, without this change, Broadcom controller will fail due to above reason.

Thanks,
Jian

-----Original Message-----
From: Tejun Heo [mailto:tj@kernel.org] 
Sent: Wednesday, December 08, 2010 11:55 AM
To: Jian Peng
Cc: Robert Hancock; linux-kernel@vger.kernel.org; jgarzik@pobox.com; ide
Subject: Re: questions regarding possible violation of AHCI spec in AHCI driver

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
