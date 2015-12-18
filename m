From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Fri, 18 Dec 2015 17:18:53 +0000
Message-ID: <yw1xtwnfad4y.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1x1tanffqg.fsf@unicorn.mansr.com>
	<1450364395.30729.136.camel@linux.intel.com>
	<yw1x60zxds5k.fsf@unicorn.mansr.com>
	<1450367702.30729.146.camel@linux.intel.com>
	<yw1xk2odcb87.fsf@unicorn.mansr.com>
	<1450371184.30729.175.camel@linux.intel.com>
	<5672F77F.4010306@candw.ms> <yw1xfuz1c5xy.fsf@unicorn.mansr.com>
	<567302E8.5050303@candw.ms> <yw1x7fkcdi2a.fsf@unicorn.mansr.com>
	<5673061A.4070700@candw.ms> <yw1x37v0df86.fsf@unicorn.mansr.com>
	<56732C04.9040100@candw.ms> <yw1xvb7wbowu.fsf@unicorn.mansr.com>
	<5673F277.2050607@candw.ms> <yw1xegekarp9.fsf@unicorn.mansr.com>
	<1450441395.30729.203.camel@linux.intel.com>
	<yw1x37uzc45t.fsf@unicorn.mansr.com> <5674271B.9090308@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:48384 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932287AbbLRRTB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2015 12:19:01 -0500
In-Reply-To: <5674271B.9090308@candw.ms> (Julian Margetson's message of "Fri,
	18 Dec 2015 11:32:43 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Julian Margetson <runaway@candw.ms> writes:

> On 12/18/2015 8:49 AM, M=E5ns Rullg=E5rd wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>
>>>>> [    5.206125] Unable to handle kernel paging request for data at
>>>>> address 0x00000000
>>>>> [    5.228546] Faulting instruction address: 0xc043a2c8
>>>>> [    5.248577] Vector: 300 (Data Access) at [eddafae0]
>>>>> [    5.268658]     pc: c043a2c8: sata_dwc_qc_issue+0xb8/0x204
>>>> Well, that's not good.  Can you translate that address to a line o=
f
>>>> code?
>>> Besides that, can you enable DYNAMIC_DEBUG in the config and append
>>> 'dw_dmac_core.dyndbg dw_dmac.dyndbg' to the kernel cmdline?
>> Enabling debug messages in the sata_dwc driver might also be informa=
tive.
>>
> Changed the sata-dwc to a module .
>
> [   18.475140] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_=
dwc_xfer_setup returns NULL
> [   18.535698] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_=
dwc_xfer_setup returns NULL

That's strange.  The only way that can happen is if
dmaengine_prep_slave_sg() return NULL, and that really shouldn't be
happening.  Did you turn on debug messages in dw_dma?  You can enable
some extra debug messages by adding "#define VERBOSE_DEBUG" at the top
of drivers/dma/dw/core.c

--=20
M=E5ns Rullg=E5rd
