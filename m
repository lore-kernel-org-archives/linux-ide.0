From: Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH] ahci: qoriq: fixed using uninitialized variable warnings
Date: Mon, 14 Sep 2015 06:51:36 +0000
Message-ID: <DM2PR03MB574B7F5FBB2844161CD7482FA5D0@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1441790182-20248-1-git-send-email-Yuantian.Tang@freescale.com>
 <20150909140130.GB22909@mtj.duckdns.org>
 <DM2PR03MB5746E6637A2BC5081EC5428FA500@DM2PR03MB574.namprd03.prod.outlook.com>
 <20150911135431.GP8114@mtj.duckdns.org>
 <DM2PR03MB574FA9FAB46F5091AA8746CFA5D0@DM2PR03MB574.namprd03.prod.outlook.com>
 <20150914040456.GA21102@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150914040456.GA21102@wfg-t540p.sh.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Tejun Heo <tj@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

The ARCH should have been ARM for this driver.
Do you think this warning would go away if adding a dependency on ARM?

Regards,
Yuantian

> -----Original Message-----
> From: Fengguang Wu [mailto:fengguang.wu@intel.com]
> Sent: Monday, September 14, 2015 12:05 PM
> To: Tang Yuantian-B29983 <Yuantian.Tang@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>; hdegoede@redhat.com; linux-
> ide@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH] ahci: qoriq: fixed using uninitialized variable warnings
> 
> Yuantian,
> 
> It's cross compiling on ARCH=openrisc.
> 
> Thanks,
> Fengguang
> 
> On Mon, Sep 14, 2015 at 03:02:27AM +0000, Yuantian Tang wrote:
> > Hello Tejun,
> >
> > The toolchain I used is:
> > gcc version 4.8.3 20140401 (prerelease) (Linaro GCC 4.8-2014.04)
> >
> > I have not found this warning using this tool chain with -Wuninitialized flag.
> >
> > Regards,
> > Yuantian
> >
> > > -----Original Message-----
> > > From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of Tejun Heo
> > > Sent: Friday, September 11, 2015 9:55 PM
> > > To: Tang Yuantian-B29983 <Yuantian.Tang@freescale.com>
> > > Cc: hdegoede@redhat.com; linux-ide@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org; Fengguang Wu
> > > <fengguang.wu@intel.com>
> > > Subject: Re: [PATCH] ahci: qoriq: fixed using uninitialized variable
> > > warnings
> > >
> > > Hello, Yuantian.
> > >
> > > On Fri, Sep 11, 2015 at 05:27:25AM +0000, Yuantian Tang wrote:
> > > > Hi Tejun,
> > > >
> > > > Could you please take the version 1 patch?
> > > > The version 2 patch can't address these warnings, and the version
> > > > 1 can
> > > definitely remove them.
> > > > In this case, that would cause any hidden bugs, so no worries.
> > >
> > > Ugh... I really hate changes which are made to just work around
> > > compiler silliness.  If this is something which goes away with newer
> > > gcc, Fengguang can just make it as a known false positive.
> > > Yuantian, which compiler are you using?
> > >
> > > Thanks.
> > >
> > > --
> > > tejun
