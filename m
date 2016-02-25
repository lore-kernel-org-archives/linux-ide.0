From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Align ata_device's id on a cacheline
Date: Thu, 25 Feb 2016 16:37:51 -0500
Message-ID: <20160225213751.GH6092@mtj.duckdns.org>
References: <1456327003-16295-1-git-send-email-harvey.hunt@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456327003-16295-1-git-send-email-harvey.hunt@imgtec.com>
Sender: stable-owner@vger.kernel.org
To: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "# 2 . 6 . 18" <stable@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Feb 24, 2016 at 03:16:43PM +0000, Harvey Hunt wrote:
> The id buffer in ata_device is a DMA target, but it isn't explicitly
> cacheline aligned. Due to this, adjacent fields can be overwritten with
> stale data from memory on non coherent architectures. As a result, the
> kernel is sometimes unable to communicate with an ATA device.
> 
> Fix this by ensuring that the id buffer is cacheline aligned.
> 
> This issue is similar to that fixed by Commit 84bda12af31f
> ("libata: align ap->sector_buf").
> 
> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: <stable@vger.kernel.org> # 2.6.18

Applied to libata/for-4.5-fixes.

Thanks.

-- 
tejun
