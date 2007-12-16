From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: [PATCH 0/3] Add GD-Rom support to the SEGA Dreamcast
Date: Sun, 16 Dec 2007 00:20:54 +0000
Message-ID: <8b67d60712151620s331281f4s7e150aacacff4400@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

(Apologies if you've already had this. I sent it to lkml etc an hour
ago but it just disappeated into the ether - trying it in smaller
packets this time.)

This patch adds support for the CD drive on the SEGA Dreamcast - the
so-called GD Rom drive.

This device is electrically compatible with ATA-3 IDE CD drives but
implements a proprietary packet interface. There have been previous
Dreamcast CD drivers around but this is new code and uses DMA as
opposed to PIO for reads.

It also supports reading the proprietary GD Rom format disks.

The driver will live as drivers/sh/gdrom/gdrom.c

This has been tested against the latest git in Paul Mundt's 2.6.25
queue as well as 2.6.24-rc5

Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
