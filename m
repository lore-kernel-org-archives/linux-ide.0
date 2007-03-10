From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata-acpi: allow _GTF on SATA, but disable on PATA for now
Date: Sat, 10 Mar 2007 06:30:01 -0500
Message-ID: <45F296B9.7000005@garzik.org>
References: <200703100559.l2A5x6kP017578@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36123 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766669AbXCJLaE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Mar 2007 06:30:04 -0500
In-Reply-To: <200703100559.l2A5x6kP017578@hera.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kristen.c.accardi@intel.com, len.brown@intel.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=df33c77e3981e71afc8727ee5c432ba1a1bba68c
> Commit:     df33c77e3981e71afc8727ee5c432ba1a1bba68c
> Parent:     908e0a8a265fe8057604a9a30aec3f0be7bb5ebb
> Author:     Kristen Accardi <kristen.c.accardi@intel.com>
> AuthorDate: Fri Mar 9 18:15:33 2007 -0500
> Committer:  Len Brown <len.brown@intel.com>
> CommitDate: Fri Mar 9 18:15:33 2007 -0500
> 
>     libata-acpi: allow _GTF on SATA, but disable on PATA for now
>     
>     The ACPI specification states, and BIOS implementations depend on,
>     _STM being called before _GTF.
>     
>     SATA does this, but PATA does not.  So for now, simply
>     prevent execution of _GTF on PATA devices.  Longer term we
>     should implement ACPI support for PATA devices in libata.
>     
>     Signed-off-by: Kristen Accardi <kristen.c.accardi@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/ata/libata-acpi.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index d14a48e..89aaf74 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -561,6 +561,13 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
>  
>  	if (noacpi)
>  		return 0;
> +	/*
> +	 * TBD - implement PATA support.  For now,
> +	 * we should not run GTF on PATA devices since some
> +	 * PATA require execution of GTM/STM before GTF.
> +	 */
> +	if (!(ap->cbl == ATA_CBL_SATA))
> +		return 0;
>  
>  	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
>  		if (!ata_dev_enabled(&ap->device[ix]))

Grumble!

This /really/ should have gone through me and linux-ide first.

Alan has been actively working on PATA ACPI, and we have been debugging 
ACPI issues as well.  PLEASE coordinate with the maintainer, when 
touching code outside of drivers/acpi!

AFAICS this patch went in with zero appearance on LKML or another 
related list, until submission.  This is /not/ how we do Linux development.

	Jeff


