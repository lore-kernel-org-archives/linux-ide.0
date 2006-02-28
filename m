From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/13] ATA ACPI: do taskfile before mode commands
Date: Tue, 28 Feb 2006 12:57:15 +0100
Message-ID: <20060228115715.GE4081@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222140140.0d9e41b7.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40108 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751730AbWB1L7h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 06:59:37 -0500
Content-Disposition: inline
In-Reply-To: <20060222140140.0d9e41b7.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com

On St 22-02-06 14:01:40, Randy Dunlap wrote:
> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Do drive/taskfile-specific commands before setting the drive mode.
> This allows the taskfile to unlock the drive before trying to
> set the drive mode.
> 
> Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> ---
>  drivers/scsi/libata-core.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> --- linux-2616-rc4-ata.orig/drivers/scsi/libata-core.c
> +++ linux-2616-rc4-ata/drivers/scsi/libata-core.c
> @@ -4297,13 +4297,17 @@ static int ata_start_drive(struct ata_po
>   */
>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>  {
> +	printk(KERN_DEBUG "ata%d: resume device\n", ap->id);

Yep, one more helpful printk. Not. Actually this is four more of them
in this patch alone. Please remove your debugging code prior to merge.

								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
