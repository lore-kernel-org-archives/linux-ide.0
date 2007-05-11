From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 03/11] libata-acpi: s/CONFIG_SATA_ACPI/CONFIG_ATA_ACPI/
Date: Fri, 11 May 2007 18:13:04 -0400
Message-ID: <4644EA70.9020700@garzik.org>
References: <11783766382010-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11783766382010-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ACPI applies to both SATA and PATA.  Drop the 'S' from the config
> variable.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/Kconfig    |   26 +++++++++++++-------------
>  drivers/ata/Makefile   |    2 +-
>  drivers/ata/libata.h   |    2 +-
>  include/linux/libata.h |    2 +-
>  4 files changed, 16 insertions(+), 16 deletions(-)

applied 3-4

the code has been stirred, so I request resend of the other patches


