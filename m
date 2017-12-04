From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: qoriq: refine port register configuration
Date: Mon, 4 Dec 2017 12:19:33 -0800
Message-ID: <20171204201933.GD2421075@devbig577.frc2.facebook.com>
References: <20171204090120.2142-1-andy.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171204090120.2142-1-andy.tang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.tang@nxp.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Dec 04, 2017 at 05:01:20PM +0800, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> These PP2C and PP3C registers control the configuration of the PHY
> control OOB timing for the COMINIT/COMWAKE parameters respectively
> for sata port. Overwrite default values with calculated ones to get
> better OOB timing.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>

Applied to libata/for-4.15-fixes.

Thanks.

-- 
tejun
