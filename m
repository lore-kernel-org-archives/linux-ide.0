From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix.c: check PCI sub-class code before AHCI disabling
Date: Thu, 28 Jul 2005 15:56:27 -0400
Message-ID: <42E9386B.7040108@pobox.com>
References: <e16ac85e050304160467045421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261645AbVG1UEa@vger.kernel.org>
In-Reply-To: <e16ac85e050304160467045421@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Felix <gregfelixlkml@gmail.com>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Greg Felix wrote:
> This patch adds functionality to check the PCI sub-class code of an
> AHCI capable device before disabling AHCI.  It fixes a bug where an
> ICH7 sata controller is being setup by the BIOS as sub-class 1 (ide)
> and the AHCI control registers weren't being initialized, thus causing
> an IO error in piix_disable_ahci().
> 
> Thanks,
> Greg Felix
> 
> 
> Signed-off-by: Gregory Felix <greg.felix@gmail.com>

Applied to 2.6.x, and uploads to 'upstream' branch of libata-dev.git.

Will apply to 2.4.x as soon as Marcelo pulls what I just submitted.

	Jeff
