From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Date: Wed, 13 Dec 2006 15:01:29 +0100
Message-ID: <58cb370e0612130601w72c4cf73m45f26c74103f2231@mail.gmail.com>
References: <200612130148.34539.sshtylyov@ru.mvista.com>
	 <20061212234145.557cb035@localhost.localdomain>
	 <58cb370e0612121709x41270fb2p20280cc1edc9c533@mail.gmail.com>
	 <20061213113248.06372806@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:35717 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964982AbWLMOBb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Dec 2006 09:01:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so533370nfa
        for <linux-ide@vger.kernel.org>; Wed, 13 Dec 2006 06:01:30 -0800 (PST)
In-Reply-To: <20061213113248.06372806@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/13/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > > Waste of space having a busproc routine. The maintainer removed all the
> > > usable hotplug support from old IDE so this might as well be dropped.
> >
> > I took over IDE when hotplug was already broken (late 2.5), moreover IDE
> > hotplug support has been always a quick hack according to its original author...
> > I remember your great efforts to fix it but unfortunately they
> > depended on executing
> > ioctls on non-existing devices which made them depend on layering
> > violation in 2.6,
>
> Bart, I'm really not interested in a 500 email rehash of the fact you
> chose to refuse the hotplug support (that was working) for 2.6.x. You
> did, the world has moved on, and there is no point putting a busproc
> function in that driver.

Unfortunately it seems that not everybody has moved on.  It is not
about your not accepted patches but about "the maintainer removed
all the usable hotplug support from old IDE" false accusations which
are unproven and untrue.

Bart
