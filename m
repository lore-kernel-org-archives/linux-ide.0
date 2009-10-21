From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with SSD
Date: Wed, 21 Oct 2009 21:34:27 +0200
Message-ID: <19167.25155.379665.259129@pilspetsen.it.uu.se>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:51063 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754844AbZJUTeb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Oct 2009 15:34:31 -0400
In-Reply-To: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

Mikulas Patocka writes:
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

Have you checked if the libata pata_cmd64x driver also has this
problem?  I know that it works fine on the Ultra 5 with just a
single pata drive, but the pata+ssd combo may not have been tested.
