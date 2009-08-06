From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 2.6.32 v2] MCP55 SATA2 conditional MSI support for sata_nv
Date: Thu, 06 Aug 2009 17:11:56 -0600
Message-ID: <4A7B633C.3040500@gmail.com>
References: <20090805192055.8F2DE1007C@gold.linx.net>	 <4A7A16C9.6030500@gmail.com>	 <412A05BA40734D4887DBC67661F433080D73228B@EXMAIL.ad.emulex.com> <1249574363.4530.23.camel@localhost> <412A05BA40734D4887DBC67661F433080D7322B1@EXMAIL.ad.emulex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756912AbZHFXMC@vger.kernel.org>
In-Reply-To: <412A05BA40734D4887DBC67661F433080D7322B1@EXMAIL.ad.emulex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chetan.Loke@Emulex.Com
Cc: tony@linx.net, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, philipl@overt.org, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

On 08/06/2009 10:28 AM, Chetan.Loke@Emulex.Com wrote:
>> -----Original Message-----
>> From: Tony Vroon [mailto:tony@linx.net]
>> Sent: Thursday, August 06, 2009 11:59 AM
>> To: Loke,Chetan
>> Cc: hancockrwd@gmail.com; jgarzik@pobox.com; linux-ide@vger.kernel.org;
>> linux-kernel@vger.kernel.org; philipl@overt.org
>> Subject: RE: [PATCH 2.6.32 v2] MCP55 SATA2 conditional MSI support for
>> sata_nv
>>
>>> disable_msi() is missing right?
>> I didn't add that as none of the other drivers have it:
>
> Then they would leak the MSI-vectors if request_irq fails.
>
>
>> chainsaw@amalthea /cvs/linux-2.6/drivers/ata $ grep _msi * | grep pci
>> ahci.c:		pci_enable_msi(pdev);
>> sata_mv.c:	if (msi&&  pci_enable_msi(pdev) == 0)
>> sata_vsc.c:	if (pci_enable_msi(pdev) == 0)
>>
>> (This is a tree without the sata_nv change I submitted)
>>
>> I do believe it is safe to shut the interrupt down and unload the
>> handler whilst it is still in MSI mode. At least, I don't see the libata
>> core special-casing it in any way.
>
> If I'm not wrong then that's how it's supposed to be done. free_irq and then disable_msi. You can't reverse the order. Also the driver should know when to quiesce the ASIC. So quiesce first and then shutdown everything.

Seems like devres should handle this somehow, or else something in 
libata core.. Tejun?
