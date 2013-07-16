From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: Fix DVD not dectected at some platform with
 Wellsburg PCH
Date: Tue, 16 Jul 2013 05:53:24 -0600
Message-ID: <20130716115324.GC23827@mtj.dyndns.org>
References: <1373591757-416-1-git-send-email-youquan.song@intel.com>
 <20130716114826.GB23827@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130716114826.GB23827@mtj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Youquan Song <youquan.song@intel.com>
Cc: jgarzik@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, seth.heasley@intel.com, james.d.ralston@intel.com, ed.ciechanowski@intel.com, Youquan Song <youquan.song@linux.intel.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jul 16, 2013 at 05:48:26AM -0600, Tejun Heo wrote:
> On Thu, Jul 11, 2013 at 09:15:57PM -0400, Youquan Song wrote:
> > There is a patch b55f84e2d527182e7c611d466cd0bb6ddce201de "ata_piix: Fix DVD
> >  not dectected at some Haswell platforms" to fix an issue of DVD not 
> > recognized on Haswell Desktop platform with Lynx Point. 
> > Recently, it is also found the same issue at some platformas with Wellsburg PCH.
> > 
> > So deliver a similar patch to fix it by disables 32bit PIO in IDE mode.
> > 
> > Signed-off-by: Youquan Song <youquan.song@intel.com>
> > Cc: stable@vger.kernel.org
> 
> Applied to libata/for-3.12.  Thanks!

Oops, make that libata/for-3.11-fixes.

-- 
tejun
