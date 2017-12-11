From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ahci: Allow setting a default LPM policy for mobile
 chipsets
Date: Mon, 11 Dec 2017 08:54:04 -0800
Message-ID: <20171211165404.GM2421075@devbig577.frc2.facebook.com>
References: <20171211165216.5604-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38617 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbdLKQyI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2017 11:54:08 -0500
Content-Disposition: inline
In-Reply-To: <20171211165216.5604-1-hdegoede@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Dec 11, 2017 at 05:52:16PM +0100, Hans de Goede wrote:
> On many laptops setting a different LPM policy then unknown /
> max_performance can lead to power-savings of 1.0 - 1.5 Watts (when idle).
> 
> Modern ultrabooks idle around 6W (at 50% screen brightness), 1.0 - 1.5W
> is a significant chunk of this.
> 
> There are some performance / latency costs to enabling LPM by default,
> so it is desirable to make it possible to set a different LPM policy
> for mobile / laptop variants of chipsets / "South Bridges" vs their
> desktop / server counterparts. Also enabling LPM by default is not
> entirely without risk of regressions. At least min_power is known to
> cause issues with some disks, including some reports of data corruption.
> 
> This commits adds a new ahci.mobile_lpm_policy kernel cmdline option,
> which defaults to a new SATA_MOBILE_LPM_POLICY Kconfig option so that
> Linux distributions can choose to set a LPM policy for mobile chipsets
> by default.
> 
> The reason to have both a kernel cmdline option and a Kconfig default
> value for it, is to allow easy overriding of the default to allow
> trouble-shooting without needing to rebuild the kernel.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-4.16.

Thanks, Hans.

-- 
tejun
