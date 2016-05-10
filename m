From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Date: Tue, 10 May 2016 12:30:22 -0400
Message-ID: <20160510163022.GL7110@mtj.duckdns.org>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
 <20160508200008.GM4775@htj.duckdns.org>
 <20160509010952.GN4775@htj.duckdns.org>
 <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
 <yw1xmvnziofc.fsf@unicorn.mansr.com>
 <20160509190536.GK7110@mtj.duckdns.org>
 <CAHp75Vf6kivRBd+9nMUU-sLPrA3ctiwvXnqrAFHX3XJWPeNO1Q@mail.gmail.com>
 <20160510060440.GF2274@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33832 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcEJQaY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 May 2016 12:30:24 -0400
Content-Disposition: inline
In-Reply-To: <20160510060440.GF2274@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Lamparter <chunkeey@googlemail.com>, Julian Margetson <runaway@candw.ms>

Hello,

On Tue, May 10, 2016 at 11:34:40AM +0530, Vinod Koul wrote:
> > slave-dma [1], branch topic/dw. But I think Vinod can tell us which
> > tag/branch will be immutable. Vinod?
> 
> Please use branch topic/dw. I will not rebase this before sending to Linus.

Okay, pulled topic/dw into libata/for-4.7-dw and applied 1-22 on top.
Please let me know how patch 23 should be routed.

Thanks.

-- 
tejun
