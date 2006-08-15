From: Len Brown <len.brown@intel.com>
Subject: Re: What determines which interrupts are shared under Linux?
Date: Tue, 15 Aug 2006 10:47:43 -0400
Message-ID: <200608151047.44255.len.brown@intel.com>
References: <44E1D760.6070600@atipa.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:14037 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030324AbWHOOq6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 10:46:58 -0400
In-Reply-To: <44E1D760.6070600@atipa.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Heflin <rheflin@atipa.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Tuesday 15 August 2006 10:17, Roger Heflin wrote:
>  22: =A0 =A0 =A0 1165 =A0 =A01704243 =A0 =A0 576247 =A0 =A0 =A0 6796 =
=A0 IO-APIC-level =A0ide2,  ide3

The first thing that determines interrupt sharing is where the physical=
 wires from
the devices are routed.  If these ide controllers are add-on boards, th=
en you
could try moving them between PCI slots -- as the slots generally have =
different
primary interrupt lines.  When the board runs out of unique lines,
they are generally wired to re-use lines on different slots.
The manual for the board will generally tell you how the lines
are routed.

If the devices are using the same physical interrupt line, then it
is not possible for software or BIOS to move them to different
lines.

If these devices are functions in the same device, it is possible
that there is some internal (BIOS or firmware) setting to tell it to
use two interrupt wires instead of one.

Once the wire for the device is determined, it is up to the BIOS
and the OS to program (or not) an interrupt router to assign
the wire to an interrupt input pin.  Your dmesg will tell us
if this is happening on this board.

-Len
