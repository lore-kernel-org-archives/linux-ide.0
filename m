From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] documentation typo
Date: Thu, 5 Jan 2006 15:43:53 +0100
Message-ID: <58cb370e0601050643q3147cfc8g46e3d17990b196a8@mail.gmail.com>
References: <20060105132014.d72f61db.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.192]:23501 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751185AbWAEOoE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jan 2006 09:44:04 -0500
Received: by nproxy.gmail.com with SMTP id l35so1115509nfa
        for <linux-ide@vger.kernel.org>; Thu, 05 Jan 2006 06:43:53 -0800 (PST)
In-Reply-To: <20060105132014.d72f61db.diegocg@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi,

On 1/5/06, Diego Calleja <diegocg@gmail.com> wrote:
> According to a bug reported in bugzilla...
>
> --- 2.6/Documentation/ide.txt.wrong     2006-01-05 13:16:06.000000000 +0100
> +++ 2.6/Documentation/ide.txt   2006-01-05 13:16:10.000000000 +0100
> @@ -244,7 +244,7 @@ Summary of ide driver parameters for ker
>
>   "hdx=bswap"           : same as above..........
>
> - "hdx=scsi"            : the return of the ide-scsi flag, this is useful for
> + "hdx=ide-scsi"                : the return of the ide-scsi flag, this is useful for
>                           allowing ide-floppy, ide-tape, and ide-cdrom|writers
>                           to use ide-scsi emulation on a device specific option.

This is not quite correct: ide-scsi is a separate device driver and
"hdx=ide-scsi" tells IDE core to try this driver first for device
"hdx" (OTOH "ide=scsi" tells other device drivers to not bind to
device "hdx").  Both options are confusing and IDE specific.

In recent kernels you can use generic sysfs interface to
bind/unbind device to drivers _dynamically_ without using
"hdx=scsi" and "hdx=ide-scsi" et all (these option can die):

[root@trik /]# cd /sys/bus/ide/drivers/
[root@trik drivers]# ls
ide-cdrom  ide-disk  ide-scsi
[root@trik drivers]# ls ide-cdrom ide-scsi
ide-cdrom:
1.0  bind  module  unbind

ide-scsi:
bind  module  unbind
[root@trik drivers]# echo -n "1.0">ide-cdrom/unbind
[root@trik drivers]# ls ide-cdrom ide-scsi
ide-cdrom:
bind  module  unbind

ide-scsi:
bind  module  unbind
[root@trik drivers]# echo -n "1.0">ide-scsi/bind
[root@trik drivers]# ls ide-cdrom ide-scsi
ide-cdrom:
bind  module  unbind

ide-scsi:
1.0  bind  module  unbind

I would greatly appreciate if you update ide.txt accordingly.

Thanks,
Bartlomiej
