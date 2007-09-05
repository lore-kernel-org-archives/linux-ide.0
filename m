From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Stardom SATA HSM violation
Date: Wed, 5 Sep 2007 12:38:51 -0700
Message-ID: <20070905123851.a89b24b6.akpm@linux-foundation.org>
References: <46CFA08E.6090604@arbores.ca>
	<6bffcb0e0708261610g10d9c59ck5789fac6feca9f42@mail.gmail.com>
	<46DBCB6C.8080206@gmail.com>
	<20070905095327.6277d054.akpm@linux-foundation.org>
	<46DEE617.4050004@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53620 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932087AbXIETkH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 15:40:07 -0400
In-Reply-To: <46DEE617.4050004@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: htejun@gmail.com, michal.k.k.piotrowski@gmail.com, bryan@arbores.ca, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> On Wed, 05 Sep 2007 13:23:35 -0400 Mark Lord <liml@rtr.ca> wrote:
> Andrew Morton wrote:
> >> please try 2.6.22.5.  Even if it doesn't fix the problem, it would
> >> report error conditions better.
> > 
> > Presumably in the week and a half between Bryan's report and your request,
> > Bryan has gone off and got an adaptec card.  Bryan, it would be helpful if
> > you could rebuild the original systam and help us get to the bottom of this
> > bug, thanks.
> 
> I reported a very similar bug back a few releases ago.
> Anyone who wants to try it themselves, can do this with hdparm-7.7 (from sourceforge):
> 
>     hdparm --drq-hsm-error /dev/sda
> 
> Whether or not it hangs the machine does depend upon exactly which SATA LLD is used,
> and what model/revision of drive is installed.  But if it hangs for you (eg. Tejun),
> then you now have a way to reproduce a HSM error "on demand" for testing.  :)
> 

Hey, we just found something which doesn't crash my Vaio!

sony:/home/akpm/hdparm-7.7> 0 ./hdparm --drq-hsm-error /dev/sda

/dev/sda:
 triggering "stuck DRQ" host state machine error
do_drq_hsm_error: Success
ata status=0x58 ata error=0x00


ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ec/00:00:00:00:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 0 
         res 58/00:01:00:00:00/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata3: soft resetting port
ata3.00: configured for UDMA/100
ata3: EH complete
sd 2:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA


How dull. (ata_piix)
