From: "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: your mail
Date: Thu, 19 Feb 2004 09:12:02 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.53.0402190907470.30108@chaos>
References: <20040219135212.34779.qmail@web12607.mail.yahoo.com>
Reply-To: root@chaos.analogic.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040219135212.34779.qmail@web12607.mail.yahoo.com>
To: Joilnen Leite <pidhash@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, 19 Feb 2004, Joilnen Leite wrote:

> excuse me friends shcedule_timeout(1) is not a problem
> for spin_lock_irqsave ?
>
> drivers/scsi/ide-scsi.c:897
>
> spin_lock_irqsave(&ide_lock, flags);
> while (HWGROUP(drive)->handler) {
>        HWGROUP(drive)->handler = NULL;
>        schedule_timeout(1);
> }
>
> pub 1024D/5139533E Joilnen Batista Leite
> F565 BD0B 1A39 390D 827E 03E5 0CD4 0F20 5139 533E

What kernel version?  It is very bad. You can't sleep with
a spin-lock being held!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an Intel Pentium III machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.
