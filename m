From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: remove deprecated struct ahci_platform_data
Date: Sat, 16 Aug 2014 08:36:33 -0400
Message-ID: <20140816123633.GE9305@htj.dyndns.org>
References: <4376282.p3rdI3v8uT@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4376282.p3rdI3v8uT@amdc1032>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Aug 12, 2014 at 06:22:27PM +0200, Bartlomiej Zolnierkiewicz wrote:
> The last user of the deprecated struct ahci_platform_data has been
> cleaned up recently (SPEAr1340 got a proper PHY driver).
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.18.

Thanks!

-- 
tejun
