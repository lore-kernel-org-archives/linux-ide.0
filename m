From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] [STACK] reduce >3k call path in ide
Date: Wed, 16 Jun 2004 11:49:08 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040616114908.01442f8a.rddunlap@osdl.org>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de>
	<20040615163445.6b886383.rddunlap@osdl.org>
	<200406160911.11985.jolt@tuxbox.org>
	<20040616094737.GA2548@wohnheim.fh-wedel.de>
	<40D01928.1080309@tuxbox.org>
	<20040616100008.GB2548@wohnheim.fh-wedel.de>
	<20040616103741.042f8029.rddunlap@osdl.org>
	<20040616175730.GA15365@wohnheim.fh-wedel.de>
	<20040616111621.4d1fdfff.rddunlap@osdl.org>
	<20040616182910.GC15365@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:41619 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264461AbUFPSwZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jun 2004 14:52:25 -0400
In-Reply-To: <20040616182910.GC15365@wohnheim.fh-wedel.de>
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: jolt@tuxbox.org, akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004 20:29:10 +0200 J=F6rn Engel wrote:

| On Wed, 16 June 2004 11:16:21 -0700, Randy.Dunlap wrote:
| > On Wed, 16 Jun 2004 19:57:30 +0200 J=F6rn Engel wrote:
| >=20
| > | On Wed, 16 June 2004 10:37:41 -0700, Randy.Dunlap wrote:
| > | >=20
| > | > Thanks for the helpful comments.  Here's a corrected patch.
| > |=20
| > | Looks, as if it still leaks memory:
| >=20
| > duh.  fudge.  Thanks.  How's this one?
|=20
| Just four more lines?

OK, Randy, slow down and go to lunch.

Thanks, J=F6rn.



Reduce large stack usage in ide_config() by using kmalloc(),
  down from 0x4a4 bytes to 0x74 bytes (x86-32).
Little whitespace cleanup.
Move function comment block to immediately above the function.
Module loaded and unloaded, otherwise not tested (no hardware).

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=3D
 drivers/ide/legacy/ide-cs.c |  141 ++++++++++++++++++++++++++---------=
---------
 1 files changed, 84 insertions(+), 57 deletions(-)

diff -Naurp ./drivers/ide/legacy/ide-cs.c~idecs_stack ./drivers/ide/leg=
acy/ide-cs.c
--- ./drivers/ide/legacy/ide-cs.c~idecs_stack	2004-05-09 19:32:53.00000=
0000 -0700
+++ ./drivers/ide/legacy/ide-cs.c	2004-06-16 11:01:43.000000000 -0700
@@ -199,6 +199,16 @@ static void ide_detach(dev_link_t *link)
    =20
 } /* ide_detach */
=20
+static int idecs_register(unsigned long io, unsigned long ctl, unsigne=
d long irq)
+{
+    hw_regs_t hw;
+    memset(&hw, 0, sizeof(hw));
+    ide_init_hwif_ports(&hw, io, ctl, NULL);
+    hw.irq =3D irq;
+    hw.chipset =3D ide_pci;
+    return ide_register_hw(&hw, NULL);
+}
+
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
     ide_config() is scheduled to run after a CARD_INSERTION event
