From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/9] libata-acpi: implement ata_acpi_associate()
Date: Thu, 24 May 2007 22:50:27 -0400
Message-ID: <46564EF3.8080103@garzik.org>
References: <11791672962540-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11791672962540-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> * Add acpi_handle to ata_host and ata_port.  Rename
>   ata_device->obj_handle to ->acpi_handle and move it above such that
>   it doesn't get cleared on reconfiguration.
> 
> * Replace ACPI node association which ata_acpi_associate() which is
>   called once during host initialization.  Unlike the previous
>   implementation, ata_acpi_associate() uses ATA_FLAG_ACPI_SATA to
>   choose between IDE or SATA ACPI hierarchy and uses simple child look
>   up instead of recursive walk to match the nodes.  This is way safer
>   and simpler.  Please read the following message for more info.
> 
>   http://article.gmane.org/gmane.linux.ide/17554
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-acpi.c |  369 ++++++---------------------------------------
>  drivers/ata/libata-core.c |    3 +
>  drivers/ata/libata.h      |    2 +
>  include/linux/libata.h    |   13 +-
>  4 files changed, 63 insertions(+), 324 deletions(-)

applied 4-9 to #upstream


