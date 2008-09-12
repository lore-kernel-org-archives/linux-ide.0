From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 3/4] ide: Implement disk shock protection support
Date: Fri, 12 Sep 2008 13:55:17 +0200
Message-ID: <87ljxxy3x6.fsf@denkblock.local>
References: <87wshzplvk.fsf@denkblock.local>
	<200809012129.14979.bzolnier@gmail.com>
	<87ljy90zin.fsf@denkblock.local>
	<200809051933.38888.bzolnier@gmail.com>
	<87vdx1y9gv.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:52357 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbYILL4l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Sep 2008 07:56:41 -0400
In-Reply-To: <87vdx1y9gv.fsf@denkblock.local> (Elias Oltmanns's message of
	"Fri, 12 Sep 2008 11:55:28 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Elias Oltmanns <eo@nebensachen.de> wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
[...]
>> Since Tejun already raised concerns about multiplexing per-device
>> and per-port settings I'm not repeating them here.  Please just
>> remember to backport fixes from libata version to ide one.
>
> For the sake of consistency, I've always tried to make ide and libata
> behave alike (or as close to it as possible). However, the final version
> of the libata patch is very hard to mimc in ide. Therefore, I wonder
> whether we can do in ide what we'd really like to do in libata
> eventually. The patch below is a real per-device implementation of the
> unload feature. However, I'd like you to confirm the crucial assumption
> underlying this patch: a port reset is the only way a device can
> interfere with another device on the same port. In particular, I haven't
> made an effort to understand pnp and similar stuff completely, but from
> a first glance I got the impression that these things are done per-port
> rather than per-device and that nothing sinister will happen behind our
> back. In short, can you confirm the following:
>
> Condition:  device A on a port is parked (implies there is at least one
>             request on the queue of that device, i.e we hold a
>             reference to the device and thus to the port).
> Assumption: nothing will disturb the device because resets due to
>             command failure / timeouts on device B are deferred (see my
>             patch) and spurious commands like IDENTIFY (or whatever
>             actions may be related to pnp and the like) are not 
>             performed while the device is sleeping and a request is
>             waiting on the queue.

Sorry for spamming you again, but I forgot to mention one more thing: In
my hardware environment, I cannot easily test the code in do_reset1()
which is supposed to defer resets if necessary. Since we have something
very similar in libata (which I have tested), I'm quite confident that
everything will work out nicely. Still, you may want to pay special
attention to this piece of code.

Regards,

Elias
