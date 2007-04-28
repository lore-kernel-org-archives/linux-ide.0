From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 07/13] libata-acpi: add ATA_FLAG_ACPI_SATA port flag
Date: Sat, 28 Apr 2007 14:58:25 -0400
Message-ID: <46339951.3080508@garzik.org>
References: <11772636662936-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11772636662936-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Whether a controller needs IDE or SATA ACPI hierarchy is determined by
> the programming interface of the controller not by whether the
> controller is SATA or PATA, or it supports slave device or not.  This
> patch adds ATA_FLAG_ACPI_SATA port flags which tells libata-acpi that
> the port needs SATA ACPI nodes, and sets the flag for ahci and
> sata_sil24.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c        |    3 ++-
>  drivers/ata/libata-acpi.c |   10 +++++-----
>  drivers/ata/sata_sil24.c  |    3 ++-
>  include/linux/libata.h    |    1 +
>  4 files changed, 10 insertions(+), 7 deletions(-)

I don't think the situation is as static as a compiled-in driver flag 
implies.  And I'm not really convinced a driver flag is needed, or wanted.

If anything, the only flag we /may/ need could be a 
ATA_FLAG_NEVER_EVER_DO_ACPI_FOR_THIS_CONTROLLER.

	Jeff



