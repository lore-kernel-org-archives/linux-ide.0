From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Date: Sun, 8 May 2016 16:00:08 -0400
Message-ID: <20160508200008.GM4775@htj.duckdns.org>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Lamparter <chunkeey@googlemail.com>, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>, Vinod Koul <vinod.koul@intel.com>
List-Id: linux-ide@vger.kernel.org

Hello, Andy.

On Wed, May 04, 2016 at 03:22:51PM +0300, Andy Shevchenko wrote:
> Tejun, since Vinod applied all necessary patches into his tree, the
> series now has just a dependency to whatever branch / tag he marks for
> it.
> Do we have a chance to see the SATA series be applied in your tree?

Applied 1-22 to libata/for-4.7.  There was a couple trivial conflicts
which I resolved while applying but it'd be great if you can check
whether everything looks okay.

 https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.7

How is patch 23 gonna be routed?  Should I pick that one up too?

Thanks.

-- 
tejun
