From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: Re: [PATCH v7] SATA: OCTEON: support SATA on OCTEON platform
Date: Thu, 4 Feb 2016 16:05:34 +0000
Message-ID: <56B376CE.9010600@imgtec.com>
References: <1454520915-27948-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <56B342FF.1090709@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:18629 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932997AbcBDQGB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Feb 2016 11:06:01 -0500
In-Reply-To: <56B342FF.1090709@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, tj@kernel.org, hdegoede@redhat.com
Cc: david.daney@cavium.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

Thank-you for the review.

On 04/02/16 12:24, Aleksey Makarov wrote:
>
> Hi Zubair,
>
>> +	void __iomem *base;
>
> [..]
>
>> +	cfg = cvmx_read_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG);
>
> sparse will complain here.  See Documentation/sparse.txt

Yes. sparse says

...
CHECK   drivers/ata/sata_octeon.c
drivers/ata/sata_octeon.c:50:30: warning: cast removes address space of expression
drivers/ata/sata_octeon.c:65:25: warning: cast removes address space of expression
...

Use of (__force uint64_t) removes the sparse warning. But it was
frowned upon by arnd.

He suggested a wrapper helper in asm/octeon/cvmx.h which handles iomem
addresses and __force behind the scenes rather than in the driver.

static inline void cvmx_write_csr_resource(void __iomem *csr_addr, uint64_t val)
{
	cvmx_write_csr((__force uint64_t)csr_addr, val)
}

Alternatives? Or should I resend with the above wrapper?

Regards,
ZubairLK

>
> Thank you
> Aleksey Makarov
>
