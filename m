From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 0/3] Add GD-Rom support to the SEGA Dreamcast
Date: Sun, 16 Dec 2007 13:13:48 +0900
Message-ID: <20071216041348.GB11113@linux-sh.org>
References: <8b67d60712151620s331281f4s7e150aacacff4400@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764296AbXLPEOQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8b67d60712151620s331281f4s7e150aacacff4400@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian McMenamin <lkmladrian@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Dec 16, 2007 at 12:20:54AM +0000, Adrian McMenamin wrote:
> This device is electrically compatible with ATA-3 IDE CD drives but
> implements a proprietary packet interface. There have been previous
> Dreamcast CD drivers around but this is new code and uses DMA as
> opposed to PIO for reads.
> 
> It also supports reading the proprietary GD Rom format disks.
> 
> The driver will live as drivers/sh/gdrom/gdrom.c
> 
No, the driver will live in drivers/cdrom if that's the API that you
depend on. The only things in drivers/sh are SH-specific bus support
code, it is not a dumping ground for unrelated drivers.
