From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] constify ata_port_info
Date: Thu, 24 Aug 2017 10:26:00 -0700
Message-ID: <20170824172559.GT491396@devbig577.frc2.facebook.com>
References: <1503568201-9991-1-git-send-email-arvind.yadav.cs@gmail.com>
 <20170824142346.GN491396@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170824142346.GN491396@devbig577.frc2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: b.zolnierkie@samsung.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Aug 24, 2017 at 07:23:46AM -0700, Tejun Heo wrote:
> On Thu, Aug 24, 2017 at 03:19:58PM +0530, Arvind Yadav wrote:
> > ata_port_info are not supposed to change at runtime. All functions
> > working with ata_port_info provided by <linux/libata.h> work with
> > const ata_port_info. So mark the non-const structs as const.
> 
> Applied 1-3 to libata/for-4.14.

Caused build warnings.  Reverted.  Please test before submitting
patches.

Thanks.

-- 
tejun
