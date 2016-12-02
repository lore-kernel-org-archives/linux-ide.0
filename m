From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Fri, 2 Dec 2016 16:24:36 +0000
Message-ID: <20161202162436.3631a367@lxorguk.ukuu.org.uk>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
        <84a95190-9e30-81ac-5f23-744243ba7fce@cogentembedded.com>
        <20161130145322.252f7403@lxorguk.ukuu.org.uk>
        <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
        <20161130181539.59cbec41@lxorguk.ukuu.org.uk>
        <CAP8WD_bPns6hGPWUUGbRd_20+bHX460p5szrfCP4bKr9k76wsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45716 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbcLBQYx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2016 11:24:53 -0500
In-Reply-To: <CAP8WD_bPns6hGPWUUGbRd_20+bHX460p5szrfCP4bKr9k76wsQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tedheadster <tedheadster@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

On Fri, 2 Dec 2016 08:37:04 -0500
tedheadster <tedheadster@gmail.com> wrote:

> Alan,
> 
> >> Alan,
> >>   on my hardware it grabbed all those interrupts, showing up in
> >> /proc/interrupts very clearly.  
> >
> > Do you have a dmesg of the boot ?
> >  
> 
> Here is the relevant dmesg information and also the /proc/interrupts results:

That's very strange. The legacy code should be seeing that no devices are
present and then dropping the controller

        /* Nothing found means we drop the port as its probably not there */

        ret = -ENODEV;
        ata_for_each_dev(dev, &ap->link, ALL) {
                if (!ata_dev_absent(dev)) {
                        legacy_host[probe->slot] = host;
                        ld->platform_dev = pdev;
                        return 0;
                }
        }
        ata_host_detach(host);


so this ought to be triggered and free up the interface and the IRQ

Alan
