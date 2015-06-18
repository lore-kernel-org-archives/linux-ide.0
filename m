From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Do not blacklist Micron M500DC
Date: Thu, 18 Jun 2015 14:53:11 -0400
Message-ID: <20150618185311.GF12934@mtj.duckdns.org>
References: <1434653418-4562-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434653418-4562-1-git-send-email-martin.petersen@oracle.com>
Sender: stable-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jun 18, 2015 at 02:50:18PM -0400, Martin K. Petersen wrote:
> Queued TRIM got disabled on Micron M500DC drives thanks to the
> "Micron_M500*" pattern we had in place to accommodate the previous
> generation of this drive family. Tweak the blacklist entry slightly so
> we only disable queued TRIM for the non-DC variants of M500 drives.
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: stable@vger.kernel.org

Applied to libata/for-4.2.  This one isn't too urgent so letting it
propagate through -rc1 should be fine.

Thanks.

-- 
tejun
