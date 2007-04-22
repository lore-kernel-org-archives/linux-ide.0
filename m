From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 07/13] libata-acpi: add ATA_FLAG_ACPI_SATA port flag
Date: Sun, 22 Apr 2007 19:14:49 +0100
Message-ID: <20070422191449.726e0fb4@the-village.bc.nu>
References: <11772636651400-git-send-email-htejun@gmail.com>
	<11772636662936-git-send-email-htejun@gmail.com>
	<20070422185351.12adf7d8@the-village.bc.nu>
	<462BA35C.5040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <462BA35C.5040702@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> > Take the ACPI handle, go look for _GTF, _SDD etc and believe the
> > firmware. Nothing else works.
> 
> Actually, that's dangerous.  For example, you must not do _STM/_GTM on
> ahci becuase _STM/_GTM access PCI config registers which must not be
> accessed in achi modes and some BIOSen supply the same _STM/_GTM nodes
> whether the controller is in ata_piix mode or ahci mode.  Also, on ICH8,
> the association gets quite weird due to PCI device splitting.

You can end up with _SDD methods for SFF format controllers (or what we
think of as SFF format controllers) when we don't have the knowledge to
drive them in their full super-whizzo method (eg Marvell)

> The ACPI spec says the layout is dependent on controller interface and I
>  can see reasons why we need to follow that but not the other way
> around.  Do you have counter-examples?

The first problem is the words "the spec". 

Agreed that STM/GTM are not safe except when expected (and not always safe
when they are) but that ought to be ok as we then set all the modes
properly ourselves afterwards.

