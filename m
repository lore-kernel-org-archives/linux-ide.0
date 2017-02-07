From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Tue, 7 Feb 2017 12:21:37 -0800
Message-ID: <CAMHSBOUAMxTj7u5Jg4_VkxHmG5BUCr-AhDHY2UT+VMchn8daLQ@mail.gmail.com>
References: <CAP8WD_agt=peX28+d_oTXhEOd_9ogMScO7h8xd1hTTsHzWz_Vg@mail.gmail.com>
 <20161222192256.GE31216@htj.duckdns.org> <20170103173442.00a514cc@lxorguk.ukuu.org.uk>
 <CAP8WD_bS61spyQkd7cvktFf_dPc0wgNZ8qEa7GVrXgUobHQdvw@mail.gmail.com>
 <20170119213737.GB25133@mtj.duckdns.org> <CAP8WD_Y1HmuMots4HcQ06gQfs0fCh1W_y=Qa0As3MX1YA+LEKg@mail.gmail.com>
 <20170120191946.GA9280@mtj.duckdns.org> <20170120193828.GB9280@mtj.duckdns.org>
 <CAMHSBOVS+ehZkHG7nnUS9qQoDXKmsiBUEhBbPb=3qA2-ZaQ2Ow@mail.gmail.com>
 <CAP8WD_aya3junhovXtc=iUaaX43=Y1s8-eya_LvN_BQjXGLbew@mail.gmail.com>
 <20170124161937.GE12281@htj.duckdns.org> <CAP8WD_b2PXXXQgTQ_-a=8Z7ppNMa5xGuhsEvJGDT_WvT1EFwog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37675 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754323AbdBGUV6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Feb 2017 15:21:58 -0500
Received: by mail-it0-f48.google.com with SMTP id r185so88320549ita.0
        for <linux-ide@vger.kernel.org>; Tue, 07 Feb 2017 12:21:58 -0800 (PST)
In-Reply-To: <CAP8WD_b2PXXXQgTQ_-a=8Z7ppNMa5xGuhsEvJGDT_WvT1EFwog@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: whiteheadm@acm.org
Cc: Tejun Heo <tj@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

link2, dev2.x are not leaking. pata_legacy.1 is not freed because of ata2.
I extracted some of the output where the ata port object is not freed properly:

 ref=1++ (attribute_container_add_device:transport_setup_device:ata_tport_add)
 ref=2++ (ata_tport_add:ata_host_register:ata_host_activate)
 ref=3++ (klist_node_init:klist_add_tail:device_add)
 ref=4-- (ata_tport_add:ata_host_register:ata_host_activate)
 ref=3++ (attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
 ref=4++ (kobject_add:get_device_parent:device_add)
 ref=5++ (ata_tlink_add:ata_tport_add:ata_host_register)
 ref=6++ (ata_tlink_add:ata_tport_add:ata_host_register)
 ref=7++ (kobject_add:device_add:ata_tlink_add)
 ref=8++ (scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
 ref=9++ (kobject_add:device_add:scsi_add_host_with_dma)
 ref=10++ (scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)


 ref=11-- (device_del:scsi_remove_host:ata_host_detach)
 ref=10-- (scsi_remove_host:ata_host_detach:legacy_init [pata_legacy])
 ref=9-- (device_del:ata_tlink_delete:ata_tport_delete)
 ref=8-- (ata_tlink_delete:ata_tport_delete:ata_host_detach)
 ref=7-- (ata_tlink_release:device_release:kobject_cleanup)
 ref=6-- (kobject_cleanup:kobject_put:cleanup_glue_dir)
 ref=5-- (attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
 ref=4-- (klist_put:klist_del:device_del)
 ref=3-- (attribute_container_release:device_release:kobject_cleanup)
 ref=2-- (ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])

Trying to match the put and get, I notice that scsi_add_host_with_dma
does 2 direct get, but scsi_remove_host only one direct put.
I did the following match:

 ref=1++ (attribute_container_add_device:transport_setup_device:ata_tport_add)
       --> ref=3-- (attribute_container_release:device_release:kobject_cleanup)
 ref=3++ (klist_node_init:klist_add_tail:device_add) -->  ref=4--
(klist_put:klist_del:device_del)
 ref=3++ (attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
       --> ref=5--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
 ref=4++ (kobject_add:get_device_parent:device_add) --> ref=6--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
 ref=5++ (ata_tlink_add:ata_tport_add:ata_host_register) --> ref=7--
(ata_tlink_release:device_release:kobject_cleanup)
 ref=6++ (ata_tlink_add:ata_tport_add:ata_host_register)  -->  ref=8--
(ata_tlink_delete:ata_tport_delete:ata_host_detach)
 ref=7++ (kobject_add:device_add:ata_tlink_add)  --> ref=9--
(device_del:ata_tlink_delete:ata_tport_delete)
 ref=8++ (scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
-->  ref=10-- (scsi_remove_host:ata_host_detach:..
 ref=9++ (kobject_add:device_add:scsi_add_host_with_dma)         -->
ref=11-- (device_del:scsi_remove_host:ata_host_detach)
 ref=10++ (scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)

Then the final call should have trigger destruction the port object:
 ref=2-- (ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])

Looking at scsi_add_host_with_dma/scsi_remove_host, we need to do
get_device on shost->shost_gendev.parent because we will do put_device
in scsi_host_dev_release, the release function of shost_gendev (which
is not called).
We do get_device on shost->shost_gendev for scsi_host_cls_release()
put_device, the release function of shost->host_dev, so I think it is
fine.

I am wondering if we don't have a circular dependency:
We do the final put_device (in scsi_host_put) on ap->scsi_host in
ata_host_release(), but it is not called because
[scsi_host]->shost_gendev.parent is &ap->tdev which hold the put on
its parent, ap.

If my understanding is correct, as Tejun pointed out, removing the put
on ap in ata_tport_release and the get_device(parent) in ata_tport_add
should unlock the situation.
