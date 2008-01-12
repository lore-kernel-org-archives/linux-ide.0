From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 06/21] ide-floppy: remove struct idefloppy_flexible_disk_page
Date: Sat, 12 Jan 2008 22:32:48 +0100
Message-ID: <200801122232.48382.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <200801120158.57895.bzolnier@gmail.com> <20080112203848.GA31954@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:21597 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756597AbYALVV0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 16:21:26 -0500
Received: by ug-out-1314.google.com with SMTP id z38so645695ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 13:21:25 -0800 (PST)
In-Reply-To: <20080112203848.GA31954@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbpetkov@yahoo.de
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Saturday 12 January 2008, Borislav Petkov wrote:

[...]

> > >  	set_disk_ro(floppy->disk, floppy->wp);
> > > -	page = (idefloppy_flexible_disk_page_t *) (header + 1);
> > > -
> > > -	page->transfer_rate = be16_to_cpu(page->transfer_rate);
> > > -	page->sector_size = be16_to_cpu(page->sector_size);
> > > -	page->cyls = be16_to_cpu(page->cyls);
> > > -	page->rpm = be16_to_cpu(page->rpm);
> > > -	capacity = page->cyls * page->heads * page->sectors * page->sector_size;
> > > -	if (memcmp (page, &floppy->flexible_disk_page, sizeof (idefloppy_flexible_disk_page_t)))
> > > +
> > > +	transfer_rate = be16_to_cpu(*(u16 *)&pc.buffer[8 + 2]);
> > > +	sector_size   = be16_to_cpu(*(u16 *)&pc.buffer[8 + 6]);
> > > +	cyls          = be16_to_cpu(*(u16 *)&pc.buffer[8 + 8]);
> > > +	rpm           = be16_to_cpu(*(u16 *)&pc.buffer[8 + 28]);
> > > +	heads         = pc.buffer[8 + 4];
> > > +	sectors       = pc.buffer[8 + 5];
> > > +
> > > +	capacity = cyls * heads * sectors * sector_size;
> > > +
> > > +	if ((1UL << IDEFLOPPY_MEDIA_CHANGED) & floppy->flags)
> > 
> > IDEFLOPPY_MEDIA_CHANGED is set when block device is opened for the first
> > time (please check idefloppy_open() for details) so I don't think it is
> > the right change.  'Flexible Disk Page' is only 32 bytes so we are better
> > off with leaving 'u8 flexible_disk_page[32]' in idefloppy_floppy_t and
> > doing things the old way.
> > 
> > Besides please do not intermix real changes like the above one with purely
> > cleanup ones like idefloppy_flexible_disk_page_t removal.  This is bad from
> > maintainability point of view.  If some patch causes problems it is easier
> > to narrow it down by heaving purely cleanup changes separated out + if we
> > would need to revert the real change we would have to make a separate patch
> > doing it instead of just reverting the guilty commit (given that we don't
> > want cleanup changes to be reverted as well).
> 
> How about we get rid of that chunk altogether? floppy->flexible_disk_page is
> used only here for the purpose of printk-ing to the syslog and has no "real"
> purpose otherwise. Do we need that info spewed into the syslog at all?

Well, it has some debugging value since drive's capabilities are given in
'Flexible Disk Page' but fine with me given that this change is separated
out from idefloppy_flexible_disk_page_t removal and pushed at the end of
patch series.

Thanks,
Bart
