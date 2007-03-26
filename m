From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add _GTM and _STM support to libata
Date: Mon, 26 Mar 2007 22:40:06 +0100
Message-ID: <20070326224006.2e9b1cdb@the-village.bc.nu>
References: <20070326032222.GA13113@srcf.ucam.org>
	<20070326115807.0c89ee21@the-village.bc.nu>
	<20070326201514.GA27284@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070326201514.GA27284@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com
List-Id: linux-ide@vger.kernel.org

> Ok, missed that. How about something like the following? I've changed 
> some of the interfaces slightly, so the pata_acpi driver would need to 
> be altered to match. This gets rid of the CABLE_SATA checking in 

Close but no cigar. The pata_acpi driver needs to be able to pass its own
pointer for gtf as it wants to keep multiple states to hand.


>  	acpi_status status;
>  	struct acpi_buffer output;
>  
> +	if (!ap->acpi_port_link || !ap->acpi_port_link->is_pata)
> +		return -ENODEV;

Make ap->acpi_port_link a local variable and it is easier to read and
smaller and faster, need to pass the struct to gtm/stm from the caller -
easily pushed up a layer.


> -int ata_acpi_stm(const struct ata_port *ap, void *handle, struct acpi_gtm *stm)
> +int ata_acpi_stm(const struct ata_port *ap)

Ditto 

Otherwise looks good.

