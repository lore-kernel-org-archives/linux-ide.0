From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_via
Date: Mon, 14 Apr 2008 09:39:47 +0900
Message-ID: <1208133587.2755.8.camel@htj.dyndns.org>
References: <47F694C8.8020507@wesmo.com> <47F6A5E8.1030602@garzik.org>
	 <47F6BD55.3090708@wesmo.com>
	 <5699f8f00804050015kb1ebb1cpf3ab8b587580fffd@mail.gmail.com>
	 <47F7982E.5080701@wesmo.com> <47F7F463.2060402@garzik.org>
	 <480173CB.5070805@gmail.com> <480189DB.9050900@wesmo.com>
	 <48018DC0.6080407@wesmo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.251]:7362 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752964AbYDNAj7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Apr 2008 20:39:59 -0400
Received: by rv-out-0506.google.com with SMTP id k29so481593rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 13 Apr 2008 17:39:59 -0700 (PDT)
In-Reply-To: <48018DC0.6080407@wesmo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rich West <Rich.West@wesmo.com>, Thomas Renninger <trenn@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, Wander Winkelhorst <w.winkelhorst@gmail.com>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Hi,

On Sun, 2008-04-13 at 00:36 -0400, Rich West wrote:
> Rich West wrote:
> > Tejun Heo wrote:
> >> Jeff Garzik wrote:
> >>> Rich West wrote:
> >>>> I was only curious as to what turning off power management support 
> >>>> would buy with regard to the sata timeout issue.
> >>>
> >>>
> >>> ACPI is not only power management.  It is all the information your 
> >>> hardware conveys to your OS, about the setup and workings of your 
> >>> hardware.
> >>>
> >>> Without ACPI, non-PM things like SMP, laptop dock/undock, and many 
> >>> other gadgets fail to function (or are configured sub-optimally).
> >>>
> >>> ACPI sets up interrupt routing, and Linux history is _loaded_ with 
> >>> _years_ of problem reports that appear as timeouts, only to be 
> >>> resolved as ACPI interrupt bugs (aka BIOS bugs, since ACPI tables 
> >>> come from BIOS).
> >>
> >> Also, please give a shot at the sacred "irqpoll".
> >
> > I've had bad luck in the past (with other machiens) when adding 
> > "irqpoll" in that it had locked up the entire machine (not this one, 
> > but others) after a very short period of time.  My only attempt at 
> > using it, though, was to try to address an X server related issue, but 
> > this is a non-user machine, so X isn't necessary, and, hence, it's at 
> > runlevel 3 all of the time.
> >
> > So far, noapic and acpi=off seem to be working.. The system has been 
> > up 8 days without any problems.. previously, a problem with the SATA 
> > drive (details of which were part of the first few messages in this 
> > thread) would surface anywhere between 15 minutes and 5-7 days after a 
> > reboot.
> >
> > However, since I started this email, I tried firing up X (with noapci 
> > and acpi=off both set), the machine locks up entirely.
> 
> Although a reboot with irqpoll set managed to fix that X problem. :)
> 

IRQ routing seems hosed on your machine.  Thomas any ideas?

-- 
tejun

