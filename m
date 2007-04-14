From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Sat, 14 Apr 2007 15:46:55 +0300 (EEST)
Message-ID: <46139.192.168.9.10.1176554815.squirrel@ncircle.nullnet.fi>
References: <200704140927.l3E9RkXu023370@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:32921 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965513AbXDNMrB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Apr 2007 08:47:01 -0400
In-Reply-To: <200704140927.l3E9RkXu023370@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org


> On Sat, 14 Apr 2007 10:13:12 +0300 (EEST), Tomi Orava wrote:
>>I'm currently running with FC6 2990 kernel, which is based on
>>2.6.21-rc3-git10 and contains also your 1.5Gbps limit patch and Promise
>>Sata300TX4 port enumeration patch (does anybody know what might be the
>>reason that port enumeration patch has not been accepted in to main line
>>?).
>
> Because that patch hasn't been submitted to linux-ide,
> Jeff, or me?

Hmm, I quess it was submitted only to kernel mailing-list.

> I've seen fairly old discussions about the enumeration
> order issue on 4-port cards, but no patches.

It seems that original patch was written by Milan Kupcevic:

http://lkml.org/lkml/2006/2/24/316

I updated the patch for the more current kernel versions (obvious changes):

--- linux-2.6.20.i686/drivers/ata/sata_promise.c        2007-04-13
16:34:26.000000000 +0300
+++ linux-2.6.20.i686/drivers/ata/sata_promise.c.mod    2007-04-13
16:39:29.000000000 +0300
@@ -928,8 +928,13 @@
                /* Fall through */
        case board_20319:
                        probe_ent->n_ports = 4;
-               pdc_ata_setup_port(&probe_ent->port[2], base + 0x300, base
+ 0x600);
-               pdc_ata_setup_port(&probe_ent->port[3], base + 0x380, base
+ 0x700);
+               // pdc_ata_setup_port(&probe_ent->port[2], base + 0x300,
base + 0x600);
+               // pdc_ata_setup_port(&probe_ent->port[3], base + 0x380,
base + 0x700);
+
+                pdc_ata_setup_port(&probe_ent->port[0], base + 0x380,
base + 0x700);
+                pdc_ata_setup_port(&probe_ent->port[1], base + 0x280,
base + 0x500);
+                pdc_ata_setup_port(&probe_ent->port[2], base + 0x200,
base + 0x400);
+                pdc_ata_setup_port(&probe_ent->port[3], base + 0x300,
base + 0x600);
                break;
        case board_2057x:
                hp->flags |= PDC_FLAG_GEN_II;
--------------------------------------------------------------------

And the above patch seems to work properly on my machine.

00:0e.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA
300 TX4) (rev 02)
        Subsystem: Promise Technology, Inc. PDC40718 (SATA 300 TX4)
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 16
        I/O ports at ec00 [size=128]
        I/O ports at e000 [size=256]
        Memory at fe900000 (32-bit, non-prefetchable) [size=4K]
        Memory at fe800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fe600000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2

Regards,
Tomi Orava


