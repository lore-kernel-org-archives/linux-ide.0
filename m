From: Mark Lord <lkml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Tue, 14 Feb 2006 09:50:50 -0500
Message-ID: <43F1EE4A.3050107@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:42436 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161045AbWBNOux (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Feb 2006 09:50:53 -0500
In-Reply-To: <Pine.LNX.4.64.0602140439580.3567@p34>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Justin Piszcz wrote:
..
>  ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>  ata3: status=0x51 { DriveReady SeekComplete Error }
>  ata3: error=0x04 { DriveStatusError }

I wonder if the FUA logic is inserting cache-flush commands
and perhaps the drive is rejecting those?

Jeff, we really ought to be including the failed ATA opcode
in those error messages!!

Cheers
