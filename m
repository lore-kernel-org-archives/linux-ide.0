From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: RFC: hotplug & libata.
Date: Fri, 15 Oct 2004 22:58:25 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04101513584f1bf314@mail.gmail.com>
References: <20041015151656.A26160@florence.linkmargin.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.194]:60193 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268425AbUJOU6Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Oct 2004 16:58:25 -0400
Received: by mproxy.gmail.com with SMTP id 77so19757rnk
        for <linux-ide@vger.kernel.org>; Fri, 15 Oct 2004 13:58:25 -0700 (PDT)
In-Reply-To: <20041015151656.A26160@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Fri, 15 Oct 2004 15:16:56 -0500, Andy Warner <andyw@pobox.com> wrote:
> I've spent time over the last 10 days or so working
> through hotplug issues with libata and am coming round
> to the position that the current __init/probe mechanism
> may need some reorganisation for hotplug to work well.
> 
> I can currently (mostly) hotplug SATA drives that were
> present at __init/probe all day long; but things
> are less good for drives which were not present
> at __init/probe.
> 
> If it's not there at __init/probe time, the groundwork
> isn't in place to add devices later without some fairly
> nasty & repetitious code. I keep coming back to a model
> where the host adapter ports are initialised, then the
> initial drive scan & addition is effectively a hot-plug
> event (either automatic or forced, depending on hardware
> capabilities.)

Sounds fine.

> Unfortunately, I fear that any impending PATA/libata
> train-wreck may conflict with this, due to the behaviour
> of some (many) of the PATA chipsets out there (e.g.
> misbehaving seriously when no active devices are attached
> to the bus etc.)

misbehaving?

For the PATA I worry a bit about chipset tuning vs hotplug:
* single PCI config space byte holds settings for all devices etc.
* some hosts don't like when settings for the one port are
  changed while there is IO in flight for the other port

There should be some smart host wide locking for that.

Otherwise I see no major problems for PATA hotplug
(or rather "coldplug") support.

> Anyone have thoughts/advice to share on this concept? I think
> the re-org may be quite intrusive, and I don't want to waste
> cycles on something that "would never work with PATA, because
> of blah, blah, blah.."

Without seeing actual code it is hard to say but I'm an optimist. :)
