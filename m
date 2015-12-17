From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 3/3] ata: sata_dwc_460ex: get rid of global data
Date: Thu, 17 Dec 2015 15:57:57 +0000
Message-ID: <yw1xsi31cbju.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<1450221935-6034-3-git-send-email-mans@mansr.com>
	<1450364765.30729.139.camel@linux.intel.com>
	<yw1x1taldrwu.fsf@unicorn.mansr.com>
	<1450366673.30729.144.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:45997 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934785AbbLQP6A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2015 10:58:00 -0500
In-Reply-To: <1450366673.30729.144.camel@linux.intel.com> (Andy Shevchenko's
	message of "Thu, 17 Dec 2015 17:37:53 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Thu, 2015-12-17 at 15:19 +0000, M=E5ns Rullg=E5rd wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>=20
>> > On Tue, 2015-12-15 at 23:25 +0000, Mans Rullgard wrote:
>> > > This moves all global data into the driver private struct, thus
>> > > permitting multiple devices of this type to be used.
>> > >=20
>> >=20
>> > Nice!
>> >=20
>> > Btw, last time Linus complained about new warnings. Most of them I
>> > have
>> > fixed when moved to external DMA driver. Leftovers IIRC are relate=
d
>> > to
>> > address space. Are you going to fix them? Otherwise it might be a
>> > headache for him again with strong wording to our address I
>> > suppose.
>>=20
>> There are some issues with __iomem annotations.=A0=A0Is that the war=
nings
>> you refer to?=A0=A0I'm not getting any regular compiler warnings.
>>=20
>
> I guess I got them because I'am checking sparse warnings as well.
>
> There is the original Linus' complain.
> http://permalink.gmane.org/gmane.linux.ide/59391

He's right, those casts are ugly and possibly wrong.  I was thinking of
cleaning it up, but first I wanted to get it working at all with my
hardware.

--=20
M=E5ns Rullg=E5rd
