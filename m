From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/4] ata: add remaining new-style AHCI platform drivers
Date: Mon, 17 Mar 2014 20:18:41 +0100
Message-ID: <53274A91.8020809@redhat.com>
References: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Shiraz Hashim <shiraz.hashim@st.com>, Kevin Hilman <khilman@deeprootsystems.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, davinci-@jasper.es, linux-ide@vger.kernel.org, Viresh Kumar <viresh.linux@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 03/17/2014 07:31 PM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds new-style AHCI platform drivers for DaVinci DA850
> AHCI controller and ST SPEAr1340 AHCI controller.  As a preparation for
> adding these drivers it also fixes ahci_platform_data->suspend() handling
> (patch #1) and moves library AHCI platform code to its own file (patch #2).
> The new AHCI platform drivers are only compile tested (they are marked as
> experimental because of this) and I would ask somebody with the hardware
> to verify them (thanks!).

Thanks for working on this.

Patches 1/2 seem sensible to me, and 3/4 are obviously a good idea. Also
all patches look good to me, so this series is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (4):
>   ata: ahci_platform: fix ahci_platform_data->suspend method handling
>   ata: move library code from ahci_platform.c to libahci_platform.c
>   ata: add new-style AHCI platform driver for DaVinci DA850 AHCI
>     controller
>   ata: add new-style AHCI platform driver for ST SPEAr1340 AHCI
>     controller
> 
>  drivers/ata/Kconfig            |  23 +-
>  drivers/ata/Makefile           |  10 +-
>  drivers/ata/ahci_da850.c       | 178 ++++++++++++++
>  drivers/ata/ahci_platform.c    | 508 --------------------------------------
>  drivers/ata/ahci_spear1340.c   | 222 +++++++++++++++++
>  drivers/ata/libahci_platform.c | 541 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 967 insertions(+), 515 deletions(-)
>  create mode 100644 drivers/ata/ahci_da850.c
>  create mode 100644 drivers/ata/ahci_spear1340.c
>  create mode 100644 drivers/ata/libahci_platform.c
> 
