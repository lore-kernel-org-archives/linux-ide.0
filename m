From: Nick Pollitt <npollitt@mvista.com>
Subject: Re: [PATCH 1/1] 2.4.32 Fix memory leak in ide-probe
Date: Wed, 24 May 2006 09:21:58 -0700
Message-ID: <200605240921.58638.npollitt@mvista.com>
References: <Pine.LNX.4.10.10605222145180.32622-200000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mgIdE0P0FuczAGx"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:31460 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932377AbWEXQWA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 May 2006 12:22:00 -0400
In-Reply-To: <Pine.LNX.4.10.10605222145180.32622-200000@master.linux-ide.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Nick Pollitt <npollitt@mvista.com>

--Boundary-00=_mgIdE0P0FuczAGx
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 22 May 2006 9:47 pm, Andre Hedrick wrote:
> 
> Nick,
> 
> If it works please forward the results and other information to everyone

On a stock 2.4.32 kernel, with 64M RAM, I can run my laptop out of memory in 
about 24 hours with the cardctl loop mentioned previously.  The memory is all
tied up in size-32 and size-64 caches.

To test the patch I started the cardctl loop last Friday (19th) on a 2.4.32 
with the patch applied.  Today, after 75000+ pcmcia inserts/ejects the size-32 
and size-64 slab caches are still at a reasonable size.  At the beginning of 
the test (fresh reboot) size-32 had 10 total slabs, size-64 had 3.  Now, after 5 days of
continuous testing, size-32 still has 10, and size-64 still has 3.

So I think this patch addresses the issue of the size-32 and size-64 slabs.

...and the test is still running so I can watch the buffer_head cache.

Does this patch look OK to everyone?

Thanks,
Nick




> 
> Cheers,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Mon, 22 May 2006, Nick Pollitt wrote:
> 
> > Andre,  I found this memory leak running a bash loop calling cardctl to insert 
> > and eject a single PCMCIA card continuously.  Over time the slab-32 and slab-64
> > caches had consumed all system memory.  The memory was full of the IDE
> > settings allocated in ide_add_generic_settings.  
> > 
> > It appears that ide_add_generic_settings is getting called for interfaces that
> > aren't present, and there are never any calls to free up those resources.  The
> > check for the presence of the interface was removed in 2.4.19, and this patch
> > rolls back to the previous behavior.
> > 
> > If this looks OK I'd like to ask Marcello to include in the next 2.4 rev.
> > 
> > Thank you,
> > Nick
> > 
> 
> 

--Boundary-00=_mgIdE0P0FuczAGx
Content-Type: text/x-diff;
  charset="iso-8859-6";
  name="ide-memleak-10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ide-memleak-10.patch"

diff -X dontdiff -Nurp pro31-base/drivers/ide/ide-probe.c pro31-x86/drivers/ide/ide-probe.c
--- pro31-base/drivers/ide/ide-probe.c	2006-04-07 08:13:18.000000000 -0700
+++ pro31-x86/drivers/ide/ide-probe.c	2006-05-17 14:40:40.000000000 -0700
@@ -843,29 +843,15 @@ static void init_gendisk (ide_hwif_t *hw
 	add_gendisk(gd);
 
 	for (unit = 0; unit < units; ++unit) {
-#if 1
-		char name[64];
-		ide_add_generic_settings(hwif->drives + unit);
-		hwif->drives[unit].dn = ((hwif->channel ? 2 : 0) + unit);
-		sprintf (name, "host%d/bus%d/target%d/lun%d",
-			(hwif->channel && hwif->mate) ?
-			hwif->mate->index : hwif->index,
-			hwif->channel, unit, hwif->drives[unit].lun);
-		if (hwif->drives[unit].present)
-			hwif->drives[unit].de = devfs_mk_dir(ide_devfs_handle, name, NULL);
-#else
 		if (hwif->drives[unit].present) {
 			char name[64];
-
 			ide_add_generic_settings(hwif->drives + unit);
-			hwif->drives[unit].dn = ((hwif->channel ? 2 : 0) + unit);
 			sprintf (name, "host%d/bus%d/target%d/lun%d",
-				 (hwif->channel && hwif->mate) ? hwif->mate->index : hwif->index,
-				 hwif->channel, unit, hwif->drives[unit].lun);
-			hwif->drives[unit].de =
-				devfs_mk_dir (ide_devfs_handle, name, NULL);
+				(hwif->channel && hwif->mate) ? 
+				hwif->mate->index : hwif->index,
+				hwif->channel, unit, hwif->drives[unit].lun);
+			hwif->drives[unit].de = devfs_mk_dir (ide_devfs_handle, name, NULL);
 		}
-#endif
 	}
 	return;
 

--Boundary-00=_mgIdE0P0FuczAGx--
