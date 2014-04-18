From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] libata/ahci: accommodate tag ordered controllers
Date: Fri, 18 Apr 2014 15:53:24 -0400
Message-ID: <20140418195324.GI23576@htj.dyndns.org>
References: <20140417184442.29508.45735.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140417184442.29508.45735.stgit@viggo.jf.intel.com>
Sender: stable-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Ed Ciechanowski <ed.ciechanowski@intel.com>, stable@vger.kernel.org, Matthew Wilcox <matthew.r.wilcox@intel.com>
List-Id: linux-ide@vger.kernel.org

On Thu, Apr 17, 2014 at 11:48:21AM -0700, Dan Williams wrote:
> The AHCI spec allows implementations to issue commands in tag order
> rather than FIFO order:
> 
> 	5.3.2.12 P:SelectCmd
> 	HBA sets pSlotLoc = (pSlotLoc + 1) mod (CAP.NCS + 1)
> 	or HBA selects the command to issue that has had the
> 	PxCI bit set to '1' longer than any other command
> 	pending to be issued.
> 
> The result is that commands posted sequentially (time-wise) may play out
> of sequence when issued by hardware.
> 
> This behavior has likely been hidden by drives that arrange for commands
> to complete in issue order.  However, it appears recent drives (two from
> different vendors that we have found so far) inflict out-of-order
> completions as a matter of course.  So, we need to take care to maintain
> ordered submission, otherwise we risk triggering a drive to fall out of
> sequential-io automation and back to random-io processing, which incurs
> large latency and degrades throughput.
> 
> This issue was found in simple benchmarks where QD=2 seq-write
> performance was 30-50% *greater* than QD=32 seq-write performance.
> 
> Tagging for -stable and making the change globally since it has a low
> risk-to-reward ratio.  Also, word is that recent versions of an unnamed
> OS also does it this way now.  So, drives in the field are already
> experienced with this tag ordering scheme.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ed Ciechanowski <ed.ciechanowski@intel.com>
> Reviewed-by: Matthew Wilcox <matthew.r.wilcox@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
