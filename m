From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] ata: ahci_platform: minor fixes
Date: Thu, 12 Jul 2018 13:03:43 -0700
Message-ID: <20180712200343.GK72677@devbig577.frc2.facebook.com>
References: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe@baylibre.com>
Cc: hdegoede@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jul 12, 2018 at 11:41:28AM +0000, Corentin Labbe wrote:
> Hello
> 
> This patchset fixes some minor problem found when working on supporting
> allwinner R40 AHCI.
> 
> Regards
> 
> Corentin Labbe (3):
>   ata: ahci_platform: correct parameter documentation for
>     ahci_platform_shutdown
>   ata: ahci_platform: convert kzallloc to kcalloc
>   ata: ahci_platform: convert kcalloc to devm_kcalloc

Applied all three to libata/for-4.19 with Hans's ack added.

Thanks.

-- 
tejun
