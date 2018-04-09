From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Revert "ata: ahci-platform: add reset control support"
Date: Mon, 9 Apr 2018 15:12:18 -0700
Message-ID: <20180409221218.GJ3126663@devbig577.frc2.facebook.com>
References: <1523237554-7928-1-git-send-email-hayashi.kunihiko@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523237554-7928-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Apr 09, 2018 at 10:32:34AM +0900, Kunihiko Hayashi wrote:
> This reverts commit f0f56716fc3e5d547fd7811eb218a30ed0695605.
> 
> According to Thierry's view,
> https://www.spinics.net/lists/linux-ide/msg55357.html
> some hardware-specific drivers already use their own resets,
> and the common reset might make a path to occur double controls of resets.
> 
> For now, revert the commit that adds reset control support to ahci-platform,
> and hold until the solution is confirmed not be affect all hardware-specific
> drivers.
> 
> Fixes: f0f56716fc3e ("ata: ahci-platform: add reset control support")
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Applied to libata/for-4.17-fixes.

Thanks.

-- 
tejun
