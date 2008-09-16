From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Wed, 17 Sep 2008 01:39:25 +0400
Message-ID: <48D0278D.6090807@ru.mvista.com>
References: <48CA8BEE.1090305@ru.mvista.com>	<20080913.005904.07457691.anemo@mba.ocn.ne.jp>	<48CAA498.9090804@ru.mvista.com> <20080913.213226.106262199.anemo@mba.ocn.ne.jp> <48D0220B.4090601@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:25974 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751417AbYIPVjd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Sep 2008 17:39:33 -0400
In-Reply-To: <48D0220B.4090601@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Hello, I wrote:

> Thats wrong -- According t the spec. the bit should be set following=20
> any assertion of INTRQ on IDE bus (possibly not at once though --=20
> after flushing FIFO). Well, no wonder with such description of the=20
> bits as:
>
>
> INT_IDE (RWC) [Interrupt]
> Is =931=94 when data transfer completes. This bit is cleared by writi=
ng=20
> =931=94 to it.
> When this bit is set to =911=92, the following bits of the ATA Interr=
upt=20
> Controller Register will be
> reset: bits [15:8] (Mask Address Error INT, Mask Reach Multiple INT,=20
> Mask DEV
> Timing Error, Mask Ultra DMA DEV Terminate, Mask Timer INT, Mask Bus=20
> Error, Mask
> Data Transfer End, Mask Host INT), and bits [1:0] (Data Transfer End,=
=20
> Host INT).

   Forgot to mentiom that from this description it's not even clear if=20
the int_ctl register bits are cleared when 1 is written to this bit or=20
when the controller sets it. :-)

MBR, Sergei


