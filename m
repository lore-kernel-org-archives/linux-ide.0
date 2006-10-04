From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.4.33 ata_piix patch for Intel 82801GBM/GHM (ICH7) SATA
Date: Wed, 04 Oct 2006 12:23:49 -0400
Message-ID: <4523E015.7090001@garzik.org>
References: <Pine.GSO.4.64.0610041644010.9352@holyrood.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:64177 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161553AbWJDQXy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Oct 2006 12:23:54 -0400
In-Reply-To: <Pine.GSO.4.64.0610041644010.9352@holyrood.ed.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "James E. Jarvis" <jjarvis@staffmail.ed.ac.uk>
Cc: linux-ide@vger.kernel.org

James E. Jarvis wrote:
> This patch needs testing. I do not have access (other than intermittent 
> ssh access) to a Fujitsu Siemens Pi 1505 laptop running 2.4.33 Linux 
> Kernel.
> 
> The following is a patch for the Intel Corporation 82801GBM/GHM (ICH7 
> Family) Serial ATA Storage Controllers cc=AHCI (rev 02)
> pc id = 8086:27c5 in the Linux 2.4.33 kernel
> 
> --- drivers/scsi/ata_piix.c~    Fri Aug 11 05:18:20 2006
> +++ drivers/scsi/ata_piix.c     Wed Oct  4 16:11:36 2006
> @@ -115,6 +115,7 @@
>         { 0x8086, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_rm },
>         { 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
>         { 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },
> +       { 0x8086, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7_sata },

Use the AHCI driver, as the above lspci output indicates...

	Jeff



