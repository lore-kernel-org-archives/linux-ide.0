From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add _GTM and _STM support to libata
Date: Mon, 26 Mar 2007 12:02:00 +0100
Message-ID: <20070326120200.2c5d5125@the-village.bc.nu>
References: <20070326032222.GA13113@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070326032222.GA13113@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com
List-Id: linux-ide@vger.kernel.org

> should they be attached to the scsi code rather than the ata host code? 
> Anyway, this fixes suspend/resume on nc6220, which is what I was aiming 
> for...
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

NAK - there is code to do the _gtm/_stm parts in the -mm tree already
used by pata_acpi, waiting to be merged and it's a lot cleaner. It does
want hooking to the suspend/resume paths as well as to pata_acpi but that
is all.

This code also has bugs

> +
> +	if (ap->cbl == ATA_CBL_SATA)
> +		return;

Bangs head against wall. As I keep saying you *CANNOT* do any PATA v SATA
decisions based upon cable type. It just doesn't work. The kernel
sometimes doesn't know. The hardware sometimes turns up in weird formats
with ATA bridges.

You *MUST* see if the device has GTF/GTM or SATA methods in its ACPI
space and decide based upon that alone what the BIOS thinks should be
used.

