From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata crashes on incorrectly initialised ports
Date: Mon, 13 Mar 2006 04:26:03 -0500
Message-ID: <44153AAB.1000201@garzik.org>
References: <44153810.10702@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:31205 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932373AbWCMJ0G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Mar 2006 04:26:06 -0500
In-Reply-To: <44153810.10702@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-ide@vger.kernel.org

Hannes Reinecke wrote:
> Hi all,
> 
> Randy found an interesting usage of the label 'err_out' in
> libata-core.c:ata_device_add().
> 
> 'err_out' is meant to be called to teardown existing sysfs entries.
> As such is it clearly wrong to call it if the sysfs registration fails.
> 
> Please apply.
> 
> Cheers,
> 
> Hannes
> 
> 
> ------------------------------------------------------------------------
> 
> From: Hannes Reinecke <hare@suse.de>
> Subject: libata crashes on incorrectly initialized ports
> 
> Randy Dunlap noted:
> With the update ahci I am getting these messages (typed by
> me, no serial port for console), but ata2 drive is not present (!?):
> 
> ata2: could not start DMA engine
> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
> 
> plus a Call Trace like so (names only transcribed here):
> class_device_del
> class_device_unregister
> scsi_remove_host
> ata_host_remove
> ata_device_add
> ahci_init_one
> ... normal pci driver init/register functions ...
> 
> 
> The label 'err_out' is used twice; the first usage of which is wrong
> as there is not host registered in sysfs which we could deregister.
> In fact, we haven't done anything (yet) so we might as well return
> here.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index ab3257a..42e5c40 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -4578,7 +4578,7 @@ int ata_device_add(const struct ata_prob
>  
>  		ap = ata_host_add(ent, host_set, i);
>  		if (!ap)
> -			goto err_out;
> +			return 0;

NAK: This patch adds memory leaks.

The clear intent of the error handling was to clean up host_set and the 
ports allocated so far.  'return 0' just leaks all that stuff, rather 
than performing the incorrect error handling ;-)

AFAICT, all the error handling at the err_out label is correct, save for 
one detail:  do_unregister argument passed to ata_host_remove() should 
be zero for the err_out callsite we are discussing.

	Jeff


