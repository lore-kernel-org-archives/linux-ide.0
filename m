From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] ahci: Allow setting a default LPM policy for mobile
 chipsets
Date: Mon, 11 Dec 2017 06:42:23 -0800
Message-ID: <20171211144223.GB2421075@devbig577.frc2.facebook.com>
References: <20171206154110.11548-1-hdegoede@redhat.com>
 <20171206154110.11548-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171206154110.11548-4-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Hans.

On Wed, Dec 06, 2017 at 04:41:10PM +0100, Hans de Goede wrote:
>  CONFIG_SATA_AHCI=y
> +CONFIG_SATA_MOBILE_LPM_POLICY=3

This would change the default behavior.  Can we not do that?

Other than that, looks good to me.

Thanks.

-- 
tejun
