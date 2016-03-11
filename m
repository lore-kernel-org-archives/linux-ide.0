From: "Lawson, Scott" <scott.lawson@intel.com>
Subject: RE: [PATCH] AHCI: Remove obsolete Intel Lewisburg SATA RAID device
 IDs
Date: Fri, 11 Mar 2016 02:17:22 +0000
Message-ID: <25D872D72B010441A7C6B485BAB2DEF10108E57A@ORSMSX102.amr.corp.intel.com>
References: <1456510192-27184-1-git-send-email-scott.lawson@intel.com>
 <20160227085154.GB26010@infradead.org>
 <20160227111855.GW3965@htj.duckdns.org>
 <20160228131003.GA21800@infradead.org>
 <20160228131646.GK3965@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160228131646.GK3965@htj.duckdns.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello:

There shouldn't be any hardware dependencies on these device IDs out there. I've checked with the author of the specification these IDs are published in, and he said that they never corresponded to any existing or planned hardware. (That begs the question of why they appeared in an earlier version of the specification in the first place, but that's something we need work out internally.)

There really is no advantage to keeping them around, and no reasonable "just in case" scenario that they would be useful for.

-Scott Lawson 


-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of Tejun Heo
Sent: Sunday, February 28, 2016 05:17
To: Christoph Hellwig <hch@infradead.org>
Cc: Lawson, Scott <scott.lawson@intel.com>; linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AHCI: Remove obsolete Intel Lewisburg SATA RAID device IDs

Hello,

On Sun, Feb 28, 2016 at 05:10:03AM -0800, Christoph Hellwig wrote:
> On Sat, Feb 27, 2016 at 06:18:55AM -0500, Tejun Heo wrote:
> > On Sat, Feb 27, 2016 at 12:51:54AM -0800, Christoph Hellwig wrote:
> > > On Fri, Feb 26, 2016 at 10:09:52AM -0800, scott.lawson@intel.com wrote:
> > > > From: Scott Lawson <scott.lawson@intel.com>
> > > > 
> > > > These PCI device IDs have been removed from the Intel Lewisburg 
> > > > design specification. They are no longer needed.
> > > 
> > > Let's keep them just in case..
> > 
> > Out of curiosity, any specific reasons to do so?
> 
> If it's been added to the driver I'd expect at least prototype 
> hardware to already be out there.

I see.  Scott, can you please clarify the situation?

Thanks.
