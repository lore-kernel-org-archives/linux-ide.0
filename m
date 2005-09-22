From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC/BUG?] ide_cs's removable status
Date: Thu, 22 Sep 2005 14:39:42 +0100
Message-ID: <1127396382.18840.79.camel@localhost.localdomain>
References: <1127319328.8542.57.camel@localhost.localdomain>
	 <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca>
	 <1127327243.18840.34.camel@localhost.localdomain>
	 <20050921192932.GB13246@flint.arm.linux.org.uk>
	 <1127347845.18840.53.camel@localhost.localdomain>
	 <20050922102221.GD16949@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030310AbVIVNNe@vger.kernel.org>
In-Reply-To: <20050922102221.GD16949@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Richard Purdie <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Iau, 2005-09-22 at 11:22 +0100, Russell King wrote:
> If you have a CF adapter which behaves as you describe above, could
> you please check what happens as far as PCMCIA goes when you unplug
> the CF card - particularly what happens to cardctl status / cardctl
> ident ?

If I remove the CF card I get garbage reported. I don't however get a
card plug/unplug event. On the other card I have I get a card
plug/unplug event. The pcmcia ide floppy (40MB clik! drive if anyone
wants to play) I have always shows up as present. It triggers the same
hotplug behaviour being complained about as far as I can see and
correctly so.

I dug out some old emails - GNOME does indeed handle this correctly
using HAL and the recursive probing problem is true for all removable
media types. HAL handles this correctly although David Zeuthen wasn't
exactly happy with the kernel behaviour.

So I'm definitely against removing drive->removable when it should be
set, although its less serious than 2.4 because we do more flushing
anyway. There do seem to be a lot of people who would rather it didnt
always generate hotplug events when rescanning partitions. Perhaps we
need a ->same_media() check if the partitions match the old ones ?

Alan
