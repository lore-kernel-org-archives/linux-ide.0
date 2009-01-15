From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Another Seagate SATA drive with the NCQ+FLUSH_CACHE bug
Date: Wed, 14 Jan 2009 21:34:51 -0800
Message-ID: <20090114213451.3395e8d1.akpm@linux-foundation.org>
References: <f73f7ab80901131154n2a734a50h21b0aeadf3daab9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40454 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751498AbZAOFez (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 00:34:55 -0500
In-Reply-To: <f73f7ab80901131154n2a734a50h21b0aeadf3daab9c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle Moffett <kyle@moffetthome.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

(cc linux-ide)

On Tue, 13 Jan 2009 14:54:51 -0500 "Kyle Moffett" <kyle@moffetthome.net> wrote:

> I've got a 250GB Seagate Barracuda 7200.10 (ST3250820AS) with firmware
> 3.AAE on it here that seems to suffer from the same problem hang
> problem as a number of similar seagate drives.  What information do I
> need to provide to get it added to the blacklist?  Beyond that I'm
> also going through seagate support to try to get a firmware upgrade
> for the thing, as performance without NCQ tends to be not-so-good.
> 
> Kernel messages of the SATA error below (it's on an ICH controller of
> some variety).
> 
> Cheers,
> Kyle Moffett
> 
> [100226.331199] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> [100226.331241] ata1.01: cmd ea/00:00:00:00:00/00:00:00:00:00/b0 tag 0
> [100226.331244]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)
> [100226.331821] ata1.01: status: { DRDY }
> [100231.371102] ata1: link is slow to respond, please be patient (ready=0)
> [100236.353120] ata1: device not ready (errno=-16), forcing hardreset
> [100236.353156] ata1: soft resetting link
> [100241.551827] ata1: link is slow to respond, please be patient (ready=0)
> [100246.367827] ata1: SRST failed (errno=-16)
> [100246.367859] ata1: soft resetting link
> [100251.563827] ata1: link is slow to respond, please be patient (ready=0)
> [100256.377083] ata1: SRST failed (errno=-16)
> [100256.377116] ata1: soft resetting link
> [100261.575827] ata1: link is slow to respond, please be patient (ready=0)
> [100291.423827] ata1: SRST failed (errno=-16)
> [100291.423861] ata1: soft resetting link
> [100296.451826] ata1: SRST failed (errno=-16)
> [100296.451855] ata1: reset failed, giving up
> [100296.451881] ata1.00: disabled
> [100296.451906] ata1.01: disabled
> [100296.451950] ata1: EH complete

