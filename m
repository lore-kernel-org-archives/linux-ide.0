From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add new med_power_with_dipm
 link_power_management_policy setting
Date: Mon, 18 Sep 2017 20:23:42 -0700
Message-ID: <20170919032341.GM378890@devbig577.frc2.facebook.com>
References: <20170914103536.7650-1-hdegoede@redhat.com>
 <20170914103536.7650-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:51734 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdISDXq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 18 Sep 2017 23:23:46 -0400
Content-Disposition: inline
In-Reply-To: <20170914103536.7650-2-hdegoede@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 14, 2017 at 12:35:36PM +0200, Hans de Goede wrote:
> As described by Matthew Garret quite a while back:
> https://mjg59.dreamwidth.org/34868.html
> 
> Intel CPUs starting with the Haswell generation need SATA links to power
> down for the "package" part of the CPU to reach low power-states like
> PC7 / P8 which bring a significant power-saving with them.
> 
> The default max_performance lpm policy does not allow for these high
> PC states, both the medium_power and min_power policies do allow this.
> 
> The min_power policy saves significantly more power, but there are some
> reports of some disks / SSDs not liking min_power leading to system
> crashes and in some cases even data corruption has been reported.
> 
> Matthew has found a document documenting the default settings of
> Intel's IRST Windows driver with which most laptops ship:
> https://www-ssl.intel.com/content/dam/doc/reference-guide/sata-devices-implementation-recommendations.pdf
> 
> Matthew wrote a patch changing med_power to match those defaults, but
> that never got anywhere as some people where reporting issues with the
> patch-set that patch was a part of.
> 
> This commit is another attempt to make the default IRST driver settings
> available under Linux, but instead of changing medium_power and
> potentially introducing regressions, this commit adds a new
> med_power_with_dipm setting which is identical to the existing
> medium_power accept that it enables dipm on top, which makes it match
> the Windows IRST driver settings, which should hopefully be safe to
> use on most devices.
> 
> The med_power_with_dipm setting is close to min_power, except that:
> a) It does not use host-initiated slumber mode (ASP not set),
>    but it does allow device-initiated slumber
> b) It does not enable DevSlp mode
> 
> On my T440s test laptop I get the following power savings when idle:
> medium_power		0.9W
> med_power_with_dipm	1.2W
> min_power		1.2W
> 
> Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-4.15.

Thanks.

-- 
tejun
