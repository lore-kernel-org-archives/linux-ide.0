From: noah <noah123@gmail.com>
Subject: Re: Possibly SATA related freeze killed networking and RAID
Date: Wed, 21 Nov 2007 20:06:40 +0100
Message-ID: <d00698fb0711211106l4fe6223ega7ca160106a6e09b@mail.gmail.com>
References: <d00698fb0711201109m23ff096eiabeb22c8f9a917dc@mail.gmail.com>
	 <20071120220512.46b9e975@the-village.bc.nu>
	 <d00698fb0711201416n30b54d26kd8d5887896d3da83@mail.gmail.com>
	 <20071121004545.512ad3ea@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:7619 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbXKUTGl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Nov 2007 14:06:41 -0500
Received: by py-out-1112.google.com with SMTP id u77so7413710pyb
        for <linux-ide@vger.kernel.org>; Wed, 21 Nov 2007 11:06:40 -0800 (PST)
In-Reply-To: <20071121004545.512ad3ea@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

2007/11/21, Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > I've had other freezes before but this was the first time I was able
> > to see what was actually going on.
> > IRQ 21 appears to be shared between sata_nv and ethernet.
> >
> > Does this mean my hardware/BIOS is broken somehow?
>
> Not neccessarily. It could a bug in one of the drivers using IRQ 21
> (sata_nv or the nvidia ethernet), it could be another inactive device, or
> it could be a hardware funny.

How can I tell if there's an inactive device?

> Nvidia stuff can be quite hard to diagnose as we have no documentation
> but we can try. The first question is whether it is network or disk
> triggered - seeing if heavy loads to one or the other trigger the problem
> might be a first plan.

I haven't managed to trigger it again yet but at the time the CPU was
heavily loaded and I was re-indexing a database which caused a lot of
disk activity. I'm quite confident the network was pretty much idle at
the time.

  -- noah
