From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Wed, 29 Sep 2004 14:32:27 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <415AFFBB.8090503@pobox.com>
References: <20040928001633.A8363@florence.linkmargin.com> <415AFF27.7080906@tteng.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55963 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268778AbUI2Sco
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Sep 2004 14:32:44 -0400
In-Reply-To: <415AFF27.7080906@tteng.com.br>
List-Id: linux-ide@vger.kernel.org
To: "Luciano A. Stertz" <luciano@tteng.com.br>
Cc: linux-ide@vger.kernel.org

Luciano A. Stertz wrote:
> 
>     Just trying to understand the SATA SMART problem as a whole. With 
> your patch, it's possible to send ATA commands that are encapsulated in 
> CDBs, right? If so, to enable sending direct ATA commands to a SATA 
> device, one has to create a ioctl that receives the command and creates 
> a CDB from it, as John Linville did a few weeks ago. This way a 
> user-space application (e.g. smartmontools) can use this ioctl to send 
> ATA commands. Am I right?

No.  SCSI "send CDB" ioctls have existed for years.

The ioctls John added are merely for compatibility with existing IDE 
utilities.


>     If I understand it correctly, the kernel receives an ATA command, 
> creates a CDB, gets the ATA command from the CDB and issues it.
>     It's a nice workaround, but user space software will still have to 
> be aware that the target device appears as SCSI but isn't in fact a SCSI 
> device... I guess that the ideal situation would be:

The SAT INQUIRY draft follows the standard that I (libata) set:  the 
vendor id is "ATA".

	Jeff


