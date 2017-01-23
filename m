From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Mon, 23 Jan 2017 15:36:18 -0800
Message-ID: <CAMHSBOVS+ehZkHG7nnUS9qQoDXKmsiBUEhBbPb=3qA2-ZaQ2Ow@mail.gmail.com>
References: <CAP8WD_ZoJgrdsDZNR4uN8HWESO5MyuNc1xN_F2an8GfP8nKcLA@mail.gmail.com>
 <20161222163711.GB29161@htj.duckdns.org> <CAP8WD_ay1uKc0JLPr8MWQKT2N=rdqeH+hKkOCVMt76NcmK4hAA@mail.gmail.com>
 <CAP8WD_agt=peX28+d_oTXhEOd_9ogMScO7h8xd1hTTsHzWz_Vg@mail.gmail.com>
 <20161222192256.GE31216@htj.duckdns.org> <20170103173442.00a514cc@lxorguk.ukuu.org.uk>
 <CAP8WD_bS61spyQkd7cvktFf_dPc0wgNZ8qEa7GVrXgUobHQdvw@mail.gmail.com>
 <20170119213737.GB25133@mtj.duckdns.org> <CAP8WD_Y1HmuMots4HcQ06gQfs0fCh1W_y=Qa0As3MX1YA+LEKg@mail.gmail.com>
 <20170120191946.GA9280@mtj.duckdns.org> <20170120193828.GB9280@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:37306 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbdAWXgk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2017 18:36:40 -0500
Received: by mail-it0-f50.google.com with SMTP id r185so78825411ita.0
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2017 15:36:39 -0800 (PST)
In-Reply-To: <20170120193828.GB9280@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, whiteheadm@acm.org

On Fri, Jan 20, 2017 at 11:38 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Gwendal.
>
> On Fri, Jan 20, 2017 at 02:19:46PM -0500, Tejun Heo wrote:
>> On Fri, Jan 20, 2017 at 12:08:10PM -0500, tedheadster wrote:
>> > kobject_get(pata_legacy.1): ref=3++ (ata_tport_add:ata_host_register:ata_host_activate)
>> > kobject_get(pata_legacy.1): ref=4++ (ata_tport_add:ata_host_register:ata_host_activate)
>> > XXX kobject_get(pata_legacy.1): ref=5++ (kobject_add:device_add:ata_tport_add)
>> > XXX kobject_put(pata_legacy.1): ref=6-- (device_del:ata_tport_delete:ata_host_detach)
>> > XXX kobject_put(pata_legacy.1): ref=5-- (ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
>> > XXX kobject_put(pata_legacy.1): ref=4-- (klist_put:klist_del:device_del)
>> > XXX kobject_put(pata_legacy.1): ref=3-- (klist_devices_put:klist_put:klist_del)
>> > XXX kobject_put(pata_legacy.1): ref=2-- (platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)
>>
>> So, three gets from the transport path but only two puts.  That seems
>> to be the culprit.  Looking into it.
>
> So, Matthew discovered that pata_legacy isn't releasing resources
> after probe failure.  After some debugging, it turns out that the
> transport code is taking three refs but only putting two preventing
> the ata port from going away.
>
> Can you please explain why the libata transport code is explicitly
> pinning the parent device and then putting it in the release methods?
> device_add/del() already gets and puts the parent, so I don't get why
> this part is necessary.  Is this intentional?
It was intentional. When I wrote the code, I used other transport as
inspiration, in particular drivers/scsi/scsi_transport_sas.c.
For instance, in sas_port_alloc, "port->dev.parent =
get_device(parent);", undo in sas_port_release().
>From your debug code, in case of ATA at least, it looks unnecessary.

Moreover, in the error path of ata_XXX_add, a put_device(&link->tdev)
Also,How ata_tport_add() increase the reference twice before calling
device_add()?
>
> Also, it looks like there is a ref leak on the transport device
> itself.  Its release function never gets called and thus the parent
> device (ata_port) stays pinned too.
That's the root cause of pata port not released. Can we run your debug
code one more time, enabling ap->tdev.kobj.release_debug?

Thanks,
Gwendal.
>
> Thanks.
>
> --
> tejun
