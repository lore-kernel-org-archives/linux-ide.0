From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Fri, 20 Jan 2017 14:19:46 -0500
Message-ID: <20170120191946.GA9280@mtj.duckdns.org>
References: <CAP8WD_YMtnsuYmJHGz1eLmrQNemsB1Z6Soyb6f72brAfMNUNeg@mail.gmail.com>
 <CAP8WD_ZoJgrdsDZNR4uN8HWESO5MyuNc1xN_F2an8GfP8nKcLA@mail.gmail.com>
 <20161222163711.GB29161@htj.duckdns.org>
 <CAP8WD_ay1uKc0JLPr8MWQKT2N=rdqeH+hKkOCVMt76NcmK4hAA@mail.gmail.com>
 <CAP8WD_agt=peX28+d_oTXhEOd_9ogMScO7h8xd1hTTsHzWz_Vg@mail.gmail.com>
 <20161222192256.GE31216@htj.duckdns.org>
 <20170103173442.00a514cc@lxorguk.ukuu.org.uk>
 <CAP8WD_bS61spyQkd7cvktFf_dPc0wgNZ8qEa7GVrXgUobHQdvw@mail.gmail.com>
 <20170119213737.GB25133@mtj.duckdns.org>
 <CAP8WD_Y1HmuMots4HcQ06gQfs0fCh1W_y=Qa0As3MX1YA+LEKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34488 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbdATTTu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2017 14:19:50 -0500
Received: by mail-pg0-f65.google.com with SMTP id t6so7549275pgt.1
        for <linux-ide@vger.kernel.org>; Fri, 20 Jan 2017 11:19:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8WD_Y1HmuMots4HcQ06gQfs0fCh1W_y=Qa0As3MX1YA+LEKg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Hello,

Thanks for testing.

On Fri, Jan 20, 2017 at 12:08:10PM -0500, tedheadster wrote:
> kobject_get(pata_legacy.1): ref=3++ (ata_tport_add:ata_host_register:ata_host_activate)
> kobject_get(pata_legacy.1): ref=4++ (ata_tport_add:ata_host_register:ata_host_activate)
> XXX kobject_get(pata_legacy.1): ref=5++ (kobject_add:device_add:ata_tport_add)
> XXX kobject_put(pata_legacy.1): ref=6-- (device_del:ata_tport_delete:ata_host_detach)
> XXX kobject_put(pata_legacy.1): ref=5-- (ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
> XXX kobject_put(pata_legacy.1): ref=4-- (klist_put:klist_del:device_del)
> XXX kobject_put(pata_legacy.1): ref=3-- (klist_devices_put:klist_put:klist_del)
> XXX kobject_put(pata_legacy.1): ref=2-- (platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)

So, three gets from the transport path but only two puts.  That seems
to be the culprit.  Looking into it.

Thanks.

-- 
tejun
