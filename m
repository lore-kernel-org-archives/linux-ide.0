From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Date: Wed, 13 Dec 2006 02:09:42 +0100
Message-ID: <58cb370e0612121709x41270fb2p20280cc1edc9c533@mail.gmail.com>
References: <200612130148.34539.sshtylyov@ru.mvista.com>
	 <20061212234145.557cb035@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:4483 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964869AbWLMBJo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Dec 2006 20:09:44 -0500
Received: by nf-out-0910.google.com with SMTP id o25so384306nfa
        for <linux-ide@vger.kernel.org>; Tue, 12 Dec 2006 17:09:43 -0800 (PST)
In-Reply-To: <20061212234145.557cb035@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/13/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:

> > +static int tc86c001_busproc(ide_drive_t *drive, int state)
> > +{
>
> Waste of space having a busproc routine. The maintainer removed all the
> usable hotplug support from old IDE so this might as well be dropped.

I took over IDE when hotplug was already broken (late 2.5), moreover IDE
hotplug support has been always a quick hack according to its original author...
I remember your great efforts to fix it but unfortunately they
depended on executing
ioctls on non-existing devices which made them depend on layering
violation in 2.6,
also IDE device model fixes has some conflicts with them.  I take the
blame for not
applying them (for the reasons given above) and for taking much too
long in reviewing/testing them (due to lack of time not bad intention)
but accusing me of
intentional feature removal is going a bit too far...  You can hate me
all you want
for the way I did my entirely volunteer and unpaid job (but hey there
were and still is shortage of ATA hackers and there weren't anybody to
step up and takeover IDE)
but I actually have always taken responsibility/blame for all my
patches and patches
I accepted so if you really think I intentionally removed some usable
hotplug support
please point me to specific patch and describe the regression after
applying this
specific patch and I will do my best to have this regression fixed...

Bart
