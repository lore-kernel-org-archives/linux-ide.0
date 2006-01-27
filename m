From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] documentation typo
Date: Fri, 27 Jan 2006 01:36:09 +0100
Message-ID: <58cb370e0601261636t446cceb5i4f7b32397a45b9be@mail.gmail.com>
References: <20060105132014.d72f61db.diegocg@gmail.com>
	 <58cb370e0601050643q3147cfc8g46e3d17990b196a8@mail.gmail.com>
	 <20060113171057.3541db55.diegocg@gmail.com>
	 <58cb370e0601130817i5f65c93fx469a49259b86d592@mail.gmail.com>
	 <20060115232403.a8f970d1.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.205]:61779 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030249AbWA0AgL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jan 2006 19:36:11 -0500
Received: by nproxy.gmail.com with SMTP id l35so230874nfa
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 16:36:10 -0800 (PST)
In-Reply-To: <20060115232403.a8f970d1.diegocg@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi,

On 1/15/06, Diego Calleja <diegocg@gmail.com> wrote:
> El Fri, 13 Jan 2006 17:17:33 +0100,
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> escribi=F3:
>
> > Well, examples are fine but some explanation would be needed.
> > I'll wait for revised version (please also add that you need
> > CONFIG_HOTPLUG=3Dy for using sysfs interface - this is due
> > one of the recent changes in the kernel driver core).
>
> Of, this is not 100% perfect but it's much better:
>
> - I added a CONFIG_HOTPLUG dependeny for ide-scsi. If the sysfs inter=
face
>   is the Right Way of doing it and the boot parameters are going to b=
e
>   removed some day, it has sense no?

Hmm, ide-scsi works just fine without CONFIG_HOTPLUG.

IMO "select CONFIG_HOTPLUG" is better but I think that we can
drop CONFIG_HOTPLUG dependency entirely and see if anybody
complains during transition period (unlikely).

> - I "deprecated" the boot parameters by adding a printk and a entry t=
o
>   feature-removal-schedule.txt. I don't know if this is what you want
>   but I though it was the right thing

Cool.

> --- test.orig/drivers/ide/ide.c 2006-01-13 02:40:44.000000000 +0100
> +++ test/drivers/ide/ide.c      2006-01-15 22:00:14.000000000 +0100
> @@ -1554,6 +1554,9 @@
>                 hwif =3D &ide_hwifs[hw];
>                 drive =3D &hwif->drives[unit];
>                 if (strncmp(s + 4, "ide-", 4) =3D=3D 0) {
> +                       printk("hd%c: \"hdx=3Dide-scsi\" boot paramet=
er has been
> +                           obsoleted by a better mechanism and may b=
e removed
> +                           in the future, check Documentation/ide.tx=
t\n", unit);

please add KERN_WARNING

>                         strlcpy(drive->driver_req, s + 4, sizeof(driv=
e->driver_req));
>                         goto done;
>                 }
> @@ -1593,6 +1596,10 @@
>                                 drive->sect0 =3D 63;
>                                 goto done;
>                         case -14: /* "scsi" */
> +                               printk("hd%c: \"hdx=3Dscsi\" boot par=
ameter has
> +                                   been obsoleted by a better mechan=
ism and may
> +                                   be removed in the future, check
> +                                   Documentation/ide.txt\n", unit);

ditto

Rest of the patch is perfectly fine.

Thanks and sorry for the delay,
Bartlomiej
