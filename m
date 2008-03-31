From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 5/5] falconide/q40ide: add ->atapi_*put_bytes and ->ata_*put_data methods
Date: Mon, 31 Mar 2008 22:41:06 +0100
Message-ID: <200803312341.08271.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758417AbYCaVlt@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>
List-Id: linux-ide@vger.kernel.org

Hi,

On Monday 31. March 2008, Alan Cox wrote:

> > Yes, the data on the disk is stored byte-swapped.
> > So it's only the drive ID and packet commands that should be swapped.
>
> If you are storing the data on disk byte swapped then reverse the logic
> in the driver so you don't need hacks for un-swapping commands and write
> a bytesewap device mapper layer in the right place. Then you can even
> move disks around.

That would require an additional data copy and a double byteswap on machines 
which are not that fast in first place...

bye, Roman
