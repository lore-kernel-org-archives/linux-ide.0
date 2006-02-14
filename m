From: David Greaves <david@dgreaves.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Tue, 14 Feb 2006 16:27:55 +0000
Message-ID: <43F2050B.8020006@dgreaves.com>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F1EE4A.3050107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:32385 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1161119AbWBNQ1v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Feb 2006 11:27:51 -0500
In-Reply-To: <43F1EE4A.3050107@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:

> Justin Piszcz wrote:
> ..
>
>>  ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>>  ata3: status=0x51 { DriveReady SeekComplete Error }
>>  ata3: error=0x04 { DriveStatusError }
>
>
> I wonder if the FUA logic is inserting cache-flush commands
> and perhaps the drive is rejecting those?
>
> Jeff, we really ought to be including the failed ATA opcode
> in those error messages!!
>
If such a thing were available as a patch then I too would apply it and
hopefully could provide useful feedback.

David
PS My problems:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113769509617034&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=113828551519727&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=113829573105369&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=113933732903205&w=2


