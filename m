From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v4 1/3] ahci-platform: Bump max number of clocks to 5
Date: Mon, 15 Sep 2014 19:09:54 -0700
Message-ID: <FDA51DE0-3F2C-48E3-81B7-5F2ABCEE6F61@codeaurora.org>
References: <1410277008-20242-1-git-send-email-galak@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410277008-20242-1-git-send-email-galak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On Sep 9, 2014, at 8:36 AM, Kumar Gala <galak@codeaurora.org> wrote:

> Qualcomm IPQ806x SoCs with SATA controllers need 5 clocks to be enabled.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
> (reposted with Hans on list)
> 
> v4:
> * Updated to upstream changes
> 
> drivers/ata/ahci.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Any updates on these patches?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
