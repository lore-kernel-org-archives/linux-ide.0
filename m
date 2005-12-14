From: Shem Multinymous <multinymous@gmail.com>
Subject: Re: tp_smapi conflict with IDE, hdaps
Date: Wed, 14 Dec 2005 17:03:10 +0200
Message-ID: <41840b750512140703q5c45417ag31dc79ee30d589e3@mail.gmail.com>
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
	 <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
	 <41840b750512131041i5ae5f021h29eed3492bad88ca@mail.gmail.com>
	 <1134501504.11732.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932609AbVLNPDM@vger.kernel.org>
In-Reply-To: <1134501504.11732.120.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>, Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 12/13/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-12-13 at 20:41 +0200, Shem Multinymous wrote:
> > Meanwhile, I found out that with this drive, "hdparm -E" does affect
> > CD-R discs
> That is expected behaviour. DVD speed is controlled by different
> interfaces

Duh! It's set via SET_STREAMING instead of SELECT_SPEED. There are
even a couple of (rejected?) kernel patches [1][2] and a userspace
tool [3], though neither hdparm nor eject know about it.

Good, so CD/DVD speed is none of tp_smapi's business. Thanks for the info!

  Shem

[1] http://lkml.org/lkml/2005/8/21/55
[2] http://seclists.org/lists/linux-kernel/2005/Aug/7393.html
[3] http://safari.iki.fi/speedcontrol.c
