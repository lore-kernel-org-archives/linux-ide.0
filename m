From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tp_smapi conflict with IDE, hdaps
Date: Tue, 13 Dec 2005 19:18:24 +0000
Message-ID: <1134501504.11732.120.camel@localhost.localdomain>
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
	 <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
	 <41840b750512131041i5ae5f021h29eed3492bad88ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932294AbVLNKWn@vger.kernel.org>
In-Reply-To: <41840b750512131041i5ae5f021h29eed3492bad88ca@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>, Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Maw, 2005-12-13 at 20:41 +0200, Shem Multinymous wrote:
> Meanwhile, I found out that with this drive, "hdparm -E" does affect
> CD-R discs

That is expected behaviour. DVD speed is controlled by different
interfaces
