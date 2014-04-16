From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata/ahci: accommodate tag ordered controllers
Date: Wed, 16 Apr 2014 16:29:06 -0400
Message-ID: <20140416202906.GA26632@htj.dyndns.org>
References: <20140331183458.32378.97892.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140331183458.32378.97892.stgit@viggo.jf.intel.com>
Sender: stable-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Ed Ciechanowski <ed.ciechanowski@intel.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Dan.

On Mon, Mar 31, 2014 at 11:35:14AM -0700, Dan Williams wrote:
...
> +	for (i = 0; i < ATA_MAX_QUEUE; i++) {
> +		tag = (i + ap->tag_order) & (ATA_MAX_QUEUE - 1);

Can you please change the last modular to % ATA_MAX_QUEUE?

Thanks.

-- 
tejun