@@ -210,84 +220,86 @@ static void ide_detach(dev_link_t *link)
 #define CS_CHECK(fn, ret) \
 do { last_fn =3D (fn); if ((last_ret =3D (ret)) !=3D 0) goto cs_failed=
; } while (0)
=20
-static int idecs_register(unsigned long io, unsigned long ctl, unsigne=
d long irq)
-{
-    hw_regs_t hw;
-    memset(&hw, 0, sizeof(hw));
-    ide_init_hwif_ports(&hw, io, ctl, NULL);
-    hw.irq =3D irq;
-    hw.chipset =3D ide_pci;
-    return ide_register_hw(&hw, NULL);
-}
-
 void ide_config(dev_link_t *link)
 {
     client_handle_t handle =3D link->handle;
     ide_info_t *info =3D link->priv;
     tuple_t tuple;
-    u_short buf[128];
-    cisparse_t parse;
-    config_info_t conf;
-    cistpl_cftable_entry_t *cfg =3D &parse.cftable_entry;
-    cistpl_cftable_entry_t dflt =3D { 0 };
-    int i, pass, last_ret, last_fn, hd, is_kme =3D 0;
+    u_short *tbuf =3D 0;
+    cisparse_t *cisparse =3D 0;
+    config_info_t *cfginfo =3D 0;
+    cistpl_cftable_entry_t *cfg;
+    cistpl_cftable_entry_t *def_cte =3D 0;
+    int i, pass, last_ret =3D 0, last_fn =3D 0, hd, is_kme =3D 0;
     unsigned long io_base, ctl_base;
=20
     DEBUG(0, "ide_config(0x%p)\n", link);
-   =20
-    tuple.TupleData =3D (cisdata_t *)buf;
-    tuple.TupleOffset =3D 0; tuple.TupleDataMax =3D 255;
+
+    tbuf =3D kmalloc(128 * sizeof(u_short), GFP_KERNEL);
+    if (!tbuf) goto err_mem;
+    def_cte =3D kmalloc(sizeof(*def_cte), GFP_KERNEL);
+    if (!def_cte) goto err_mem;
+    memset(def_cte, 0, sizeof(*def_cte));
+    cfginfo =3D kmalloc(sizeof(*cfginfo), GFP_KERNEL);
+    if (!cfginfo) goto err_mem;
+    cisparse =3D kmalloc(sizeof(*cisparse), GFP_KERNEL);
+    if (!cisparse) goto err_mem;
+    cfg =3D &cisparse->cftable_entry;
+
+    tuple.TupleData =3D (cisdata_t *)tbuf;
+    tuple.TupleOffset =3D 0;
+    tuple.TupleDataMax =3D 255;
     tuple.Attributes =3D 0;
     tuple.DesiredTuple =3D CISTPL_CONFIG;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
     CS_CHECK(GetTupleData, pcmcia_get_tuple_data(handle, &tuple));
-    CS_CHECK(ParseTuple, pcmcia_parse_tuple(handle, &tuple, &parse));
-    link->conf.ConfigBase =3D parse.config.base;
-    link->conf.Present =3D parse.config.rmask[0];
+    CS_CHECK(ParseTuple, pcmcia_parse_tuple(handle, &tuple, cisparse))=
;
+    link->conf.ConfigBase =3D cisparse->config.base;
+    link->conf.Present =3D cisparse->config.rmask[0];
=20
     tuple.DesiredTuple =3D CISTPL_MANFID;
     if (!pcmcia_get_first_tuple(handle, &tuple) &&
 	!pcmcia_get_tuple_data(handle, &tuple) &&
-	!pcmcia_parse_tuple(handle, &tuple, &parse))
-	is_kme =3D ((parse.manfid.manf =3D=3D MANFID_KME) &&
-		  ((parse.manfid.card =3D=3D PRODID_KME_KXLC005_A) ||
-		   (parse.manfid.card =3D=3D PRODID_KME_KXLC005_B)));
+	!pcmcia_parse_tuple(handle, &tuple, cisparse))
+	is_kme =3D ((cisparse->manfid.manf =3D=3D MANFID_KME) &&
+		  ((cisparse->manfid.card =3D=3D PRODID_KME_KXLC005_A) ||
+		   (cisparse->manfid.card =3D=3D PRODID_KME_KXLC005_B)));
=20
     /* Configure card */
     link->state |=3D DEV_CONFIG;
=20
     /* Not sure if this is right... look up the current Vcc */
-    CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handl=
e, &conf));
-    link->conf.Vcc =3D conf.Vcc;
-   =20
+    CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(handl=
e, cfginfo));
+    link->conf.Vcc =3D cfginfo->Vcc;
+
     pass =3D io_base =3D ctl_base =3D 0;
     tuple.DesiredTuple =3D CISTPL_CFTABLE_ENTRY;
     tuple.Attributes =3D 0;
     CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
     while (1) {
     	if (pcmcia_get_tuple_data(handle, &tuple) !=3D 0) goto next_entry=
;
-	if (pcmcia_parse_tuple(handle, &tuple, &parse) !=3D 0) goto next_entr=
y;
+	if (pcmcia_parse_tuple(handle, &tuple, cisparse) !=3D 0) goto next_en=
try;
=20
 	/* Check for matching Vcc, unless we're desperate */
 	if (!pass) {
-	    if (cfg->vcc.present & (1<<CISTPL_POWER_VNOM)) {
-		if (conf.Vcc !=3D cfg->vcc.param[CISTPL_POWER_VNOM]/10000)
+	    if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
+		if (cfginfo->Vcc !=3D cfg->vcc.param[CISTPL_POWER_VNOM] / 10000)
 		    goto next_entry;
-	    } else if (dflt.vcc.present & (1<<CISTPL_POWER_VNOM)) {
-		if (conf.Vcc !=3D dflt.vcc.param[CISTPL_POWER_VNOM]/10000)
+	    } else if (def_cte->vcc.present & (1 << CISTPL_POWER_VNOM)) {
+		if (cfginfo->Vcc !=3D def_cte->vcc.param[CISTPL_POWER_VNOM] / 10000)
 		    goto next_entry;
 	    }
 	}
-=09
-	if (cfg->vpp1.present & (1<<CISTPL_POWER_VNOM))
+
+	if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
 	    link->conf.Vpp1 =3D link->conf.Vpp2 =3D
-		cfg->vpp1.param[CISTPL_POWER_VNOM]/10000;
-	else if (dflt.vpp1.present & (1<<CISTPL_POWER_VNOM))
+		cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+	else if (def_cte->vpp1.present & (1 << CISTPL_POWER_VNOM))
 	    link->conf.Vpp1 =3D link->conf.Vpp2 =3D
-		dflt.vpp1.param[CISTPL_POWER_VNOM]/10000;
-=09
-	if ((cfg->io.nwin > 0) || (dflt.io.nwin > 0)) {
-	    cistpl_io_t *io =3D (cfg->io.nwin) ? &cfg->io : &dflt.io;
+		def_cte->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+
+	if ((cfg->io.nwin > 0) || (def_cte->io.nwin > 0)) {
+	    cistpl_io_t *io =3D (cfg->io.nwin) ? &cfg->io : &def_cte->io;
 	    link->conf.ConfigIndex =3D cfg->index;
 	    link->io.BasePort1 =3D io->win[0].base;
 	    link->io.IOAddrLines =3D io->flags & CISTPL_IO_LINES_MASK;
@@ -307,23 +319,24 @@ void ide_config(dev_link_t *link)
 		if (pcmcia_request_io(link->handle, &link->io) !=3D 0)
 			goto next_entry;
 		io_base =3D link->io.BasePort1;
-		ctl_base =3D link->io.BasePort1+0x0e;
+		ctl_base =3D link->io.BasePort1 + 0x0e;
 	    } else goto next_entry;
 	    /* If we've got this far, we're done */
 	    break;
 	}
-=09
+
     next_entry:
-	if (cfg->flags & CISTPL_CFTABLE_DEFAULT) dflt =3D *cfg;
+	if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
+	    memcpy(def_cte, cfg, sizeof(*def_cte));
 	if (pass) {
 	    CS_CHECK(GetNextTuple, pcmcia_get_next_tuple(handle, &tuple));
 	} else if (pcmcia_get_next_tuple(handle, &tuple) !=3D 0) {
 	    CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(handle, &tuple));
-	    memset(&dflt, 0, sizeof(dflt));
+	    memset(def_cte, 0, sizeof(*def_cte));
 	    pass++;
 	}
     }
