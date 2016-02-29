From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V3] AHCI: Workaround for ThunderX Errata#22536
Date: Mon, 29 Feb 2016 16:17:04 -0500
Message-ID: <20160229211704.GA3965@htj.duckdns.org>
References: <1455653329-4934-1-git-send-email-tchalamarla@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455653329-4934-1-git-send-email-tchalamarla@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tchalamarla@caviumnetworks.com
Cc: stripathi@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Tue, Feb 16, 2016 at 12:08:49PM -0800, tchalamarla@caviumnetworks.com wrote:
> From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
> 
> Due to Errata in ThunderX, HOST_IRQ_STAT should be
> cleared before leaving the interrupt handler.
> The patch attempts to satisfy the need.
> 
> Changes from V2:
> 	- removed newfile
> 	- code is now under CONFIG_ARM64
> 
> Changes from V1:
> 	- Rebased on top of libata/for-4.6
>         - Moved ThunderX intr handler to new file
> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>

Applied to libata/for-4.5-fixes w/ minor adjustments to comments.

Thanks.

-- 
tejun
