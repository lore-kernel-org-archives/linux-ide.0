From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Revert "ata: ahci_platform: convert kcalloc to
 devm_kcalloc"
Date: Tue, 24 Jul 2018 09:47:57 -0700
Message-ID: <20180724164757.GO1934745@devbig577.frc2.facebook.com>
References: <1531824575-852-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531824575-852-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe@baylibre.com>
Cc: hdegoede@redhat.com, sfr@canb.auug.org.au, mperttunen@nvidia.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jul 17, 2018 at 10:49:35AM +0000, Corentin Labbe wrote:
> Since ahci_platform_put_resources() use target_pwrs after "devm_" freed
> it, we cannot use devm_kcalloc for allocating target_pwrs.
> 
> This reverts commit bd0038b1b4f499d814d8f33a55b1df5ea6cf3b85.
> 
> Reported-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied to libata/for-4.19.  Sorry about the delay.

Thanks.

-- 
tejun
