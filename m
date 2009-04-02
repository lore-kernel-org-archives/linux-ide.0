From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Subject: RE: LibATA SCSI WRITE_BUFFER to ATA DOWNLOAD_MICROCODE patch
Date: Thu, 2 Apr 2009 15:25:57 +0000
Message-ID: <0F5B06BAB751E047AB5C87D1F77A7788672E68F231@GVW0547EXC.americas.hpqcorp.net>
References: <20090401205115.GA32307@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:21279 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbZDBP0h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 11:26:37 -0400
In-Reply-To: <20090401205115.GA32307@beardog.cca.cpqcorp.net>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "salimmu@beardog.cca.cpqcorp.net" <salimmu@beardog.cca.cpqcorp.net>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "scameron@beardog.cca.cpqcorp.net" <scameron@beardog.cca.cpqcorp.net>, "Cameron, Steve" <Steve.Cameron@hp.com>, "Benesh, Scott" <scott.benesh@hp.com>

 

> -----Original Message-----
> From: salimmu@beardog.cca.cpqcorp.net 
> [mailto:salimmu@beardog.cca.cpqcorp.net] 
> Sent: Wednesday, April 01, 2009 3:51 PM
> To: linux-ide@vger.kernel.org
> Cc: jgarzik@pobox.com; scameron@beardog.cca.cpqcorp.net; 
> Miller, Mike (OS Dev); Cameron, Steve
> Subject: LibATA SCSI WRITE_BUFFER to ATA DOWNLOAD_MICROCODE patch
> 
> Attach is a patch that adds translation of scsi WRITE_BUFFER 

Never send patches as attachments. You're fortunate anyone bothered to look at it.
Always send patches inline from a mail client that does not munge up the test.

-- mikem


> to ATA_DOWNLOAD_MICROCODE command. This patch enables 
> firmware flashing of sata drives that are registered as scsi 
> devices under linux; hence scsi to ata translation is needed. 
> This patch provides the translation.
> 
> Imran Salim
> Hewlett Pacakrd Company
> Houston, TX
> (281) 514-1531
> 
> 