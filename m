From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 22:09:13 +0100
Message-ID: <200703162209.13411.bzolnier@gmail.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com> <45FAE7F3.7050201@pobox.com> <45FAFB24.2050800@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:41561 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965926AbXCPVB6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 17:01:58 -0400
Received: by ug-out-1314.google.com with SMTP id 44so803481uga
        for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 14:01:57 -0700 (PDT)
In-Reply-To: <45FAFB24.2050800@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mikael Pettersson <mikpe@it.uu.se>


On Friday 16 March 2007, Mark Lord wrote:
> Jeff Garzik wrote:
> > Alan Cox wrote:
> >>>     I think it only requires the *host* to drop to PIO0 timings.  In 
> >>> which case it should be achievable w/o libata modification -- if the 
> >>> driver has to "snoop" command and turn off prefetch, why not switch 
> >>> to PIO0 temporarily?
> >>
> >> This isn't a big issue. Eventually we have to support sending speed
> >> change commands and once we do that the caller will be able to switch to
> >> PIO0 and back again.
> > 
> > We should be pretty close to that.  One of the bigger blockages is 
> > needing to stop (freeze) all ports, before performing an out-of-band SET 
> > FEATURES and related tuning.
> 
> For this particular feature, READ/WRITE LONG,
> none of this is actually necessary in practice on common controllers.

It still would be nice to add a comment documenting issues raised by Sergei
so if somebody actually hits a problem on not-so-common controller she/he
will know what to look for.

> I've tested ATA1 and newer PATA drives, and various SATA drives
> with these commands without bothering to drop to PIO0,
> and none of them had issues.

This is what really matters wrt libata READ/WRITE LONG support.

These commands are not supposed to be used by normal users anyway
so patch while not being "perfect" is "good enough" to be merged IMO.

Bart
