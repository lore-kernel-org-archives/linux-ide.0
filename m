From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Date: Tue, 10 May 2016 19:44:21 +0300
Message-ID: <1462898661.17131.308.camel@linux.intel.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
	 <20160508200008.GM4775@htj.duckdns.org>
	 <20160509010952.GN4775@htj.duckdns.org>
	 <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
	 <yw1xmvnziofc.fsf@unicorn.mansr.com>
	 <20160509190536.GK7110@mtj.duckdns.org>
	 <CAHp75Vf6kivRBd+9nMUU-sLPrA3ctiwvXnqrAFHX3XJWPeNO1Q@mail.gmail.com>
	 <20160510060440.GF2274@localhost> <20160510163022.GL7110@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63422 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbcEJQn3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 May 2016 12:43:29 -0400
In-Reply-To: <20160510163022.GL7110@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Lamparter <chunkeey@googlemail.com>, Julian Margetson <runaway@candw.ms>

On Tue, 2016-05-10 at 12:30 -0400, Tejun Heo wrote:
> Hello,
> 
> On Tue, May 10, 2016 at 11:34:40AM +0530, Vinod Koul wrote:
> > 
> > > 
> > > slave-dma [1], branch topic/dw. But I think Vinod can tell us
> > > which
> > > tag/branch will be immutable. Vinod?
> > Please use branch topic/dw. I will not rebase this before sending to
> > Linus.
> Okay, pulled topic/dw into libata/for-4.7-dw and applied 1-22 on top.

Thanks!

> Please let me know how patch 23 should be routed.

Since Rob Acked you may take it as well.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

