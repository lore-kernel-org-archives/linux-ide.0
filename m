From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/12] libata: implement standard powersave methods
Date: Wed, 19 Jul 2006 15:50:12 -0400
Message-ID: <44BE8CF4.2010006@pobox.com>
References: <11531191524049-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:64649 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030253AbWGSTuU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jul 2006 15:50:20 -0400
In-Reply-To: <11531191524049-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement helpers to build SATA ->set_powersave() and HIPS timer, and
> use them to implement sata_std_set_powersave() and
> sata_std_hips_timer_fn() for standard SATA link powersave using
> SControl register.
> 
> Depending on controller capability, the following modes are supported.
> 
> none:		no powersave
> HIPS:		host-initiated partial/slumber (both or either one)
> DIPS:		device-initiated partial/slumber (both or either one)
> static:		link off by writing 0x4 to DET
> HIPS/static:	HIPS + static
> DIPS/static;	DIPS + static
> 
> Timeouts for HIPS can be modified using module parameters -
> libata.partial_timeout and libata.slumber_timeout.  Setting timeout to
> zero disables the powersave mode.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |  280 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/libata.h     |   10 ++
>  2 files changed, 290 insertions(+), 0 deletions(-)
> 
> e19c560ab7e8fa9b20ed5ec3233fb75e0daceb63
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 1658cd1..9890387 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -71,6 +71,7 @@ static unsigned int ata_dev_set_xfermode
>  static void ata_dev_xfermask(struct ata_device *dev);
>  
>  static int ata_param_set_powersave(const char *val, struct kernel_param *kp);
> +static int ata_param_set_hips_timeout(const char *val, struct kernel_param *kp);
>  
>  static DEFINE_MUTEX(ata_all_ports_mutex);
>  static LIST_HEAD(ata_all_ports);
> @@ -102,6 +103,18 @@ module_param_call(powersave, ata_param_s
>  MODULE_PARM_DESC(powersave, "Powersave mode (0=none, 1=HIPS, 2=DIPS, "
>  		 "3=static, 4=HIPS/static, 5=DIPS/static)");
>  
> +static unsigned long libata_partial_timeout = 100;
> +module_param_call(partial_timeout, ata_param_set_hips_timeout, param_get_ulong,
> +		  &libata_partial_timeout, 0644);
> +MODULE_PARM_DESC(hips_timeout, "Host-initiated partial powersave timeout "
> +		 "(milliseconds, default 100, 0 to disable)");
> +
> +static unsigned long libata_slumber_timeout = 3000;
> +module_param_call(slumber_timeout, ata_param_set_hips_timeout, param_get_ulong,
> +		  &libata_slumber_timeout, 0644);
> +MODULE_PARM_DESC(slumber_timeout, "Host-initiated slumber powersave timeout "
> +		 "(milliseconds, default 3000, 0 to disable)");
> +

Should be a per-controller variable, not a global libata module parm.

So NAK on interface, ACK on implementation behind the interface.

	Jeff


