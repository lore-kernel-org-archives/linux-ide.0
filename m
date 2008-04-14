From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.25-rc8-mm1: Intel SATA boot failure
Date: Sun, 13 Apr 2008 19:05:56 -0700
Message-ID: <20080413190556.69ed0dde.akpm@linux-foundation.org>
References: <20080401213214.8fbb6d6b.akpm@linux-foundation.org>
	<47F56363.4090002@imap.cc>
	<20080403161733.c05dac53.akpm@linux-foundation.org>
	<4802A538.9040107@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42429 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753776AbYDNCGg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Apr 2008 22:06:36 -0400
In-Reply-To: <4802A538.9040107@imap.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, Steven French <sfrench@us.ibm.com>

On Mon, 14 Apr 2008 02:28:40 +0200 Tilman Schmidt <tilman@imap.cc> wrote:

> Final report, seeing -mm2 is out:
> 
> - Netconsole works. (grumblestupidsusefirewallgrumble)
> 
> - The hang during boot only happens with kernels compiled with
>   CONFIG_CIFS_EXPERIMENTAL=y
>   It also doesn't always happen at the same point in the boot sequence.
>   I'm suspecting it might be triggered by some network packet.
>   Anyway, it's obviously *not* a SATA problem.
>   (That was just me jumping to conclusions, because ...)

I don't remember seeing a report of the CIFS hang.

It might be caused by
bkl-removal-convert-cifs-over-to-unlocked_ioctl.patch, but it's hard to see
how that could affect things before userspace has started.

> - That leaves only the messages
> 
>   ata1: port is slow to respond, please be patient (Status 0x80)
>   ata1: COMRESET failed (errno=-16)
> 
>   and accompanying delays during boot, for each installed SATA disk.
>   I'll try to find the time to retest this with 2.6.25-rc8-mm2.

That would be good, thanks.
