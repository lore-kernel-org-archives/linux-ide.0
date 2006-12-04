From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Disabling SATA hardware interrupts
Date: Mon, 4 Dec 2006 14:47:07 +0000
Message-ID: <20061204144707.2b0787f7@localhost.localdomain>
References: <c70dbe410612040308o5cbe878cue4ce98c088776afc@mail.gmail.com>
	<20061204120350.3bbd520d@localhost.localdomain>
	<c70dbe410612040534y6a357064m7a0d28d3d40fa4ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:60620 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S936912AbWLDOkn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Dec 2006 09:40:43 -0500
In-Reply-To: <c70dbe410612040534y6a357064m7a0d28d3d40fa4ab@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thinus Viljoen <thinus.viljoen@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, 4 Dec 2006 15:34:09 +0200
"Thinus Viljoen" <thinus.viljoen@gmail.com> wrote:

> How do I go about setting/clearing this nIEN bit from my own module?
> Open a handle to /dev/sda and calling some or other IOCTL, perhaps? (
> I haven't accessed the HDD on this low level before, so I would
> appreciate some details, or perhaps a small example).

The ATA layer manages nIEN per command itself so you'll need to do a
rework of parts of the ATA layer. Alternatively you could just make sure
you've flushed all outstanding I/O before doing any realtime work.

