From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 25/64] ide: use standard timing for XFER_PIO_SLOW mode in ide_timing_compute()
Date: Tue, 19 Jan 2010 21:25:25 +0100
Message-ID: <201001192125.25358.bzolnier@gmail.com>
References: <20100119.012526.203639880.davem@davemloft.net> <4B560B41.6080205@ru.mvista.com> <20100119.114816.78180589.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58807 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab0ASU1E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 15:27:04 -0500
In-Reply-To: <20100119.114816.78180589.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: sshtylyov@ru.mvista.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 19 January 2010 08:48:16 pm David Miller wrote:
> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Date: Tue, 19 Jan 2010 22:42:57 +0300
> 
> >   But shouldn't this just be merged to "ide: use standard timing for
> >   XFER_PIO_SLOW mode in ide_timing_compute()" since it's the patch that
> >   introduced that check?
> 
> It's fine either way.
> 
> I can break the ide-next-2.6 tree for everyone by rebasing it to
> unwind the 50 or so patches I applied from Bart yesterday to do this,
> but really is that pain worth it since right thing is there in the
> end?

Especially since the new patch is a pure documentation fix
in the practice (the old code happens to work fine anyway)..

--
Bartlomiej Zolnierkiewicz
