From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Tue, 24 Jan 2017 10:57:28 -0500
Message-ID: <20170124155728.GB12281@htj.duckdns.org>
References: <CAP8WD_ay1uKc0JLPr8MWQKT2N=rdqeH+hKkOCVMt76NcmK4hAA@mail.gmail.com>
 <CAP8WD_agt=peX28+d_oTXhEOd_9ogMScO7h8xd1hTTsHzWz_Vg@mail.gmail.com>
 <20161222192256.GE31216@htj.duckdns.org>
 <20170103173442.00a514cc@lxorguk.ukuu.org.uk>
 <CAP8WD_bS61spyQkd7cvktFf_dPc0wgNZ8qEa7GVrXgUobHQdvw@mail.gmail.com>
 <20170119213737.GB25133@mtj.duckdns.org>
 <CAP8WD_Y1HmuMots4HcQ06gQfs0fCh1W_y=Qa0As3MX1YA+LEKg@mail.gmail.com>
 <20170120191946.GA9280@mtj.duckdns.org>
 <20170120193828.GB9280@mtj.duckdns.org>
 <CAMHSBOVS+ehZkHG7nnUS9qQoDXKmsiBUEhBbPb=3qA2-ZaQ2Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36778 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdAXP5b (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2017 10:57:31 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so16981255pgf.3
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2017 07:57:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMHSBOVS+ehZkHG7nnUS9qQoDXKmsiBUEhBbPb=3qA2-ZaQ2Ow@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, whiteheadm@acm.org

Hello,

On Mon, Jan 23, 2017 at 03:36:18PM -0800, Gwendal Grignou wrote:
> > Can you please explain why the libata transport code is explicitly
> > pinning the parent device and then putting it in the release methods?
> > device_add/del() already gets and puts the parent, so I don't get why
> > this part is necessary.  Is this intentional?
>
> It was intentional. When I wrote the code, I used other transport as
> inspiration, in particular drivers/scsi/scsi_transport_sas.c.
> For instance, in sas_port_alloc, "port->dev.parent =
> get_device(parent);", undo in sas_port_release().
> From your debug code, in case of ATA at least, it looks unnecessary.

kobjects release their parents on kobject_del() rather than release,
which I don't think is a good design, so if there are code paths which
try to walk up the hierarchy after being deleted but before released,
having the extra ref around release does make sense.  I don't know
whether that's the case for the transport code tho.

Anyways, I was curious but this is a bit tangential to the issue.
This code does make the ata device hang around till the transport
kobject is released and the problem is caused by the transport kobject
not being released, so there's linkage there, but we wanna find out
why the transport kobject isn't being released and fix it.

> Moreover, in the error path of ata_XXX_add, a put_device(&link->tdev)
> Also,How ata_tport_add() increase the reference twice before calling
> device_add()?

Dunno, attribute additions?

> > Also, it looks like there is a ref leak on the transport device
> > itself.  Its release function never gets called and thus the parent
> > device (ata_port) stays pinned too.
>
> That's the root cause of pata port not released. Can we run your debug
> code one more time, enabling ap->tdev.kobj.release_debug?

Yeah, I'll update the patch.

Thanks.

-- 
tejun
