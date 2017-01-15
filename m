From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: imx: fix building without hwmon or thermal
Date: Sun, 15 Jan 2017 18:52:31 -0500
Message-ID: <20170115235231.GE14446@mtj.duckdns.org>
References: <20170111133652.3715437-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34300 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbdAOXwd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jan 2017 18:52:33 -0500
Content-Disposition: inline
In-Reply-To: <20170111133652.3715437-1-arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 11, 2017 at 02:36:16PM +0100, Arnd Bergmann wrote:
> When CONFIG_HWMON is disabled, we now get a link failure:
> 
> ERROR: "devm_hwmon_device_register_with_groups" [drivers/ata/ahci_imx.ko] undefined!
> drivers/ata/ahci_imx.o: In function `imx_ahci_probe':
> ahci_imx.c:(.text.imx_ahci_probe+0x304): undefined reference to `devm_thermal_zone_of_sensor_register'
> 
> This makes the code calling into the hwmon subsystem compile-time
> conditional, and adds a Kconfig dependency to avoid the corner
> case of having HWMON=m and AHCI_IMX=y, by forcing AHCI_IMX=m in this
> case. The thermal subsystem already has a check in its header, but
> that also doesn't cover the THERMAL=m case, so we need a somewhat
> complex Kconfig expression to handle all cases.
> 
> Fixes: 54643a83b41a ("ahci: imx: Add imx53 SATA temperature sensor support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to libata/for-4.11.

Thanks.

-- 
tejun
