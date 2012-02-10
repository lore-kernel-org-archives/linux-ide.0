From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v8 01/13] libsas: close scsi_remove_target() vs libata-eh race
Date: Fri, 10 Feb 2012 11:09:17 -0800
Message-ID: <CABE8wwsDBE+bssuPcB=_PTotgoAin8QNys=aAU6pTbZ-YG5SKA@mail.gmail.com>
References: <20120210084411.25701.94502.stgit@dwillia2-linux.jf.intel.com>
	<20120210084444.25701.31139.stgit@dwillia2-linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga12.intel.com ([143.182.124.36]:51328 "EHLO
	azsmga102.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755209Ab2BJTJU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2012 14:09:20 -0500
In-Reply-To: <20120210084444.25701.31139.stgit@dwillia2-linux.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-scsi@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Marcin Tomczak <marcin.tomczak@intel.com>

On Fri, Feb 10, 2012 at 12:44 AM, Dan Williams <dan.j.williams@intel.co=
m> wrote:
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_=
ata.c
> index 37a9e73..852b1b1 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -661,6 +661,10 @@ static void async_sas_ata_eh(void *data, async_c=
ookie_t cookie)
> =A0 =A0 =A0 =A0struct ata_port *ap =3D dev->sata_dev.ap;
> =A0 =A0 =A0 =A0struct sas_ha_struct *ha =3D dev->port->ha;
>
> + =A0 =A0 =A0 /* hold a reference over eh since we may be racing with=
 final
> + =A0 =A0 =A0 =A0* remove once all commands are completed
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 kref_get(&dev->kref);
> =A0 =A0 =A0 =A0ata_port_printk(ap, KERN_DEBUG, "sas eh calling libata=
 port error handler");
> =A0 =A0 =A0 =A0ata_scsi_port_error_handler(ha->core.shost, ap);

The last rebase ate the matching call to "sas_put_device()" that needs
to be here.
