From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] documentation typo
Date: Fri, 13 Jan 2006 17:17:33 +0100
Message-ID: <58cb370e0601130817i5f65c93fx469a49259b86d592@mail.gmail.com>
References: <20060105132014.d72f61db.diegocg@gmail.com>
	 <58cb370e0601050643q3147cfc8g46e3d17990b196a8@mail.gmail.com>
	 <20060113171057.3541db55.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.205]:53483 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965012AbWAMQRf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jan 2006 11:17:35 -0500
Received: by uproxy.gmail.com with SMTP id s2so43283uge
        for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2006 08:17:33 -0800 (PST)
In-Reply-To: <20060113171057.3541db55.diegocg@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-ide@vger.kernel.org

On 1/13/06, Diego Calleja <diegocg@gmail.com> wrote:
> El Thu, 5 Jan 2006 15:43:53 +0100,
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> escribi=F3:
>
> > I would greatly appreciate if you update ide.txt accordingly.
>
>
> If this doesn't look OK (it's crappy to paste command examples
> instead of explaining the interface) I'll rewrite it after the
> weekend.

Well, examples are fine but some explanation would be needed.
I'll wait for revised version (please also add that you need
CONFIG_HOTPLUG=3Dy for using sysfs interface - this is due
one of the recent changes in the kernel driver core).

Thanks,
Bartlomiej

> --- test/Documentation/ide.txt.old      2006-01-13 16:58:28.000000000=
 +0100
> +++ test/Documentation/ide.txt  2006-01-13 17:08:08.000000000 +0100
> @@ -244,10 +244,44 @@ Summary of ide driver parameters for ker
>
>   "hdx=3Dbswap"           : same as above..........
>
> - "hdx=3Dscsi"            : the return of the ide-scsi flag, this is =
useful for
> + "hdx=3Dide-scsi" (*)    : the return of the ide-scsi flag, this is =
useful for
>                           allowing ide-floppy, ide-tape, and ide-cdro=
m|writers
>                           to use ide-scsi emulation on a device speci=
fic option.
>
> + "hdx=3Dscsi" (*)        : This option tells IDE drivers not to bind=
 to device
> +                         "hdx"
> +
> + [(*) Notice that in current kernels you can use the generic sysfs i=
nterface
> +  to bind/unbind devices to drivers dynamically without using "hdx=3D=
scsi"
> +  and/or "hdx=3Dide-scsi", so those boot options may be deprecated i=
n the future,
> +  ej:
> +
> +   [root@trik /]# cd /sys/bus/ide/drivers/
> +   [root@trik drivers]# ls
> +   ide-cdrom  ide-disk  ide-scsi
> +   [root@trik drivers]# ls ide-cdrom ide-scsi
> +   ide-cdrom:
> +   1.0  bind  module  unbind
> +
> +   ide-scsi:
> +   bind  module  unbind
> +   [root@trik drivers]# echo -n "1.0">ide-cdrom/unbind
> +   [root@trik drivers]# ls ide-cdrom ide-scsi
> +   ide-cdrom:
> +   bind  module  unbind
> +
> +   ide-scsi:
> +   bind  module  unbind
> +   [root@trik drivers]# echo -n "1.0">ide-scsi/bind
> +   [root@trik drivers]# ls ide-cdrom ide-scsi
> +   ide-cdrom:
> +   bind  module  unbind
> +
> +   ide-scsi:
> +   1.0  bind  module  unbind
> +   [root@trik drivers]#
> +
> +
>   "idebus=3Dxx"           : inform IDE driver of VESA/PCI bus speed i=
n MHz,
>                           where "xx" is between 20 and 66 inclusive,
>                           used when tuning chipset PIO modes.
>
