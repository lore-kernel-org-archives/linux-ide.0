From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH v2] libata: export host controller number thru /sys
Date: Tue, 22 Jan 2013 04:27:44 -0800
Message-ID: <CAMHSBOXWkZTyH18goC6iS-S7VAmCuHJ9Wwhzy6kB1m5RKwFEAA@mail.gmail.com>
References: <1358287662-24016-1-git-send-email-dmilburn@redhat.com>
	<CAPXgP12JEjksJz7eyvOmzAXh+nFPrEXEU_bsoff-u9bwiyipZg@mail.gmail.com>
	<50F71AE5.6050906@redhat.com>
	<CAPXgP11pk7xT+SzH9p1+Yj5C16ar0qFdZikg=67w37aS_V9W8Q@mail.gmail.com>
	<20130117182239.GA31009@dhcp-10-15-1-70.hsv.redhat.com>
	<CAPXgP10jOrO4ULwOusf80GiqqCydYykfcWaLjky6_fKFNR1PeA@mail.gmail.com>
	<20130121154909.GA5750@dhcp-10-15-1-70.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33406 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab3AVM1q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2013 07:27:46 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so4327606wgb.0
        for <linux-ide@vger.kernel.org>; Tue, 22 Jan 2013 04:27:45 -0800 (PST)
In-Reply-To: <20130121154909.GA5750@dhcp-10-15-1-70.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: Kay Sievers <kay@vrfy.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, coughlan@redhat.com, fengguang.wu@intel.com

<resent as text 2>
Although your solution works, it breaks the current numbering. The X
in <pci-path>/ataX/link<..> has changed meaning, and it is not obvious
to an untrained eyes.
If we are willing to change, could we reconsider the patches in
"Insert ATA transport objects in SCSI syfs topology"? These patches
also makes udev rules easier to write, given we have scsi host id
available in the path.

