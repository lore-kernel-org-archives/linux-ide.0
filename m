From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 2/3] ata: Add Qualcomm ARM SoC AHCI SATA host
 controller driver
Date: Tue, 9 Sep 2014 07:24:47 +0900
Message-ID: <20140908222447.GC3806@mtj.dyndns.org>
References: <1410194390-29007-1-git-send-email-galak@codeaurora.org>
 <1410194390-29007-2-git-send-email-galak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410194390-29007-2-git-send-email-galak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: linux-ide@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

On Mon, Sep 08, 2014 at 11:39:49AM -0500, Kumar Gala wrote:
> Add support for the Qualcomm AHCI SATA controller that exists on several
> SoC and specifically the IPQ806x family of chips.  The IPQ806x SATA support
> requires the associated IPQ806x SATA PHY Driver to be enabled as well.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

Please cc Hans de Goede <hdegoede@redhat.com> on all ahci_platform
related changes.

Thanks.

-- 
tejun
