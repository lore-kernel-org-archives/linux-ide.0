From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Fri, 18 Dec 2015 12:49:50 +0000
Message-ID: <yw1x37uzc45t.fsf@unicorn.mansr.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450441395.30729.203.camel@linux.intel.com> (Andy Shevchenko's
	message of "Fri, 18 Dec 2015 14:23:15 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

>> > [=A0=A0=A0=A05.206125] Unable to handle kernel paging request for =
data at
>> > address 0x00000000
>> > [=A0=A0=A0=A05.228546] Faulting instruction address: 0xc043a2c8
>> > [=A0=A0=A0=A05.248577] Vector: 300 (Data Access) at [eddafae0]
>> > [=A0=A0=A0=A05.268658]=A0=A0=A0=A0=A0pc: c043a2c8: sata_dwc_qc_iss=
ue+0xb8/0x204
>>=20
>> Well, that's not good.=A0=A0Can you translate that address to a line=
 of
>> code?
>
> Besides that, can you enable DYNAMIC_DEBUG in the config and append
> 'dw_dmac_core.dyndbg dw_dmac.dyndbg' to the kernel cmdline?

Enabling debug messages in the sata_dwc driver might also be informativ=
e.

--=20
M=E5ns Rullg=E5rd
