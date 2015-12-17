From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/3] ata: sata_dwc_460ex: get rid of global data
Date: Thu, 17 Dec 2015 17:37:53 +0200
Message-ID: <1450366673.30729.144.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	 <1450221935-6034-3-git-send-email-mans@mansr.com>
	 <1450364765.30729.139.camel@linux.intel.com>
	 <yw1x1taldrwu.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4326 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243AbbLQPhi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Dec 2015 10:37:38 -0500
In-Reply-To: <yw1x1taldrwu.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2015-12-17 at 15:19 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>=20
> > On Tue, 2015-12-15 at 23:25 +0000, Mans Rullgard wrote:
> > > This moves all global data into the driver private struct, thus
> > > permitting multiple devices of this type to be used.
> > >=20
> >=20
> > Nice!
> >=20
> > Btw, last time Linus complained about new warnings. Most of them I
> > have
> > fixed when moved to external DMA driver. Leftovers IIRC are related
> > to
> > address space. Are you going to fix them? Otherwise it might be a
> > headache for him again with strong wording to our address I
> > suppose.
>=20
> There are some issues with __iomem annotations.=C2=A0=C2=A0Is that th=
e warnings
> you refer to?=C2=A0=C2=A0I'm not getting any regular compiler warning=
s.
>=20

I guess I got them because I'am checking sparse warnings as well.


There is the original Linus' complain.
http://permalink.gmane.org/gmane.linux.ide/59391

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

