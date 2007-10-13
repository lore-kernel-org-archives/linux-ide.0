From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.23-mm1
Date: Sat, 13 Oct 2007 11:18:53 -0700
Message-ID: <20071013111853.7e67c6c3.akpm@linux-foundation.org>
References: <20071011213126.cf92efb7.akpm@linux-foundation.org>
	<20071012013729.ada2127b.akpm@linux-foundation.org>
	<64bb37e0710130101y7fb8e4c0lf214fd821e8305ed@mail.gmail.com>
	<4710A407.3070000@garzik.org>
	<64bb37e0710130503haa66d6eu93e75ecdc78ac866@mail.gmail.com>
	<4710B7C5.5050403@garzik.org>
	<64bb37e0710130732p303547e3n54cfa9dac34c53b5@mail.gmail.com>
	<64bb37e0710130740u78613f83wbd4f43d073bbe13d@mail.gmail.com>
	<64bb37e0710130813le68c48dve36f8473b197b84b@mail.gmail.com>
	<47110500.8050503@garzik.org>
	<64bb37e0710131105m7c64fca0kb71f3955170e8bec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762873AbXJMSTf@vger.kernel.org>
In-Reply-To: <64bb37e0710131105m7c64fca0kb71f3955170e8bec@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>
List-Id: linux-ide@vger.kernel.org

On Sat, 13 Oct 2007 20:05:19 +0200 "Torsten Kaiser" <just.for.lkml@googlemail.com> wrote:

> The only thing I noted during load testing (updating Gentoo ==
> compiling and installing) was, that there seems to be memory leak.
> After ~2h 2.5 of my 4Gb where gone. But there where to many things
> going on to pinpoint it... (NFSv4 over eth1394?)

Please send /proc/meminfo and /proc/slabinfo after the leak has been
happening for a while.

Sometimes `echo m > /proc/sysrq_trigger ; dmesg -s 1000000' will
provide useful info.

The page-owner code can pinpoint a leak source.  See
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.23/2.6.23-mm1/broken-out/page-owner-tracking-leak-detector.patch

Enable CONFIG_DEBUG_SLAB_LEAK, check out /proc/slab_allocators
