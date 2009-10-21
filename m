From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with SSD
Date: Wed, 21 Oct 2009 21:39:24 +0200
Message-ID: <200910212139.24675.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:13931 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbZJUTkS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Oct 2009 15:40:18 -0400
Received: by gv-out-0910.google.com with SMTP id r4so852466gve.37
        for <linux-ide@vger.kernel.org>; Wed, 21 Oct 2009 12:40:22 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

On Wednesday 21 October 2009 20:55:28 Mikulas Patocka wrote:
> Hi
> 
> This patch fixes a data corruption when SSD is connected to Ultra 5.
> 
> Mikulas
> 
> --
> 
> Serialize CMD643 and CMD646 to fix a hardware bug with SSD
> 
> CMD646 corrupts data on concurrent transfers on both channels when IDE SSD is
> connected to one of the channels.
> 
> Setup that demonstrates this hardware bug: Ultra 5, onboard CMD646, rev 3.
> /dev/hda is 8GB Seagate ST38410A in MWDMA2
> /dev/hdd is 32GB SSD SiliconHardDisk in MWDMA2
> 
> - When reading /dev/hdd (for example with dd or fsck), reads from /dev/hda
>   are corrupted, there are twiddled single bits 1->0 and some full 32-bit
>   words corrupted, sometimes commands fail (which switches /dev/hda to
>   PIO mode but the corruptions happen even in PIO).
> - Reads from /dev/hdd don't seem to be corrupted (i.e. fsck passes fine).
> - When I connected normal rotating harddisk to /dev/hdd, there was no
>   corruption, so the corruption is something specific to SSD.
> - I tried the same setup on a PCI card with CMD649 and saw no corruption.
> 
> This patch serializes the operation for CMD646 and 643 (I didn't test
> CMD643 but it may have the same hw bug too because it's earlier design).
> CMD649 is good. I don't know anything about CMD 648.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Seems like SSD (simply by being faster) triggers some race condition that
hardware has tolerated in the past and since we used to always serialize
operation for CMD646 before:

commit e01698aed04811b9a9c4f8d54b73cb182757063d           
Author: David S. Miller <davem@davemloft.net>             
Date:   Sun Jun 21 22:48:03 2009 -0700

    ide cmd64x: Remove serialize setting.

it went undetected until now..
