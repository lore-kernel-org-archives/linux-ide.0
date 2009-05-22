From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] ide: respect quirk_drives[] list on all controllers
Date: Fri, 22 May 2009 20:59:07 +0200
Message-ID: <200905222059.08161.bzolnier@gmail.com>
References: <200905201734.42093.bzolnier@gmail.com> <4A15A7DD.1040300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757006AbZEVTBQ@vger.kernel.org>
In-Reply-To: <4A15A7DD.1040300@ru.mvista.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 21 May 2009 21:13:33 Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Add ide_check_nien_quirk_list() helper to the core code
> >   and then use it in ide_port_tune_devices().
> 
> > * Remove no longer needed ->quirkproc methods from hpt366.c
> >   and pdc202xx_{new,old}.c.
> 
>     Haha, I remembered about that idea of yours and was thinking of 
> undertaking its implementation just yesterday. You've beten me to it. :-)

Sigh, if I knew I would concentrate on other things...

I did it only because there is outstanding ide-pmac bugreport probably
related to one of these quirky drives...

> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > Index: b/drivers/ide/ide-iops.c
> > ===================================================================
> > --- a/drivers/ide/ide-iops.c
> > +++ b/drivers/ide/ide-iops.c
> > @@ -269,6 +269,31 @@ no_80w:
> >  	return 0;
> >  }
> >  
> > +static const char *nien_quirk_list[] = {
> > +	"QUANTUM FIREBALLlct08 08",
> > +	"QUANTUM FIREBALLP KA6.4",
> > +	"QUANTUM FIREBALLP KA9.1",
> > +	"QUANTUM FIREBALLP KX13.6",
> > +	"QUANTUM FIREBALLP KX20.5",
> > +	"QUANTUM FIREBALLP KX27.3",
> > +	"QUANTUM FIREBALLP LM20.4",
> > +	"QUANTUM FIREBALLP LM20.5",
> > +	NULL
> > +};
> > +
> > +void ide_check_nien_quirk_list(ide_drive_t *drive)
> 
>     Why not reuse ide_in_drive_list()?

Should have been in patch #5/4 but I ran out of time, I will do it later
unless you would like to handle it...
