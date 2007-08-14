From: Adrian Bunk <bunk@kernel.org>
Subject: [-mm patch] unexport ide_acpi_set_state
Date: Tue, 14 Aug 2007 23:23:07 +0200
Message-ID: <20070814212307.GK18945@stusta.de>
References: <20070809015106.cd0bfc53.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070809015106.cd0bfc53.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Aug 09, 2007 at 01:51:06AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.23-rc2-mm1:
>...
> +ide-ide-hook-acpi-psx-method-to-ide-power-on-off.patch
>...
>  IDE tree updates
>...

This patch removes the unused EXPORT_SYMBOL_GPL(ide_acpi_set_state)

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

83b4e185ad61709d63cb44516b46a343d221d9f9 
diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 6bff81a..1d5f682 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -649,7 +649,6 @@ void ide_acpi_set_state(ide_hwif_t *hwif, int on)
 	if (!on)
 		acpi_bus_set_power(hwif->acpidata->obj_handle, ACPI_STATE_D3);
 }
-EXPORT_SYMBOL_GPL(ide_acpi_set_state);
 
 /**
  * ide_acpi_init - initialize the ACPI link for an IDE interface

