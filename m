From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 07/13] libata-acpi: add ATA_FLAG_ACPI_SATA port flag
Date: Sun, 22 Apr 2007 18:53:51 +0100
Message-ID: <20070422185351.12adf7d8@the-village.bc.nu>
References: <11772636651400-git-send-email-htejun@gmail.com>
	<11772636662936-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11772636662936-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 23 Apr 2007 02:41:06 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Whether a controller needs IDE or SATA ACPI hierarchy is determined by
> the programming interface of the controller not by whether the
> controller is SATA or PATA

NAK

I keep trying to point out that this is not true.

The ACPI interface to use can only be safely determined one way - and
that is to see what methods the BIOS has attached to the device and use
those.

Take the ACPI handle, go look for _GTF, _SDD etc and believe the
firmware. Nothing else works.

Alan
