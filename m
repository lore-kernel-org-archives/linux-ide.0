From: Daniele Forsi <dforsi@gmail.com>
Subject: Re: Unable to complete boot with pata_sis
Date: Thu, 7 Aug 2014 23:35:22 +0200
Message-ID: <CAN_we7P38OjX5dqDV5CuxS32xnnL-xXeu8GaFciwanqMSDGmSg@mail.gmail.com>
References: <CAN_we7P6RF_OnBivLYqnpeftJH64st3msX-dJROetz1UxpDLjw@mail.gmail.com>
	<20140730155735.20b6d12c@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:64692 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaHGVfY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Aug 2014 17:35:24 -0400
Received: by mail-lb0-f172.google.com with SMTP id z11so3190098lbi.17
        for <linux-ide@vger.kernel.org>; Thu, 07 Aug 2014 14:35:22 -0700 (PDT)
In-Reply-To: <20140730155735.20b6d12c@alan.etchedpixels.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

2014-07-30 16:57 GMT+02:00 One Thousand Gnomes:

> Somewhere there is a subtle behavioural difference between pata_sis and
> the ancient sis5513 driver. About the only way to find it would be to
> boot both the old and new kernels and log every single access to the disk
> controller to the point of failure (or some short way into booting) in
> both cases somewhere (eg over the network) then compare them.

thank you for your answer, we don't need to use kernel 2.4 because
after blacklisting pata_sis in 3.16.0, sis5513 can be used just fine,
if I don't blacklist pata_sis and I rmmod it after it tried to access
the disk, the controller or the drive are in a state in which sis5513
gives a lot of errors and can't read the disk

what kind of information you need?
I added some printk() to dump the arguments to pci_write_config_*( )
and these are the results for sis3315 in 3.16 which works (values
printed are dev, where and val):
Aug  7 23:00:47 debian2 kernel: [    1.709953] PCI W byte: c68ed000
where 0xd = 0x10
Aug  7 23:00:47 debian2 kernel: [    1.709971] PCI W byte: c68ed000
where 0x52 = 0x4<6>[    1.709984] sis5513 0000:00:00.1: not 100%
native mode: will probe irqs later
Aug  7 23:00:47 debian2 kernel: [    1.710077] Probing IDE interface ide0...
Aug  7 23:00:47 debian2 kernel: [    2.695099] hda: host max PIO4
wanted PIO255(auto-tune) selected PIO4
Aug  7 23:00:47 debian2 kernel: [    2.695167] PCI W byte: c68ed000
where 0x4b = 0x11
Aug  7 23:00:47 debian2 kernel: [    2.695189] PCI W word: c68ed000
where 0x40 = 0x301<6>[    2.695402] hda: MWDMA2 mode selected
Aug  7 23:00:47 debian2 kernel: [    2.695415] PCI W word: c68ed000
where 0x40 = 0x301
Aug  7 23:00:47 debian2 kernel: [    2.695591] Probing IDE interface ide1...
Aug  7 23:00:47 debian2 kernel: [    3.264461] sata_promise
0000:00:09.0: version 2.12
Aug  7 23:00:47 debian2 kernel: [    3.264554] PCI: setting IRQ 10 as
level-triggered
Aug  7 23:00:47 debian2 kernel: [    3.310072] PCI: setting IRQ 11 as
level-triggered

and these are the values for pata_sis in 3.16 which doesn't work:
Aug  7 23:13:26 debian2 kernel: [  799.174973] pata_sis 0000:00:00.1:
version 0.5.2
Aug  7 23:13:26 debian2 kernel: [  799.175325] PCI W byte: c68ed000
where 0xd = 0x80
Aug  7 23:13:26 debian2 kernel: [  799.180678] PCI W byte: c68ed000
where 0x4b = 0x0
Aug  7 23:13:26 debian2 kernel: [  799.180699] PCI W byte: c68ed000
where 0x40 = 0x0PCI W byte: c68ed000 where 0x41 = 0x0
Aug  7 23:13:26 debian2 kernel: [  799.180724] PCI W byte: c68ed000
where 0x4b = 0x0PCI W byte: c68ed000 where 0x42 = 0x0
Aug  7 23:13:26 debian2 kernel: [  799.180746] PCI W byte: c68ed000
where 0x43 = 0x0PCI W byte: c68ed000 where 0x4b = 0x0
Aug  7 23:13:26 debian2 kernel: [  799.351890] PCI W byte: c68ed000
where 0x4b = 0x11
Aug  7 23:13:26 debian2 kernel: [  799.351914] PCI W byte: c68ed000
where 0x40 = 0x1PCI W byte: c68ed000 where 0x41 = 0x3
Aug  7 23:13:26 debian2 kernel: [  799.372389] sd 3:0:0:0: [sdb] Mode
Sense: 00 3a 00 00
Aug  7 23:13:26 debian2 kernel: [  799.380402] PCI W byte: c68ed000
where 0x4b = 0x11
Aug  7 23:13:26 debian2 kernel: [  799.380432] PCI W byte: c68ed000
where 0x44 = 0x0PCI W byte: c68ed000 where 0x45 = 0x0
Aug  7 23:13:26 debian2 kernel: [  799.380459] PCI W byte: c68ed000
where 0x4b = 0x11PCI W byte: c68ed000 where 0x46 = 0x0
Aug  7 23:13:26 debian2 kernel: [  799.380483] PCI W byte: c68ed000
where 0x47 = 0x0PCI W byte: c68ed000 where 0x4b = 0x0
Aug  7 23:13:26 debian2 kernel: [  799.411575] ata4: drained 60 bytes
to clear DRQ
Aug  7 23:13:27 debian2 kernel: [  799.443446] PCI W byte: c68ed000
where 0x4b = 0x11
Aug  7 23:13:27 debian2 kernel: [  799.443468] PCI W byte: c68ed000
where 0x40 = 0x0PCI W byte: c68ed000 where 0x41 = 0x0
Aug  7 23:13:27 debian2 kernel: [  799.443492] PCI W byte: c68ed000
where 0x4b = 0x11PCI W byte: c68ed000 where 0x42 = 0x0
Aug  7 23:13:27 debian2 kernel: [  799.443513] PCI W byte: c68ed000
where 0x43 = 0x0PCI W byte: c68ed000 where 0x4b = 0x0
Aug  7 23:13:27 debian2 kernel: [  799.617032] PCI W byte: c68ed000
where 0x4b = 0x11
Aug  7 23:13:27 debian2 kernel: [  799.617095] PCI W byte: c68ed000
where 0x40 = 0x1PCI W byte: c68ed000 where 0x41 = 0x3

-- 
Daniele Forsi
