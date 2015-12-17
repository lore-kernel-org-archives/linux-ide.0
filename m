From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 3/3] ata: sata_dwc_460ex: get rid of global data
Date: Thu, 17 Dec 2015 15:19:13 +0000
Message-ID: <yw1x1taldrwu.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<1450221935-6034-3-git-send-email-mans@mansr.com>
	<1450364765.30729.139.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450364765.30729.139.camel@linux.intel.com> (Andy Shevchenko's
	message of "Thu, 17 Dec 2015 17:06:05 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, 2015-12-15 at 23:25 +0000, Mans Rullgard wrote:
>> This moves all global data into the driver private struct, thus
>> permitting multiple devices of this type to be used.
>>=20
>
> Nice!
>
> Btw, last time Linus complained about new warnings. Most of them I ha=
ve
> fixed when moved to external DMA driver. Leftovers IIRC are related t=
o
> address space. Are you going to fix them? Otherwise it might be a
> headache for him again with strong wording to our address I suppose.

There are some issues with __iomem annotations.  Is that the warnings
you refer to?  I'm not getting any regular compiler warnings.

--=20
M=E5ns Rullg=E5rd
