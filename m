From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 10/11] ide: make ide_cmd_ioctl() use TASKFILE
Date: Sun, 27 Feb 2005 15:53:48 +0900
Message-ID: <20050227065348.GB27728@htj.dyndns.org>
References: <20050210083808.48E9DD1A@htj.dyndns.org> <20050210083854.BD13DFBD@htj.dyndns.org> <58cb370e050224075040f5c031@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from wproxy.gmail.com ([64.233.184.195]:4407 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261358AbVB0Gxx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Feb 2005 01:53:53 -0500
Received: by wproxy.gmail.com with SMTP id 49so513317wri
        for <linux-ide@vger.kernel.org>; Sat, 26 Feb 2005 22:53:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <58cb370e050224075040f5c031@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

 Hello, Bartlomiej.

On Thu, Feb 24, 2005 at 04:50:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > +       in_valid->b.status_command      = 1;
> > +       in_valid->b.error_feature       = 1;
> > +       in_valid->b.nsector             = 1;
> 
> ide_end_drive_cmd() must be fixed first to respect ->tf_in_flags
> and it must be done *without* affecting HDIO_DRIVE_TASKFILE.

 Hmmm... does it make any difference other than reading more
registers?  Are you worried about performance impacts?  Is there
hardware which acts differently if more registers are read?

> 
> >  extern int ide_driveid_update(ide_drive_t *);
> > -extern int ide_ata66_check(ide_drive_t *, ide_task_t *);
> > +int ide_ata66_check(ide_drive_t *, ide_task_t *);
> >  extern int ide_config_drive_speed(ide_drive_t *, u8);
> >  extern u8 eighty_ninty_three (ide_drive_t *);
> > -extern int set_transfer(ide_drive_t *, ide_task_t *);
> > +int set_transfer(ide_drive_t *, ide_task_t *);
> >  extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);
> 
> leftovers from previous version of the patch

 Yeah, sorry.

 Thanks.

-- 
tejun

