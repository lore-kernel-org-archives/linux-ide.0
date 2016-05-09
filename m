From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Date: Sun, 8 May 2016 21:09:52 -0400
Message-ID: <20160509010952.GN4775@htj.duckdns.org>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
 <20160508200008.GM4775@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33015 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbcEIBJ6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 May 2016 21:09:58 -0400
Content-Disposition: inline
In-Reply-To: <20160508200008.GM4775@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Lamparter <chunkeey@googlemail.com>, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>, Vinod Koul <vinod.koul@intel.com>

On Sun, May 08, 2016 at 04:00:08PM -0400, Tejun Heo wrote:
> Hello, Andy.
> 
> On Wed, May 04, 2016 at 03:22:51PM +0300, Andy Shevchenko wrote:
> > Tejun, since Vinod applied all necessary patches into his tree, the
> > series now has just a dependency to whatever branch / tag he marks for
> > it.
> > Do we have a chance to see the SATA series be applied in your tree?
> 
> Applied 1-22 to libata/for-4.7.  There was a couple trivial conflicts
> which I resolved while applying but it'd be great if you can check
> whether everything looks okay.
> 
>  https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.7

Oops, build failure.  Reverted for now.

Thanks.

-- 
tejun
