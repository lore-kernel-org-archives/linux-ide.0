From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 09/13] libata-acpi: clean up ata_acpi_exec_tfs()
Date: Sat, 28 Apr 2007 15:00:20 -0400
Message-ID: <463399C4.80505@garzik.org>
References: <1177263666341-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53557 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964792AbXD1TA1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 15:00:27 -0400
In-Reply-To: <1177263666341-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch cleans up ata_acpi_exec_tfs() and its friends.
> 
> * Rename taskfile_array to ata_acpi_gtf and make it __packed as it's
>   used as argument to ACPI method, and use pointer to ata_acpi_gtf and
>   number of taskfiles to represent _GTF taskfiles instead of a pointer
>   casted into unsigned long and byte count.  This makes argument
>   re-checking in do_drive_set_taskfiles() unnecessary.
> 
> * Pointer in void * not in unsigned long.
> 
> * Clean up do_drive_get_GTF() error handling and make
>   do_drive_get_GTF() return number of taskfiles on success, 0 if _GTF
>   doesn't exist or doesn't contain valid ata.  -errno on other errors.
> 
> * Remove superflous check for acpi->buffer.pointer.
> 
> * Update taskfile_load_raw() such that printed messages look similar
>   to the messages printed by ata_eh_report().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-acpi.c |  219 ++++++++++++++++++++++-----------------------
>  1 files changed, 107 insertions(+), 112 deletions(-)

ACK

As an aside, I hate the "do_" prefix on functions.  It is utterly redundant.


