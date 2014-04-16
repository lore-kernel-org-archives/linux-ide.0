From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] ahci: disable DEVSLP for Intel Valleyview
Date: Wed, 16 Apr 2014 06:29:11 -0700
Message-ID: <20140416062911.73971dd7@ultegra>
References: <1397123934-27114-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<5800248.4YbvBlxjQc@amdc1032>
	<20140411102451.GA26252@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140411102451.GA26252@mtj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Kefeng Wang <kefeng.wang@linaro.org>
List-Id: linux-ide@vger.kernel.org

On Fri, 11 Apr 2014 06:24:51 -0400
Tejun Heo <tj@kernel.org> wrote:

> On Fri, Apr 11, 2014 at 12:14:14PM +0200, Bartlomiej Zolnierkiewicz
> wrote:
> > You most likely need to rebase your changes on top of the
> > aforementioned patch (Tejun?).
> 
> Waiting for -rc1 to drop before applying patches.  I can resolve the
> conflict later when applying.  Please go ahead and post the updated
> version.
> 
Just posted v2 with suggestions from Bartlomiej. 

Thanks,

Jacob
