From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add _GTM and _STM support to libata
Date: Tue, 27 Mar 2007 00:39:06 +0100
Message-ID: <20070327003906.457e179c@the-village.bc.nu>
References: <20070326032222.GA13113@srcf.ucam.org>
	<20070326115807.0c89ee21@the-village.bc.nu>
	<20070326201514.GA27284@srcf.ucam.org>
	<20070326224006.2e9b1cdb@the-village.bc.nu>
	<20070326214800.GA29268@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33160 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933585AbXCZWgD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Mar 2007 18:36:03 -0400
In-Reply-To: <20070326214800.GA29268@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com

On Mon, 26 Mar 2007 22:48:00 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> Ok. How about this? Couple of cleanups, and leaves the possibility for 
> drivers to pass in their own gtf structure.

Looks better, I can work with that for pata_acpi nicely


> +	acpidata = kzalloc(sizeof(struct ata_acpi_port_link), GFP_KERNEL);
> +	acpidata->is_pata = pata;

Out of memory -> NULL - > OOps *bang*


Looks ok but for the memory handling now
