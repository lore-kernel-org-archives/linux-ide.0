From: TAKADA Yoshihito <takada@mbf.nifty.com>
Subject: Re: kernel 2.6.25 with ide driver cs5520 does not boot.
Date: Fri, 09 May 2008 11:22:20 +0900 (JST)
Message-ID: <20080509.112220.74748072.takada@mbf.nifty.com>
References: <20080508.165814.197343623.takada@mbf.nifty.com>
	<58cb370e0805080607n4f5de192o5a7371fd0fb1e9f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760930AbYEICZE@vger.kernel.org>
In-Reply-To: <58cb370e0805080607n4f5de192o5a7371fd0fb1e9f8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Thanks for quick reply.

I tried 2.6.26rc1. It hangs same as 2.6.25.
kernel 2.6.26rc1 with cs5520 cannot boot. cs5520 scans ide0 and ide1.
It seems 2nd port DMA base issue was solved.

dmesg is follow:

Uniform Multi-Platform E-EDI driver
ide: Assuming 33MHz system bus speed for PIO modes: override with idebus=xx
Cyrix 5520: IDE controller (0x1078:0x0002 rev 0x00) at  PCI slot 0000:00:12.0
    ide0: BM-DMA at 0x5000-0x5007
    ide1: BM-DMA at 0x5008-0x500f
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 14
hda: max request size: 128KiB
  (hang)

From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: kernel 2.6.25 with ide driver cs5520 does not boot.
Date: Thu, 8 May 2008 15:07:31 +0200

 (snip)

> 2.6.24 contained a bug in calculating DMA base for the second port (thus
> the error message) but it shouldn't affect anything (ide1 is still probed
> according to dmesg, please let me know if there are some devices on ide1
> that are not getting detected).

I seems that this issue was resolved. Thanks.
