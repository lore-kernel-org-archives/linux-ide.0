From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 46/64] ide: add drive->pio_mode field
Date: Tue, 19 Jan 2010 16:09:46 +0100
Message-ID: <201001191609.46434.bzolnier@gmail.com>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118172028.14623.55296.sendpatchset@localhost> <4B54B656.2090307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754139Ab0ASPL5@vger.kernel.org>
In-Reply-To: <4B54B656.2090307@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 18 January 2010 08:28:22 pm Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: add drive->pio_mode field
> >
> > Add pio_mode field to ide_drive_t matching pio_mode field used in
> > struct ata_device.
> >
> > The validity of the field is restricted to ->set_pio_mode method
> > only currently in IDE subsystem.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-devsets.c   |    2 ++
> >  drivers/ide/ide-probe.c     |    2 ++
> >  drivers/ide/ide-xfer-mode.c |    3 +++
> >  include/linux/ide.h         |    1 +
> >  4 files changed, 8 insertions(+)
> >
> > Index: b/drivers/ide/ide-devsets.c
> > ===================================================================
> > --- a/drivers/ide/ide-devsets.c
> > +++ b/drivers/ide/ide-devsets.c
> > @@ -105,6 +105,8 @@ static int set_pio_mode(ide_drive_t *dri
> >  		return -ENOSYS;
> >  
> >  	if (set_pio_mode_abuse(drive->hwif, arg)) {
> > +		drive->pio_mode = arg + XFER_PIO_0;
> > +
> >   
> 
>    Er, didn't understand this... these 'arg' values are not really PIO 
> modes, no?

In the usual case they are and a few 'special' ->set_pio_mode implementations
will extract the desired 'arg' value just fine by doing '- XFER_PIO_0'..

--
Bartlomiej Zolnierkiewicz
