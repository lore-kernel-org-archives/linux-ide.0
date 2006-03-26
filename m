From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: raid and elevator
Date: Sun, 26 Mar 2006 23:29:33 +0200
Message-ID: <5d96567b0603261329o39a5e777w5bc39ad5251b4ecb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:25021 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932130AbWCZV3g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Mar 2006 16:29:36 -0500
Received: by pproxy.gmail.com with SMTP id x31so1172266pye
        for <linux-ide@vger.kernel.org>; Sun, 26 Mar 2006 13:29:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux RAID Mailing List <linux-raid@vger.kernel.org>
Cc: Neil Brown <neilb@suse.de>

It is my belief that the linux elevators are not optimized for
raid throughout.

Basically when IO initiator generates IO over a single disk he can control
the amount of IOs and this way control IOs latencies.

This is not the case in raided volumes.

Example:

An IO initiator intiates bulks of asynchronous IOs over a raided
volume. since the user does not know the target destination of each IO
he
might cause imbalance over the disks. one disk may become overflooded
with IOs while the other is may starve. So eventually we are ending with
a non balaned raided volume in terms of bad latencies.

I am trying to deal with this problem by fixing the deadline elevator code
to batch IOs , meaning , when n IOs are reaching the disk, each m deadlined
IOs are sorted and then dispatced.

I would appreciate any coments in this matter.

thank you
Raz Ben Yehuda
