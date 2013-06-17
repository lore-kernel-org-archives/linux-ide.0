From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: remove dead code from libata-acpi.c
Date: Mon, 17 Jun 2013 11:01:51 -0700
Message-ID: <20130617180151.GG32663@mtj.dyndns.org>
References: <1371265368-7334-1-git-send-email-liuj97@gmail.com>
 <51BE6B5C.70803@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51BE6B5C.70803@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, Aaron Lu <aaron.lu@intel.com>
Cc: Liu Jiang <liuj97@gmail.com>, Liu Jiang <liu97@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Liu Jiang <jiang.liu@huawei.com>
List-Id: linux-ide@vger.kernel.org

On Mon, Jun 17, 2013 at 09:50:20AM +0800, Aaron Lu wrote:
> On 06/15/2013 11:02 AM, Liu Jiang wrote:
> > From: Liu Jiang <liu97@gmail.com>
> > 
> > Commit 30dcf76acc69 "libata: migrate ACPI code over to new bindings"
> > removed ACPI dock notification related code, but there's some dead
> > code left, so clean up it.
> 
> I never noticed this, but it looks to be the case...
> 
> I'm not sure the dock notification code is removed intentionally or
> mistakenly though, if it is a mistake, then instead of removing the left
> code here, we probably should add the dock notification code back.
> 
> But I have no test system or any knowledge about how ata dock works, so
> I may be wrong :-)

Looks like a regression to me.  We're probably locking up on some
older laptops which connects optical drives with hotpluggable PATA.
Matthew, can you please fix it?

Thanks.

-- 
tejun