-   =20
+
     CS_CHECK(RequestIRQ, pcmcia_request_irq(handle, &link->irq));
     CS_CHECK(RequestConfiguration, pcmcia_request_configuration(handle=
, &link->conf));
=20
@@ -336,25 +349,27 @@ void ide_config(dev_link_t *link)
     outb(0x02, ctl_base);
=20
     /* special setup for KXLC005 card */
-    if (is_kme) outb(0x81, ctl_base+1);
+    if (is_kme)
+	outb(0x81, ctl_base+1);
=20
     /* retry registration in case device is still spinning up */
     for (hd =3D -1, i =3D 0; i < 10; i++) {
 	hd =3D idecs_register(io_base, ctl_base, link->irq.AssignedIRQ);
 	if (hd >=3D 0) break;
 	if (link->io.NumPorts1 =3D=3D 0x20) {
-	    outb(0x02, ctl_base+0x10);
-	    hd =3D idecs_register(io_base+0x10, ctl_base+0x10,
+	    outb(0x02, ctl_base + 0x10);
+	    hd =3D idecs_register(io_base + 0x10, ctl_base + 0x10,
 				link->irq.AssignedIRQ);
 	    if (hd >=3D 0) {
-		io_base +=3D 0x10; ctl_base +=3D 0x10;
+		io_base +=3D 0x10;
+		ctl_base +=3D 0x10;
 		break;
 	    }
 	}
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/10);
     }
-   =20
+
     if (hd < 0) {
 	printk(KERN_NOTICE "ide-cs: ide_register() at 0x%3lx & 0x%3lx"
 	       ", irq %u failed\n", io_base, ctl_base,
@@ -363,24 +378,36 @@ void ide_config(dev_link_t *link)
     }
=20
     info->ndev =3D 1;
-    sprintf(info->node.dev_name, "hd%c", 'a'+(hd*2));
+    sprintf(info->node.dev_name, "hd%c", 'a' + (hd * 2));
     info->node.major =3D ide_major[hd];
     info->node.minor =3D 0;
     info->hd =3D hd;
     link->dev =3D &info->node;
     printk(KERN_INFO "ide-cs: %s: Vcc =3D %d.%d, Vpp =3D %d.%d\n",
-	   info->node.dev_name, link->conf.Vcc/10, link->conf.Vcc%10,
-	   link->conf.Vpp1/10, link->conf.Vpp1%10);
+	   info->node.dev_name, link->conf.Vcc / 10, link->conf.Vcc % 10,
+	   link->conf.Vpp1 / 10, link->conf.Vpp1 % 10);
=20
     link->state &=3D ~DEV_CONFIG_PENDING;
+    kfree(cisparse);
+    kfree(cfginfo);
+    kfree(def_cte);
+    kfree(tbuf);
     return;
-   =20
+
+err_mem:
+    printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\n"=
);
+    goto failed;
+
 cs_failed:
     cs_error(link->handle, last_fn, last_ret);
 failed:
+    kfree(cisparse);
+    kfree(cfginfo);
+    kfree(def_cte);
+    kfree(tbuf);
+
     ide_release(link);
     link->state &=3D ~DEV_CONFIG_PENDING;
-
 } /* ide_config */
=20
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
