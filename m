From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Mon, 21 Jan 2008 16:26:11 +0900
Message-ID: <47944913.6000603@gmail.com>
References: <4794459C.3090200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:33775 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbYAUH0T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 02:26:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3531864wah.23
        for <linux-ide@vger.kernel.org>; Sun, 20 Jan 2008 23:26:17 -0800 (PST)
In-Reply-To: <4794459C.3090200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Evans <evans02472@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Thomas.  (cc'ing linux-ide, you don't have to be subscribed to post)

Thomas Evans wrote:
> I usually go by "tom@23palmer.net" - unfortunately I am unable to get
> that machine started so I am using gmail instead.
> 
> I have run into an odd situation with that machine - the 4726 port
> multiplier is no longer found by libata/sata_sil24.
> I mean - not at all - I have 2.6.24-rc candidates all the back to rc3 or
> so (was using rc8 most recently).
> I've even tried 2.6.22.1 with your patches for that kernel.  They all
> fail to see the PM - it just tries to do softresets on the esata port
> that has the connection - no iteration of the PM ports.

Up to now, it sounds very much like hardware failure.

> I went so far as to try a new 3124 based card, new cable and I even
> found a copy of the eSata PMP enclosure at a local store to swap that
> out (gotta return it all - way expensive).

What do you mean by eSata PMP enclosure?  Is it a different PMP device?

> I can hook the card and storage enclosure to a windows box and can see
> the PM and the drives (and the config space).

Hmmm.......

> The 1 thing I did do was attempt to migrate the machine from a DS20 to a
> DS20L.

What are DS20 and DS20L?

> When I tried to bring up the array there (same card, same boot
> disk) I would get constant SRST failures, -5.  I migrated it back to the
> original system, same thing.  I figured I broke something, which is why
> I tried to replace everything with no luck - it's as if something has
> forgotten how to find the SiI4726.

Hmmm.......

> any idea what might be happening?  I would post to the list, but cannot
> right now until I resubscribe as this name ...

That's one weird story.  I don't have much idea at this point.  Can you
try to grab failing kernel log and post it?  You can either connect a
harddrive directly, get a system up from there and grab failing
detection log or set up serial or netconsole.

Thanks.

-- 
tejun
