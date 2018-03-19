From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] libata: Apply NOLPM quirk to Crucial M500 480 and
 960GB SSDs
Date: Mon, 19 Mar 2018 08:37:22 -0700
Message-ID: <20180319153722.GP2943022@devbig577.frc2.facebook.com>
References: <20180319153400.25694-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180319153400.25694-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Mar 19, 2018 at 04:33:58PM +0100, Hans de Goede wrote:
> There have been reports of the Crucial M500 480GB model not working
> with LPM set to min_power / med_power_with_dipm level.
> 
> It has not been tested with medium_power, but that typically has no
> measurable power-savings.
> 
> Note the reporters Crucial_CT480M500SSD3 has a firmware version of MU03
> and there is a MU05 update available, but that update does not mention any
> LPM fixes in its changelog, so the quirk matches all firmware versions.
> 
> In my experience the LPM problems with (older) Crucial SSDs seem to be
> limited to higher capacity versions of the SSDs (different firmware?),
> so this commit adds a NOLPM quirk for the 480 and 960GB versions of the
> M500, to avoid LPM causing issues with these SSDs.
> 
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: Martin Steigerwald <martin@lichtvoll.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied 1-3 to libata/for-4.16-fixes.

Thanks.

-- 
tejun
