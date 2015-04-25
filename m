From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/2] libata: Add helper to determine when PHY events
 should be ignored
Date: Sat, 25 Apr 2015 16:53:34 -0400
Message-ID: <20150425205334.GA1499@htj.duckdns.org>
References: <1429984357-2223-1-git-send-email-gabriele.mzt@gmail.com>
 <1429984357-2223-2-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429984357-2223-2-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: stripathi@apm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Apr 25, 2015 at 07:52:36PM +0200, Gabriele Mazzotta wrote:
> +bool sata_lpm_ignore_phy_events(struct ata_link *link)
> +{
> +	/* if LPM is enabled, PHYRDY doesn't mean anything */
> +	return !!(link->lpm_policy > ATA_LPM_MAX_POWER);

This gets removed by the next patch so it doesn't matter but there's
no need to do !! here.  The expression is already bool and even if not
casting to bool can't yield any other result.

Thanks.

-- 
tejun
