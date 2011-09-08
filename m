From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] achi, ata_generic: Add ASMedia ASM1061 support
Date: Thu, 8 Sep 2011 10:40:00 +0100
Message-ID: <20110908104000.53823901@lxorguk.ukuu.org.uk>
References: <1315453426-8796-1-git-send-email-kengyu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1315453426-8796-1-git-send-email-kengyu@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
To: Keng-Yu Lin <kengyu@canonical.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu,  8 Sep 2011 11:43:46 +0800
Keng-Yu Lin <kengyu@canonical.com> wrote:

> ASM1061 PCI-E to SATA bridge controller has two variants.
> One works under AHCI and the other works with ata_generic.

ata_generic should be an absolute last resort - it doesn't support error
recovery by speed dropping, mode setting, hotplug, timing tuning etc. 

Is there any documentation on the device or does it appear to follow the
usual mode setting behaviours ? The web page merely says

"Bus Master Programming Interface to IDE ATA Controller Rev. 1.0"

which covers only the basic transfers and not timing (ie ata_generic) as
you say but there are a few ways to find out more about how it works

- dump the PCI space in IDE mode and see if it looks like d1510r1 - some
  controllers are pretty unimaginative and so follow follow Appendix B
  of this document.

- see if it will run with the pata_acpi driver (ie it has _GTM and
  similar methods in the BIOS). If it does then this is preferable as it
  can do limited mode handling and you can also see what the ACPI code
  itself actually does for _GTM/_STM.

- See if Asmedia will provide documentation. I don't see anything useful
  on the English web site but perhaps someone has as Asmedia contact ?

The AHCI one looks good - AHCI standardises all this
stuff so the AHCI one can just be a device id.
