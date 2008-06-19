From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] ide: endian annotations in ide-floppy.c
Date: Wed, 18 Jun 2008 17:01:29 -0700
Message-ID: <1213833689.2125.31.camel@brick>
References: <1213829856.2125.26.camel@brick>
	 <20080618233437.GO28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:3042 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553AbYFSABh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2008 20:01:37 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4887527rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 18 Jun 2008 17:01:34 -0700 (PDT)
In-Reply-To: <20080618233437.GO28946@ZenIV.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide <linux-ide@vger.kernel.org>

On Thu, 2008-06-19 at 00:34 +0100, Al Viro wrote:
> On Wed, Jun 18, 2008 at 03:57:35PM -0700, Harvey Harrison wrote:
> > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> > ---
> >  drivers/ide/ide-floppy.c |   16 ++++++++--------
> >  1 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> > index f05fbc2..cba39fa 100644
> > --- a/drivers/ide/ide-floppy.c
> > +++ b/drivers/ide/ide-floppy.c
> > @@ -921,10 +921,10 @@ static int ide_floppy_get_flexible_disk_page(ide_drive_t *drive)
> >  	set_disk_ro(floppy->disk, floppy->wp);
> >  	page = &pc.buf[8];
> >  
> > -	transfer_rate = be16_to_cpu(*(u16 *)&pc.buf[8 + 2]);
> > -	sector_size   = be16_to_cpu(*(u16 *)&pc.buf[8 + 6]);
> > -	cyls          = be16_to_cpu(*(u16 *)&pc.buf[8 + 8]);
> > -	rpm           = be16_to_cpu(*(u16 *)&pc.buf[8 + 28]);
> > +	transfer_rate = be16_to_cpup((__be16 *)&pc.buf[8 + 2]);
> > +	sector_size   = be16_to_cpup((__be16 *)&pc.buf[8 + 6]);
> > +	cyls          = be16_to_cpup((__be16 *)&pc.buf[8 + 8]);
> > +	rpm           = be16_to_cpup((__be16 *)&pc.buf[8 + 28]);
> 
> Pointless, IMO - just s/u16/__be16/ in the above.

The (admittedly) small reason I did it this way is that some arches do
have a more efficient pointer version.  Not that they use this code, but
in principle that's why I used the pointer version.

Cheers,

Harvey


