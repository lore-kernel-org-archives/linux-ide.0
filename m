From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_sil with seagate st3120026as
Date: Wed, 11 Aug 2004 15:34:39 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <411A74CF.7040502@pobox.com>
References: <LPEKIDCKCKICKJCIGCBLMEIACBAA.atkinss@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14769 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268053AbUHKTey
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Aug 2004 15:34:54 -0400
In-Reply-To: <LPEKIDCKCKICKJCIGCBLMEIACBAA.atkinss@shaw.ca>
List-Id: linux-ide@vger.kernel.org
To: Stephen Atkins <atkinss@shaw.ca>
Cc: linux-ide@vger.kernel.org

Stephen Atkins wrote:
> Hello.  I've been poking around in the sata_sil.c file because I saw a message
> at one time about the Seagate drives and how some of them need to be in the
> sil_blacklist.  Any way I've been trying to get this driver to work under the
> 2.6 kernel (it seems find in 2.4.26 but ivtv doesn't like that version).  Any
> way this is the error I received from the kernel when I was trying to access the
> drive.
> 
> ata1: DMA timeout 0x58 on port 0xE0851087
> scsi0: Error on channel 0, id 0, lun 0, CDB: 0x2a 00 0b bd a8 a4 00 04 00 00
> current sda: sense=70 3
> ASC= c ASCQ= 2
> Raw sense data: 0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00 0x0c
> 0x02
> end_request: I/O error, dev sda, sector 191735972


Most likely you need to update your BIOS, or boot with 'noapic', or boot 
with 'pci=noacpi', etc.

	Jeff


