From: Tejun Heo <tj@kernel.org>
Subject: Re: SiI3811 PATA->SATA bridge not working on OpenRD-Base
Date: Tue, 15 Dec 2009 08:07:37 +0900
Message-ID: <4B26C539.1030202@kernel.org>
References: <20091113212332.GD1965@twin.sascha.silbe.org> <4B14B2C8.6080002@kernel.org> <20091214195909.GB29549@twin.sascha.silbe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32944 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758736AbZLNXHp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Dec 2009 18:07:45 -0500
In-Reply-To: <20091214195909.GB29549@twin.sascha.silbe.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Sascha Silbe <sascha-ml-reply-to-2009-4@silbe.org>, Mark Lord <mlord@pobox.com>

Hello,

cc'ing Mark and quoting whole body.  Mark, sata_mv timing problem.
Can you please handle this one?

Thanks.

On 12/15/2009 04:59 AM, Sascha Silbe wrote:
> On Tue, Dec 01, 2009 at 03:08:08PM +0900, Tejun Heo wrote:
>> In libata-sff.c there are several places which set AC_ERR_HSM.  They
>> store the reason why they're setting it using ata_eh_push_desc() but
>> for EH commands those messages aren't printed out (we probably need to
>> fix that).  Anyways, can you please conver those to printk's and see
>> which one is setting HSM error?
> OK, this got me going, thanks! I couldn't find where AC_ERR_HSM is set,
> but sata_mv now told me about the IORDY timeout. It seems the IDE<->SATA
> converter is slower than the internal native SATA HD, but probably (see
> below) still within spec.
> 
> mv_soc_reset_hc_port() sets EDMA_IORDY_TMOUT to the default value of
> 0xBC which assumes a 150MHz clock. After setting it to 0xFA (which
> assumes a 200MHz clock) the device works fine (at least with hdparm -tT).
> 
> Clock description for the 88F6281 (the SoC on the OpenRD-Base) is
> incomplete and/or messy in the published documents (Functional
> Specifications and Hardware Specifications), so I'm not quite sure what
> the right value is:
> - Hardware Specifications defines TCLK/Core clock as 200MHz and SATA
> clock as 150MHz
> - stock UBoot (i.e. Marvell version) prints 400MHz for "SysClock" and
> 200MHz for "TClock"
> - Functional Specifications says eIORdyTimeout is the "number of system
> cycles", giving 0xBC for "SysClock == 150MHz"
> 
> So depending on what exactly the clock source for the IORDY timeout is,
> the correct value should be one of:
> - 0x00BC (150MHz, SATA clock from Hardware Specifications; implying the
> device is too slow so unlikely as it works fine with other hosts)
> - 0x00FA (200MHz, TCLK from Hardware Specifications)
> - 0x01F4 (400MHz, SysClock from UBoot)

-- 
tejun
