From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: endian annotations in ide-floppy.c
Date: Thu, 19 Jun 2008 21:49:05 +0200
Message-ID: <200806192149.06139.bzolnier@gmail.com>
References: <1213829856.2125.26.camel@brick> <20080618233437.GO28946@ZenIV.linux.org.uk> <1213833689.2125.31.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:54273 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbYFSUqY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jun 2008 16:46:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so212852and.103
        for <linux-ide@vger.kernel.org>; Thu, 19 Jun 2008 13:46:21 -0700 (PDT)
In-Reply-To: <1213833689.2125.31.camel@brick>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-ide <linux-ide@vger.kernel.org>, Borislav Petkov <petkovbb@googlemail.com>

On Thursday 19 June 2008, Harvey Harrison wrote:
> On Thu, 2008-06-19 at 00:34 +0100, Al Viro wrote:
> > On Wed, Jun 18, 2008 at 03:57:35PM -0700, Harvey Harrison wrote:
> > > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> > > ---
> > >  drivers/ide/ide-floppy.c |   16 ++++++++--------
> > >  1 files changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> > > index f05fbc2..cba39fa 100644
> > > --- a/drivers/ide/ide-floppy.c
> > > +++ b/drivers/ide/ide-floppy.c
> > > @@ -921,10 +921,10 @@ static int ide_floppy_get_flexible_disk_page(ide_drive_t *drive)
> > >  	set_disk_ro(floppy->disk, floppy->wp);
> > >  	page = &pc.buf[8];
> > >  
> > > -	transfer_rate = be16_to_cpu(*(u16 *)&pc.buf[8 + 2]);
> > > -	sector_size   = be16_to_cpu(*(u16 *)&pc.buf[8 + 6]);
> > > -	cyls          = be16_to_cpu(*(u16 *)&pc.buf[8 + 8]);
> > > -	rpm           = be16_to_cpu(*(u16 *)&pc.buf[8 + 28]);
> > > +	transfer_rate = be16_to_cpup((__be16 *)&pc.buf[8 + 2]);
> > > +	sector_size   = be16_to_cpup((__be16 *)&pc.buf[8 + 6]);
> > > +	cyls          = be16_to_cpup((__be16 *)&pc.buf[8 + 8]);
> > > +	rpm           = be16_to_cpup((__be16 *)&pc.buf[8 + 28]);
> > 
> > Pointless, IMO - just s/u16/__be16/ in the above.
> 
> The (admittedly) small reason I did it this way is that some arches do
> have a more efficient pointer version.  Not that they use this code, but
> in principle that's why I used the pointer version.

this indeed seems to result in (tiny) improvement on x86-32:

   text    data     bss     dec     hex filename
   7377     196       0    7573    1d95 drivers/ide/ide-floppy.o.before
   7370     196       0    7566    1d8e drivers/ide/ide-floppy.o.after

thus I applied it as it is
