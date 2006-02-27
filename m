From: Mark Lord <liml@rtr.ca>
Subject: Re: Kernel SeekCompleteErrors... Different from Re: LibPATA code
 issues / 2.6.15.4
Date: Mon, 27 Feb 2006 08:40:08 -0500
Message-ID: <44030138.4000203@rtr.ca>
References: <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>	 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>	 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca>	 <44019E96.20804@superbug.co.uk> <4401B378.3030005@rtr.ca>	 <4401BB85.7070407@superbug.co.uk> <4401DF6B.9010409@rtr.ca>	 <20060226171307.GA9682@gallifrey>	 <1140975791.27539.19.camel@localhost.localdomain> <44021141.6000601@rtr.ca> <1141040889.27539.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:6347 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751157AbWB0Nka (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Feb 2006 08:40:30 -0500
In-Reply-To: <1141040889.27539.60.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, James Courtier-Dutton <James@superbug.co.uk>, David Greaves <david@dgreaves.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com

Alan Cox wrote:
> On Sul, 2006-02-26 at 15:36 -0500, Mark Lord wrote:
>> It still is unreliable, as being discussed in another thread.
>>
>> libata wrongly says "medium error" any time it issues a command
>> that the drive rejects (unsupported, invalid parameters, etc..).
> 
> It seems to still get a single case wrong. But it does the report the
> ATA state correctly still.
> 
>> This is biting a few people in 2.6.16-rc*, due to the FUA stuff.
> 
> It is driven by a table in 
> 
> libata-scsi.c:ata_to_sense_error()
> 
> so if you can figure out the wrong entry and tweak the table that would be great

It's the fall-through case, where the table is not used.


         /* No error?  Undecoded? */
         printk(KERN_WARNING "ata%u: no sense translation for op=0x%02x status: 0x%02x\n",
                id, opcode, drv_stat);

         /* For our last chance pick, use medium read error because
          * it's much more common than an ATA drive telling you a write
          * has failed.
          */
         *sk = MEDIUM_ERROR;
         *asc = 0x11; /* "unrecovered read error" */
         *ascq = 0x04; /*  "auto-reallocation failed" */

Cheers
