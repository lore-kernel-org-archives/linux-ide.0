From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] ide_scsi: allow it to be used for non CD only
Date: Wed, 29 Nov 2006 23:05:56 +0100
Message-ID: <58cb370e0611291405j1e5f3eb1t4950ed0993b84c85@mail.gmail.com>
References: <20061129144652.299f7919@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758396AbWK2WGm@vger.kernel.org>
In-Reply-To: <20061129144652.299f7919@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org
List-Id: linux-ide@vger.kernel.org

Hi,

Nowadays, you can dynamically change driver bound to a device using
sysfs and it works just fine for IDE, ie:

echo -n "1.0" > /sys/bus/ide/drivers/ide-scsi/unbind
echo -n "1.0" > /sys/bus/ide/drivers/ide-cdrom/bind

to unbind /dev/hdc from ide-scsi and bind to ide-cdrom

That was one of the main goals behind my old patches to convert
IDE device drivers to device-model.

Please don't add another module parameter for controlling driver binding
and making it more complicated than already is:
* "hdx=scsi" kernel parameter
* "hdx=driver" kernel parameter
* /proc/ide/hd?/driver interface
* ide_cd and "ignore" parameter
(actually all the above can go away).

Bart

On 11/29/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> Some people want to use ide_cd for CD-ROM but still dynamically load
> ide-scsi for things like tape drives. If you compile in the CD driver
> this works out but if you want them modular you need an option to ensure
> that whoever loads first the right things happen.
>
> This replaces the original draft patch which leaked a scsi host reference
>
> Signed-off-by: Alan Cox <alan@redhat.com>
>
> diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.19-rc6-mm1/drivers/scsi/ide-scsi.c linux-2.6.19-rc6-mm1/drivers/scsi/ide-scsi.c
> --- linux.vanilla-2.6.19-rc6-mm1/drivers/scsi/ide-scsi.c        2006-11-24 13:58:08.000000000 +0000
> +++ linux-2.6.19-rc6-mm1/drivers/scsi/ide-scsi.c        2006-11-29 14:18:12.000000000 +0000
> @@ -110,6 +110,7 @@
>  } idescsi_scsi_t;
>
>  static DEFINE_MUTEX(idescsi_ref_mutex);
> +static int idescsi_nocd;                       /* Set by module param to skip cd */
>
>  #define ide_scsi_g(disk) \
>         container_of((disk)->private_data, struct ide_scsi_obj, driver)
> @@ -1127,11 +1128,14 @@
>                 warned = 1;
>         }
>
> +       if (idescsi_nocd && drive->media == ide_cdrom)
> +               return -ENODEV;
> +
>         if (!strstr("ide-scsi", drive->driver_req) ||
>             !drive->present ||
>             drive->media == ide_disk ||
>             !(host = scsi_host_alloc(&idescsi_template,sizeof(idescsi_scsi_t))))
>                 return -ENODEV;
>
>         g = alloc_disk(1 << PARTN_BITS);
>         if (!g)
> @@ -1187,6 +1192,7 @@
>         driver_unregister(&idescsi_driver.gen_driver);
>  }
>
> +module_param(idescsi_nocd, int, 0600);
>  module_init(init_idescsi_module);
>  module_exit(exit_idescsi_module);
>  MODULE_LICENSE("GPL");
