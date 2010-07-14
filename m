From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH v7] libata: pata_samsung: Add Samsung PATA controller
 driver
Date: Wed, 14 Jul 2010 03:51:32 -0400
Message-ID: <4C3D6C84.5020403@garzik.org>
References: <1278994985-15748-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1278994985-15748-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, ben-linux@fluff.org, jgarzik@redhat.com, sshtylyov@mvista.com, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

On 07/13/2010 12:23 AM, Kukjin Kim wrote:
> From: Abhilash Kesavan<a.kesavan@samsung.com>
>
> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsystem.
>
> Signed-off-by: Abhilash Kesavan<a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> Cc: Ben Dooks<ben-linux@fluff.org>
> Acked-by: Sergei Shtylyov<sshtylyov@mvista.com>
> ---
> Changes since v6:
> - Removed check for device 1 in pata_s3c_wait_after_reset() and
>    associated changes
> - Initialized directly in pata_s3c_remove() and pata_s3c_resume()
>
>   drivers/ata/Kconfig           |    9 +
>   drivers/ata/Makefile          |    1 +
>   drivers/ata/pata_samsung_cf.c |  683 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 693 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/ata/pata_samsung_cf.c

applied