On Mon, Jan 21, 2013 at 7:49 AM, David Milburn <dmilburn@redhat.com> wrote:
> On Sun, Jan 20, 2013 at 03:57:16AM +0100, Kay Sievers wrote:
>> On Thu, Jan 17, 2013 at 7:22 PM, David Milburn <dmilburn@redhat.com> wrote:
>>
>> > The port multiplier extends the ATA port with up to 15 additional ports (links),
>> > so with this patch
>> >
>> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1
>> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1/dev1.0/ata_device
>> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1/ata_link
>> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.0/dev1.0.0/ata_device
>> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.0/ata_link
>> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.1/dev1.1.0/ata_device
>> > ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.1/ata_link
>> >
>> > ata<localport>/link<localport>.<unique port mult port>/dev<localport>.<port mult port>.0/ata_device
>>
>> @@ -284,7 +284,7 @@ int ata_tport_add(struct device *parent,
>>
>>         dev->parent = get_device(parent);
>>         dev->release = ata_tport_release;
>> -       dev_set_name(dev, "ata%d", ap->print_id);
>> +       dev_set_name(dev, "ata%d", ap->local_print_id);
>>
>> > @@ -410,9 +410,9 @@ int ata_tlink_add(struct ata_link *link)
>> >         dev->parent = get_device(&ap->tdev);
>> >         dev->release = ata_tlink_release;
>> >         if (ata_is_host_link(link))
>> > -               dev_set_name(dev, "link%d", ap->print_id);
>> > +               dev_set_name(dev, "link%d", ap->local_print_id);
>>
>> Hmm, multiple controllers will clash with their names here now, right?
>> The "ata%d"  and "link%d..." devices all show up in /sys/class/ in the
>> same directories and need a unique name there, now that we start at
>> every controller with out own counter, right?
>>
>> We need to prefix the names with the global counter?
>
> So, would you be OK with this? Every link would be <unique global port>.<unique port
> multiplier port> combination with no clashes with above ata<local port>
>
> # find . -name 'ata*' -print
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7/dev7.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.0/dev7.0.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.0/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.1/dev7.1.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.1/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.2/dev7.2.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.2/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.3/dev7.3.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.3/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.4/dev7.4.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.4/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.5/dev7.5.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.5/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.6/dev7.6.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.6/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.7/dev7.7.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.7/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.8/dev7.8.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.8/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.9/dev7.9.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.9/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/ata_port
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.10/dev7.10.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.10/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.11/dev7.11.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.11/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.12/dev7.12.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.12/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.13/dev7.13.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.13/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.14/dev7.14.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link7.14/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata2
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata2/link8/dev8.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata2/link8/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata2/ata_port
> ./pci0000:00/0000:00:1f.2/ata1
> ./pci0000:00/0000:00:1f.2/ata1/link1/dev1.0/ata_device
> ./pci0000:00/0000:00:1f.2/ata1/link1/ata_link
> ./pci0000:00/0000:00:1f.2/ata1/ata_port
> ./pci0000:00/0000:00:1f.2/ata1/ata_port/ata1
> ./pci0000:00/0000:00:1f.2/ata2
> ./pci0000:00/0000:00:1f.2/ata2/link2/dev2.0/ata_device
> ./pci0000:00/0000:00:1f.2/ata2/link2/ata_link
> ./pci0000:00/0000:00:1f.2/ata2/ata_port
> ./pci0000:00/0000:00:1f.2/ata2/ata_port/ata2
> ./pci0000:00/0000:00:1f.2/ata3
> ./pci0000:00/0000:00:1f.2/ata3/link3/dev3.0/ata_device
> ./pci0000:00/0000:00:1f.2/ata3/link3/ata_link
> ./pci0000:00/0000:00:1f.2/ata3/ata_port
> ./pci0000:00/0000:00:1f.2/ata3/ata_port/ata3
> ./pci0000:00/0000:00:1f.2/ata4
> ./pci0000:00/0000:00:1f.2/ata4/link4/dev4.0/ata_device
> ./pci0000:00/0000:00:1f.2/ata4/link4/ata_link
> ./pci0000:00/0000:00:1f.2/ata4/ata_port
> ./pci0000:00/0000:00:1f.2/ata4/ata_port/ata4
> ./pci0000:00/0000:00:1f.2/ata5
> ./pci0000:00/0000:00:1f.2/ata5/link5/dev5.0/ata_device
> ./pci0000:00/0000:00:1f.2/ata5/link5/ata_link
> ./pci0000:00/0000:00:1f.2/ata5/ata_port
> ./pci0000:00/0000:00:1f.2/ata5/ata_port/ata5
> ./pci0000:00/0000:00:1f.2/ata6
> ./pci0000:00/0000:00:1f.2/ata6/link6/dev6.0/ata_device
> ./pci0000:00/0000:00:1f.2/ata6/link6/ata_link
> ./pci0000:00/0000:00:1f.2/ata6/ata_port
> ./pci0000:00/0000:00:1f.2/ata6/ata_port/ata6
>
> Thanks,
> David
>
>  drivers/ata/libata-core.c      |    6 ++++--
>  drivers/ata/libata-transport.c |    2 +-
>  include/linux/libata.h         |    1 +
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 9e8b99a..b225b87 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5604,6 +5604,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>         ap->pflags |= ATA_PFLAG_INITIALIZING | ATA_PFLAG_FROZEN;
>         ap->lock = &host->lock;
>         ap->print_id = -1;
> +       ap->local_print_id = -1;
>         ap->host = host;
>         ap->dev = host->dev;
>
> @@ -6094,9 +6095,10 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
>                 kfree(host->ports[i]);
>
>         /* give ports names and add SCSI hosts */
> -       for (i = 0; i < host->n_ports; i++)
> +       for (i = 0; i < host->n_ports; i++) {
>                 host->ports[i]->print_id = atomic_inc_return(&ata_print_id);
> -
> +               host->ports[i]->local_print_id = i + 1;
> +       }
>
>         /* Create associated sysfs transport objects  */
>         for (i = 0; i < host->n_ports; i++) {
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index c04d393..dc5f838 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -284,7 +284,7 @@ int ata_tport_add(struct device *parent,
>
>         dev->parent = get_device(parent);
>         dev->release = ata_tport_release;
> -       dev_set_name(dev, "ata%d", ap->print_id);
> +       dev_set_name(dev, "ata%d", ap->local_print_id);
>         transport_setup_device(dev);
>         error = device_add(dev);
>         if (error) {
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 83ba0ab..5208532 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -742,6 +742,7 @@ struct ata_port {
>         /* Flags that change dynamically, protected by ap->lock */
>         unsigned int            pflags; /* ATA_PFLAG_xxx */
>         unsigned int            print_id; /* user visible unique port ID */
> +       unsigned int            local_print_id; /* host local port ID */
>         unsigned int            port_no; /* 0 based port no. inside the host */
>
>  #ifdef CONFIG_ATA_SFF
>
