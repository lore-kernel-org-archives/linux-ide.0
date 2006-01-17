From: James McMechan <James_McMechan@hotmail.com>
Subject: Re: problems with siimage.c
Date: Tue, 17 Jan 2006 12:45:10 -0800
Message-ID: <200601171245.10163.James_McMechan@hotmail.com>
References: <200601151743.52068.James_McMechan@hotmail.com> <58cb370e0601170434w545671a9l7f3fc4df472bad07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail10.mdx.safepages.com ([216.127.133.33]:45575 "EHLO
	mail10.mdx.safepages.com") by vger.kernel.org with ESMTP
	id S932436AbWAQUpK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jan 2006 15:45:10 -0500
In-Reply-To: <58cb370e0601170434w545671a9l7f3fc4df472bad07@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 17 January 2006 04:34 am, Bartlomiej Zolnierkiewicz wrote:
....
> > irq 10: nobody cared!
> 
> Part about probing ide9 is missing from the above log.
> 
> What kernel version are you using?
> 
> Please fill a bug at http://bugzilla.kernel.org and at least provide some
> minimal useful data (full dmesg, 'cat /proc/interrupts' output, kernel 
config).
> 
> Bartlomiej
Sorry about that, it occured on 2.6.12.5 2.6.14.2 and a fresh kernel.org 
2.6.15.1 kernel 
ide9 just had after all 8 copies of __report_bad_irq
Probing IDE interface ide9...
hds: Maxtor 6B200R0, ATA DISK drive
ide9 at 0xd08820c0-0xd08820c7,0xd08820ca on irq 10
hds: max request size: 64KiB
hds: 398297088 sectors (203928 MB) w/16384KiB Cache, CHS=24792/255/63, 
UDMA(133)
hds: cache flushes supported
 hds: unknown partition table

and the "Disabling IRQ #10" messages did not occur after that point.

It is now bug 5911
dmesg, /proc/interrupts, zcat /proc/config.gz included

James McMechan
