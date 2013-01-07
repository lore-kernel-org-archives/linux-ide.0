From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Ask for help with "qc timeout" and "failed to read log page 10h"
Date: Sun, 06 Jan 2013 22:02:31 -0600
Message-ID: <50EA48D7.7000606@gmail.com>
References: <CACna6rxYU3Gap30nVbi8bXpxHF2pToPUUd-ckg0-40kT0FR7VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45126 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab3AGECf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2013 23:02:35 -0500
Received: by mail-ie0-f169.google.com with SMTP id c14so23053457ieb.28
        for <linux-ide@vger.kernel.org>; Sun, 06 Jan 2013 20:02:34 -0800 (PST)
In-Reply-To: <CACna6rxYU3Gap30nVbi8bXpxHF2pToPUUd-ckg0-40kT0FR7VQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: linux-ide@vger.kernel.org

On 01/06/2013 02:59 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
> I'm using old notebook (coming from about 2008) and recently
> experienced my first problem with the harddrive. There is one file I
> can not fully read. It's size is 4.4GB, but after copying 3.4GB I get
> that errors in dmesg and copying hangs.
>
> This is the only case where I experience this issue. As long as I
> don't touch that problematic file I don't see any problems/errors.
>
> Is this possible some part of the file was saved on a bad block of my
> hard drive? Can this mean some problem with the driver scanning for
> the bad blocks? Or could that be just an accident that block became a
> bad one after using it (when it was OK)?
>
> EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (nul=
l)
> ata1.00: qc timeout (cmd 0x2f)
> ata1: failed to read log page 10h (errno=3D-5)
> ata1.00: exception Emask 0x1 SAct 0x3 SErr 0x0 action 0x6 frozen
> (... see dmesg.txt)
>

 From the dmesg output (specifically the UNC bit) it looks like the=20
drive is reporting it is unable to read a number of sectors. I would=20
back up all important data possible from it and replace it ASAP.

Not sure what you mean by "the driver scanning for the bad blocks".
