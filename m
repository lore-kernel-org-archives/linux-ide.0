From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2] ahci: implement aggressive SATA device sleep support
Date: Thu, 23 Aug 2012 11:09:39 -0400
Message-ID: <503647B3.6050706@pobox.com>
References: <1345761072-2123-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61932 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab2HWPJo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Aug 2012 11:09:44 -0400
Received: by vbbff1 with SMTP id ff1so884578vbb.19
        for <linux-ide@vger.kernel.org>; Thu, 23 Aug 2012 08:09:43 -0700 (PDT)
In-Reply-To: <1345761072-2123-1-git-send-email-shane.huang@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <shane.huang@amd.com>
Cc: linux-ide@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On 08/23/2012 06:31 PM, Shane Huang wrote:
> This patch enables Aggressive Device Sleep only if both host controller
> and device support it.
[...]

> @@ -2323,6 +2324,26 @@ int ata_dev_configure(struct ata_device *dev)
>   			}
>   		}
>
> +		if (ata_id_has_devslp(dev->id)) {
> +			err_mask = ata_dev_set_feature(dev,
> +						       SETFEATURES_SATA_ENABLE,
> +						       SATA_DEVSLP);
> +			if (err_mask)
> +				ata_dev_err(dev,
> +					    "failed to enable DEVSLP (err_mask=0x%x)\n",
> +					    err_mask);
> +			else {
> +				dev->flags |= ATA_DFLAG_DEVSLP;
> +				err_mask = ata_read_log_page(dev,
> +						ATA_LOG_SATA_SETTINGS,
> +						dev->sata_settings,
> +						1);
> +				if (err_mask)
> +					ata_dev_warn(dev,
> +						     "failed to get Identify Device Data\n");
> +			}
> +		}
> +
>   		dev->cdb_len = 16;
>   	}
>

1) Contra the patch description (quoted above), you are enabling 
SATA_DEVSLP on the device regardless of power policy or host controller 
support.

I'm not sure about the ata_dev_configure() change.  If the power policy 
is not enabling aggressive sleep, we should not send this command to the 
device.

2) If we are going to unconditionally add ATA_SECT_SIZE bytes to every 
ata_device structure, let's at least move the ata_read_log_page() call 
outside of the devslp test, so that others may have this information 
even if the device does not support devslp.

3) please define constants in linux/ata.h for sata_settings information, 
rather than using hexidecimal constants ("magic numbers").

4) is it wise to issue SET_FEATURES / SATA_DEVSLP prior to programming 
the host controller?  that order seems wrong.

	Jeff





