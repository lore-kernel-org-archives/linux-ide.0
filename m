From: Oliver Bausinger <bausi@bausi.org>
Subject: Re: sata_sil problems (lockup at boottime)
Date: Tue, 7 Dec 2004 09:40:30 +0100
Message-ID: <200412070940.30361.bausi@bausi.org>
References: <41B2499E.1080905@nv-systems.net> <58cb370e04120508104243799a@mail.gmail.com> <41B4DA37.5060209@nv-systems.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from everest.mathematik.uni-tuebingen.de ([134.2.62.220]:51879 "EHLO
	everest.mathematik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S261661AbULGIkc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Dec 2004 03:40:32 -0500
Received: from kasbek.mathematik.uni-tuebingen.de (kasbek.mathematik.uni-tuebingen.de [134.2.62.226])
	by everest.mathematik.uni-tuebingen.de (Postfix) with ESMTP id BEF594B422
	for <linux-ide@vger.kernel.org>; Tue,  7 Dec 2004 09:40:31 +0100 (CET)
In-Reply-To: <41B4DA37.5060209@nv-systems.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Am Montag 06 Dezember 2004 23:16 schrieb Gerald Hopf:
>
> I also tried the depreciated siimage driver (thanks to the
> CONFIG_BLK_DEV_IDE_SATA tip, i didn't notice this before and had the
> same problems) with kernel 2.6.9,
> works flawless (as far as i can tell from such a short test, hdparm -t =
> 60MB/s). No strange IRQ disabled errors during bootup. Flawless of
> course only if you ignore that it takes AGES until it finally gives up
> probing the second SATA port. I know someone who bought a second SATA
> harddrive just because booting took so long!
>

After some tests, I'm quite sure that the siimage is broken too with this 
drive although it boots and works like Gerald describes.

When md5sum a file, read bigger amounts of data from the disk and 
md5sum it again, the checksum changed. I can reproduce this permanently with a 
number of files. 
When I e2fsck the partition, I get bitmap differences. There's an error at 
bootup which says something about a Drive Error when booting. I'll post the 
exact error when I get back to the machine.

Greetings
Bausi
