From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: hdregs.h puts csfo at word 129 - wrong, that's vendor specific
Date: Sat, 26 Mar 2005 03:01:01 +0100
Message-ID: <58cb370e050325180159d5fbb1@mail.gmail.com>
References: <4243693F.9090008@yahoo.com> <42437F78.8090703@pobox.com>
	 <4244BF65.6070109@emc.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.201]:894 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261904AbVCZCBC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Mar 2005 21:01:02 -0500
Received: by wproxy.gmail.com with SMTP id 67so1606567wri
        for <linux-ide@vger.kernel.org>; Fri, 25 Mar 2005 18:01:02 -0800 (PST)
In-Reply-To: <4244BF65.6070109@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Chris Hann <chann94501@yahoo.com>, linux-ide list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Fri, 25 Mar 2005 20:48:21 -0500, Brett Russ <russb@emc.com> wrote:
> Jeff Garzik wrote:
> > Chris Hann wrote:
> >> ide-disk.c checks csfo bit 0 to see if the cache is available on a device
> >> hdregs.h maps csfo to word 129 of the Identify Device information
> >> the latest ATA documentation, e00159r3 Mandatory IDENTIFY DEVICE
> >> information, says words 129-159 are Vendor specific.
> >>
> >> Why is the driver switching on cache operations based on a word that
> >> has nothing to do with cache?
> >
> >
> > Good question...  I would guess that it's some pre-ATA4 legacy magic,
> > but that's just a guess.
> 
> I just checked the specs for ATA[134567] (didn't have 2) and all of them
> show word 129 as vendor specific, as Chris found.
> 
> The code that's in libata-dev shows in idedisk_setup():
> 
>          /* write cache enabled? */
>          if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
>                  drive->wcache = 1;
> 
> Bart, what's the point of the csfo bit check?  If it's specific to one
> non-ATA compliant device shouldn't it be testing something else along
> with that bit?

AFAIR it was Alan who added this code, so lets ask him :)

Alan?
