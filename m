From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: SCSI to ATA translation fix
Date: Tue, 01 Feb 2005 22:26:08 -0500
Message-ID: <42004850.1090502@pobox.com>
References: <007101c5045b$b8ec0de0$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39814 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262294AbVBBD0a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Feb 2005 22:26:30 -0500
In-Reply-To: <007101c5045b$b8ec0de0$6401a8c0@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Hi Jeff,
> 
> Attached please find the patch against libata-2.6 for your review.
> 
> Changes:
>   #1. ata_scsi_rw_xlat():  
>     Fix  incorrect SCSI to ATA translation for 16 bytes SCSI Read/Write commands. 
>    (Already submitted in the previous patch. Merged with change #2 and resubmitted again.)
> 
>   #2. Fix ata_scsi_verify_xlat():
>     Fix incorrect tf->hob_lbax translation.

applied


