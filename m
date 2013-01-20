From: Kay Sievers <kay@vrfy.org>
Subject: Re: [PATCH v2] libata: export host controller number thru /sys
Date: Sun, 20 Jan 2013 03:57:16 +0100
Message-ID: <CAPXgP10jOrO4ULwOusf80GiqqCydYykfcWaLjky6_fKFNR1PeA@mail.gmail.com>
References: <1358287662-24016-1-git-send-email-dmilburn@redhat.com>
 <CAPXgP12JEjksJz7eyvOmzAXh+nFPrEXEU_bsoff-u9bwiyipZg@mail.gmail.com>
 <50F71AE5.6050906@redhat.com> <CAPXgP11pk7xT+SzH9p1+Yj5C16ar0qFdZikg=67w37aS_V9W8Q@mail.gmail.com>
 <20130117182239.GA31009@dhcp-10-15-1-70.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:54343 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab3ATC5h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jan 2013 21:57:37 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so4021217wib.13
        for <linux-ide@vger.kernel.org>; Sat, 19 Jan 2013 18:57:36 -0800 (PST)
In-Reply-To: <20130117182239.GA31009@dhcp-10-15-1-70.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, coughlan@redhat.com, fengguang.wu@intel.com, gwendal@google.com

On Thu, Jan 17, 2013 at 7:22 PM, David Milburn <dmilburn@redhat.com> wrote:

> The port multiplier extends the ATA port with up to 15 additional ports (links),
> so with this patch
>
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1/dev1.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.0/dev1.0.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.0/ata_link
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.1/dev1.1.0/ata_device
> ./pci0000:00/0000:00:1e.0/0000:05:01.0/ata1/link1.1/ata_link
>
> ata<localport>/link<localport>.<unique port mult port>/dev<localport>.<port mult port>.0/ata_device

@@ -284,7 +284,7 @@ int ata_tport_add(struct device *parent,

        dev->parent = get_device(parent);
        dev->release = ata_tport_release;
-       dev_set_name(dev, "ata%d", ap->print_id);
+       dev_set_name(dev, "ata%d", ap->local_print_id);

> @@ -410,9 +410,9 @@ int ata_tlink_add(struct ata_link *link)
>         dev->parent = get_device(&ap->tdev);
>         dev->release = ata_tlink_release;
>         if (ata_is_host_link(link))
> -               dev_set_name(dev, "link%d", ap->print_id);
> +               dev_set_name(dev, "link%d", ap->local_print_id);

Hmm, multiple controllers will clash with their names here now, right?
The "ata%d"  and "link%d..." devices all show up in /sys/class/ in the
same directories and need a unique name there, now that we start at
every controller with out own counter, right?

We need to prefix the names with the global counter?

Thanks,
Kay
