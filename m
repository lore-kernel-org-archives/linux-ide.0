From: Shem Multinymous <multinymous@gmail.com>
Subject: Re: tp_smapi conflict with IDE, hdaps
Date: Tue, 13 Dec 2005 17:29:28 +0200
Message-ID: <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:30356 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964989AbVLMP3j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Dec 2005 10:29:39 -0500
Received: by zproxy.gmail.com with SMTP id 34so1746100nzf
        for <linux-ide@vger.kernel.org>; Tue, 13 Dec 2005 07:29:38 -0800 (PST)
In-Reply-To: <1134486203.11732.60.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>, Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org

Hi,

On 12/13/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-12-13 at 16:35 +0200, Shem Multinymous wrote:
> > Evidently, the SMAPI BIOS sends some ATA command to the drive. If the
> > kernel is accessing the drive at the same time (e.g., an ongoing "cat
> > /dev/scd0"), the machine hangs.
>
> You will need to find out the command.

Sure, that would be ideal. But how? You can't get that from the SMAPI
BIOS - it's totally opaque. You just write a constant to port 0xB2,
which triggers an SMI; the BIOS merrily does its thing in SMM and
returns; you see the final results in the CPU registers.

> There are standard commands for this so they ought to work. If not we need to
> know why, who makes the drive used etc

ThinkPad T43 BIOS 1.24, Hitahi HTS726060M9AT00 firmware MH4OA6GA. No
idea how to proceed beyond this.

The thing is, there *is* a working interface, which is also used by
the Windows drivers...


> Trying to arbitrate libata access with unknown bios behaviour isn't going to have a
> sane resolution.

Why? BTW, isn't this similar to the queue freeze functionality needed
by the disk park part of the ThinkPad HDAPS?


> > with the recently added HDAPS accelerometer driver. Both drivers read
> > their data from the same ports (0x1604-0x161F), which implement a
> > query-reponse transaction interface, so both drivers talking to the
> > hardware simultaneously will wreak havoc. Some synchronization is
> > needed, and a way to address the request_region conflict.
> >
> > What is standard procedure for resolving such conflicts?
>
> You probably want a low level driver that just arbitrates the interface
> and implements the basic query/response transaction interface and
> locking and then is called by both HDAPS and your driver (and no doubt
> other future drivers talking to that controller). It can thene export
> the interface to both drivers.

We don't understand the controller interface sufficiently well to
fully abstract it (no specs, and the two conflicting drivers do things
somewhat differently), so for now the low-level driver may only handle
locking... Is there an easier way to just share a mutex?

Anyway, can you point out a minimal example (or two) of such low-level
drivers in the current kernel, so I can imitate the recommended
interface convention?

  Shem
