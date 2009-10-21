From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Wed, 21 Oct 2009 19:01:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0910211857140.27544@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
 <19167.25155.379665.259129@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12391 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755045AbZJUXBX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Oct 2009 19:01:23 -0400
In-Reply-To: <19167.25155.379665.259129@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

>  > This patch serializes the operation for CMD646 and 643 (I didn't test
>  > CMD643 but it may have the same hw bug too because it's earlier design).
>  > CMD649 is good. I don't know anything about CMD 648.
> 
> Have you checked if the libata pata_cmd64x driver also has this
> problem?  I know that it works fine on the Ultra 5 with just a
> single pata drive, but the pata+ssd combo may not have been tested.

I have tried libata driver now --- I see no data corruption but I've got 
this error under the same operation (both channels reading):

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: BMDMA stat 0x24
ata1.00: cmd c8/00:10:10:c8:d9/00:00:00:00:00/e0 tag 0 dma 8192 in
         res 50/00:00:1f:c8:d9/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
ata1.00: status: { DRDY }
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
ata1: soft resetting link
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
ata1.00: configured for MWDMA2
ata1: EH complete

(ata1 is the primary channel)
--- I'm wondering, what does it mean? status 0x50 is OK. DMA status 0x24 
is also OK. What was the problem there?

Mikulas
