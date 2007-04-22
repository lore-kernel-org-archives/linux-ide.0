From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 07/13] libata-acpi: add ATA_FLAG_ACPI_SATA port flag
Date: Sun, 22 Apr 2007 19:03:57 +0100
Message-ID: <20070422190357.0fcae68b@the-village.bc.nu>
References: <11772636651400-git-send-email-htejun@gmail.com>
	<11772636662936-git-send-email-htejun@gmail.com>
	<20070422185351.12adf7d8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070422185351.12adf7d8@the-village.bc.nu>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> The ACPI interface to use can only be safely determined one way - and
> that is to see what methods the BIOS has attached to the device and use
> those.
> 
> Take the ACPI handle, go look for _GTF, _SDD etc and believe the
> firmware. Nothing else works.

Actually its even worse a mess than I thought 8(

We have to look at the BIOS method offered and we have to know if we
changed the mode of the controller.

If the BIOS mode of an IDE controller is SFF and we flip it into AHCI
mode then we can no longer use the BIOS provided methods because they are
the wrong ones.

For the sane cases (where we don't frob the device) we can ask the BIOS
what methods it has to guess what to use. If we change the mode of the
controller we need to look for methods that match our change, and be
aware we may have totally hosed the ACPI method support by changing the
chip config.

Bletch, ACPI, its like openprom crossed with european law, a million
times larger than needed, and full of holes.
