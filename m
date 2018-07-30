From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
Date: Mon, 30 Jul 2018 08:22:56 -0700
Message-ID: <20180730152256.GF1206094@devbig004.ftw2.facebook.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
 <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: hdegoede@redhat.com, rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Jul 30, 2018 at 08:15:47AM -0700, Srinivas Pandruvada wrote:
> Hi Tejan,
> 
> On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada wrote:
> > Some minor fixes to be able to correctly set devslp register
> > to optimize power.
> > 
> > Srinivas Pandruvada (2):
> >   ata: libahci: Correct setting of DEVSLP register
> >   ata: libahci: Allow reconfigure of DEVSLP register
> > 
> Are you applying this series?

I was waiting for Hans's reviews.  Hans, what do you think?

Thanks.

-- 
tejun
