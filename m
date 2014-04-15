From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: fix kconfig selection warning
Date: Tue, 15 Apr 2014 14:17:13 -0400
Message-ID: <20140415181713.GE30990@htj.dyndns.org>
References: <1397584255-15038-1-git-send-email-pefoley2@pefoley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397584255-15038-1-git-send-email-pefoley2@pefoley.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Foley <pefoley2@pefoley.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Tue, Apr 15, 2014 at 01:50:55PM -0400, Peter Foley wrote:
> When building with COMPILE_TEST, AHCI_XGENE is enabled even though
> PHY_XGENE (which it selects) requires OF to be enabled.
> Fix this by adding a dependency on OF to AHCI_XGENE.
> 
> warning: (AHCI_XGENE) selects PHY_XGENE which has unmet direct
> dependencies (HAS_IOMEM && OF && (ARM64 || COMPILE_TEST))
> 
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>

Already fixed in libata/for-3.15-fixes.  Will push out in several
days.

Thanks.

-- 
tejun
