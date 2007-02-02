From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Fri, 2 Feb 2007 09:43:49 -0700
Message-ID: <311601c90702020843w16a67db8j5ead05f107161ec9@mail.gmail.com>
References: <20070202063748.GC1625@htj.dyndns.org> <45C33BCF.2040506@emc.com>
	 <45C354CF.1020500@gmail.com>
	 <20070202153929.33f4a806@localhost.localdomain>
	 <45C36338.60803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:16185 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945963AbXBBQnu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 11:43:50 -0500
Received: by wr-out-0506.google.com with SMTP id i22so782343wra
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 08:43:49 -0800 (PST)
In-Reply-To: <45C36338.60803@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Ric Wheeler <ric@emc.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On 2/2/07, Mark Lord <liml@rtr.ca> wrote:
> 7 seconds is not enough for current drives to report back.
> Adding another (8 seconds total) is enough, but I prefer to
> see a little margin there, so call it 10 seconds.

If you're going to allow 30 seconds (or more) for a cache flush, you
probably want to allow 30 seconds (or more) for any command that might
implicitly cause a cache flush.

Things like EXECUTE DEVICE DIAGNOSTICS, IDENTIFY DEVICE, NOP,
STANDBY/IDLE IMMEDIATE, both "soft" and "hard" reset, most SMART
commands, etc.

In fact, my understanding is that many devices will flush their write
caches to disk when receiving non-data commands, so those commands may
take a while if they occur immediately following heavy write activity,
even without errors being present.

While sure, a reset should function fine being issued in the middle of
a command, and bring the drive back to a ready state, I don't know if
these assumptions about 7s vs 8s vs 10s are always going to be valid
for disk drives purchased through distribution channels or in the
generic PC market, as opposed to "RAID edition" or "MaxLine" or
similar branding from other vendors, where the firmware may have been
specifically optimized for quicker command completion, quicker status
reporting and less exhaustive error recovery.  Many linux users I
assume are buying/borrowing/stealing cheap old gear from whatever
source they can, and I don't want to unnecessarilly risk compounding
the issue in their environments.

--eric
