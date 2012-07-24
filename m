From: Borislav Petkov <bp@alien8.de>
Subject: Re: AMD SP5100 SATA low perfomance
Date: Tue, 24 Jul 2012 22:44:54 +0200
Message-ID: <20120724204454.GC5167@liondog.tnic>
References: <CAKu2wpS-9T+jeab4HoBozuxa-7LPVCL3+3JZok-QkTHs6CNksA@mail.gmail.com>
Reply-To: Borislav Petkov <borislav.petkov@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:57335 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722Ab2GXUo5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jul 2012 16:44:57 -0400
Content-Disposition: inline
In-Reply-To: <CAKu2wpS-9T+jeab4HoBozuxa-7LPVCL3+3JZok-QkTHs6CNksA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <brushkoff@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, Jul 24, 2012 at 09:34:57PM +0300, Rus V. Brushkoff wrote:
> Hello All !
> 
>  I'm observing the problem with AMD SP5100 SATA controller. The
> problem appears as very low (2-3MB/s) write perfomance. Reading drops
> too, but not such dramatically (from 100Mb/s on other hardware to
> 50-60Mb/s on SP5100). This problem is checked on several kernels
> (2.6.x, 3.2.x, 3.4.x) including latest 3.5 and with all possible SATA
> BIOS settings. The hardware is Tyan S8005 m/b (latest BIOS v1.03), AMD
> X6 1045T, 8GB ECC memory and Hitachi HTS725050A7E630 drive.  Moreover
> - I've checked 2 different identical boxes - it is 100% reproducable
> on both.

Have you tried doing the same test on the same mobo but with another
drive, possibly by another manufacturer? Do you see the same write
slowdown with the second drive too?

Thanks.

-- 
Regards/Gruss,
    Boris.
