From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 04/49] pcmcia: use pcmcia_loop_config in pata and ide drivers
Date: Mon, 13 Oct 2008 19:47:49 +0200
Message-ID: <1223920114-19788-4-git-send-email-linux@dominikbrodowski.net>
References: <20081013173803.GA18569@comet.dominikbrodowski.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:58611 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753288AbYJMRvR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 13:51:17 -0400
In-Reply-To: <20081013173803.GA18569@comet.dominikbrodowski.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Use the config loop helper in pata_pcmcia and ide_cs

CC: Tejun Heo <htejun@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-ide@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/ata/pata_pcmcia.c   |  171 ++++++++++++++++++++-----------------------
 drivers/ide/legacy/ide-cs.c |  157 +++++++++++++++++++--------------------
 2 files changed, 156 insertions(+), 172 deletions(-)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 41b4361..8cccd1b 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -148,6 +148,69 @@ static struct ata_port_operations pcmcia_8bit_port_ops = {
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
+
+struct pcmcia_config_check {
+	config_info_t conf;
+	cistpl_cftable_entry_t dflt;
+	unsigned long ctl_base;
+	int skip_vcc;
+	int is_kme;
+};
+
+static int pcmcia_check_one_config(struct pcmcia_device *pdev,
+				   cistpl_cftable_entry_t *cfg,
+				   void *priv_data)
+{
+	struct pcmcia_config_check *stk = priv_data;
+
+	/* Check for matching Vcc, unless we're desperate */
+	if (!stk->skip_vcc) {
+		if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
+			if (stk->conf.Vcc != cfg->vcc.param[CISTPL_POWER_VNOM] / 10000)
+				goto next_entry;
+		} else if (stk->dflt.vcc.present & (1 << CISTPL_POWER_VNOM)) {
+			if (stk->conf.Vcc != stk->dflt.vcc.param[CISTPL_POWER_VNOM] / 10000)
+				goto next_entry;
+		}
+	}
+
+	if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
+		pdev->conf.Vpp = cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+	else if (stk->dflt.vpp1.present & (1 << CISTPL_POWER_VNOM))
+		pdev->conf.Vpp = stk->dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
+
+	if ((cfg->io.nwin > 0) || (stk->dflt.io.nwin > 0)) {
+		cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &stk->dflt.io;
+		pdev->conf.ConfigIndex = cfg->index;
+		pdev->io.BasePort1 = io->win[0].base;
+		pdev->io.IOAddrLines = io->flags & CISTPL_IO_LINES_MASK;
+		if (!(io->flags & CISTPL_IO_16BIT))
+			pdev->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
+		if (io->nwin == 2) {
+			pdev->io.NumPorts1 = 8;
+			pdev->io.BasePort2 = io->win[1].base;
+			pdev->io.NumPorts2 = (stk->is_kme) ? 2 : 1;
+			if (pcmcia_request_io(pdev, &pdev->io) != 0)
+				goto next_entry;
+			stk->ctl_base = pdev->io.BasePort2;
+		} else if ((io->nwin == 1) && (io->win[0].len >= 16)) {
+			pdev->io.NumPorts1 = io->win[0].len;
+			pdev->io.NumPorts2 = 0;
+			if (pcmcia_request_io(pdev, &pdev->io) != 0)
+				goto next_entry;
+			stk->ctl_base = pdev->io.BasePort1 + 0x0e;
+		} else
+			goto next_entry;
+		/* If we've got this far, we're done */
+		return 0;
+	}
+next_entry:
+	if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
+		memcpy(&stk->dflt, cfg, sizeof(stk->dflt));
+
+	return -ENODEV;
+}
+
 /**
  *	pcmcia_init_one		-	attach a PCMCIA interface
  *	@pdev: pcmcia device
@@ -161,19 +224,11 @@ static int pcmcia_init_one(struct pcmcia_device *pdev)
 	struct ata_host *host;
 	struct ata_port *ap;
 	struct ata_pcmcia_info *info;
-	tuple_t tuple;
-	struct {
-		unsigned short buf[128];
-		cisparse_t parse;
-		config_info_t conf;
-		cistpl_cftable_entry_t dflt;
-	} *stk = NULL;
-	cistpl_cftable_entry_t *cfg;
-	int pass, last_ret = 0, last_fn = 0, is_kme = 0, ret = -ENOMEM, p;
+	struct pcmcia_config_check *stk = NULL;
+	int last_ret = 0, last_fn = 0, is_kme = 0, ret = -ENOMEM, p;
 	unsigned long io_base, ctl_base;
 	void __iomem *io_addr, *ctl_addr;
 	int n_ports = 1;
-
 	struct ata_port_operations *ops = &pcmcia_port_ops;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
@@ -193,96 +248,30 @@ static int pcmcia_init_one(struct pcmcia_device *pdev)
 	pdev->conf.Attributes = CONF_ENABLE_IRQ;
 	pdev->conf.IntType = INT_MEMORY_AND_IO;
 
-	/* Allocate resoure probing structures */
-
-	stk = kzalloc(sizeof(*stk), GFP_KERNEL);
-	if (!stk)
-		goto out1;
-
-	cfg = &stk->parse.cftable_entry;
-
-	/* Tuples we are walking */
-	tuple.TupleData = (cisdata_t *)&stk->buf;
-	tuple.TupleOffset = 0;
-	tuple.TupleDataMax = 255;
-	tuple.Attributes = 0;
-
 	/* See if we have a manufacturer identifier. Use it to set is_kme for
 	   vendor quirks */
 	is_kme = ((pdev->manf_id == MANFID_KME) &&
 		  ((pdev->card_id == PRODID_KME_KXLC005_A) ||
 		   (pdev->card_id == PRODID_KME_KXLC005_B)));
 
-	/* Not sure if this is right... look up the current Vcc */
-	CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(pdev, &stk->conf));
-/*	link->conf.Vcc = stk->conf.Vcc; */
-
-	pass = io_base = ctl_base = 0;
-	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
-	tuple.Attributes = 0;
-	CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(pdev, &tuple));
+	/* Allocate resoure probing structures */
 
-	/* Now munch the resources looking for a suitable set */
-	while (1) {
-		if (pcmcia_get_tuple_data(pdev, &tuple) != 0)
-			goto next_entry;
-		if (pcmcia_parse_tuple(pdev, &tuple, &stk->parse) != 0)
-			goto next_entry;
-		/* Check for matching Vcc, unless we're desperate */
-		if (!pass) {
-			if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
-				if (stk->conf.Vcc != cfg->vcc.param[CISTPL_POWER_VNOM] / 10000)
-					goto next_entry;
-			} else if (stk->dflt.vcc.present & (1 << CISTPL_POWER_VNOM)) {
-				if (stk->conf.Vcc != stk->dflt.vcc.param[CISTPL_POWER_VNOM] / 10000)
-					goto next_entry;
-			}
-		}
+	stk = kzalloc(sizeof(*stk), GFP_KERNEL);
+	if (!stk)
+		goto out1;
+	stk->is_kme = is_kme;
 
-		if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
-			pdev->conf.Vpp = cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-		else if (stk->dflt.vpp1.present & (1 << CISTPL_POWER_VNOM))
-			pdev->conf.Vpp = stk->dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
-
-		if ((cfg->io.nwin > 0) || (stk->dflt.io.nwin > 0)) {
-			cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &stk->dflt.io;
-			pdev->conf.ConfigIndex = cfg->index;
-			pdev->io.BasePort1 = io->win[0].base;
-			pdev->io.IOAddrLines = io->flags & CISTPL_IO_LINES_MASK;
-			if (!(io->flags & CISTPL_IO_16BIT))
-				pdev->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
-			if (io->nwin == 2) {
-				pdev->io.NumPorts1 = 8;
-				pdev->io.BasePort2 = io->win[1].base;
-				pdev->io.NumPorts2 = (is_kme) ? 2 : 1;
-				if (pcmcia_request_io(pdev, &pdev->io) != 0)
-					goto next_entry;
-				io_base = pdev->io.BasePort1;
-				ctl_base = pdev->io.BasePort2;
-			} else if ((io->nwin == 1) && (io->win[0].len >= 16)) {
-				pdev->io.NumPorts1 = io->win[0].len;
-				pdev->io.NumPorts2 = 0;
-				if (pcmcia_request_io(pdev, &pdev->io) != 0)
-					goto next_entry;
-				io_base = pdev->io.BasePort1;
-				ctl_base = pdev->io.BasePort1 + 0x0e;
-			} else
-				goto next_entry;
-			/* If we've got this far, we're done */
-			break;
-		}
-next_entry:
-		if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
-			memcpy(&stk->dflt, cfg, sizeof(stk->dflt));
-		if (pass) {
-			CS_CHECK(GetNextTuple, pcmcia_get_next_tuple(pdev, &tuple));
-		} else if (pcmcia_get_next_tuple(pdev, &tuple) != 0) {
-			CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(pdev, &tuple));
-			memset(&stk->dflt, 0, sizeof(stk->dflt));
-			pass++;
-		}
+	/* Not sure if this is right... look up the current Vcc */
+	CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(pdev, &stk->conf));
+	stk->skip_vcc = io_base = ctl_base = 0;
+	if (pcmcia_loop_config(pdev, pcmcia_check_one_config, stk)) {
+		memset(&stk->dflt, 0, sizeof(stk->dflt));
+		stk->skip_vcc = 1;
+		if (pcmcia_loop_config(pdev, pcmcia_check_one_config, stk))
+			goto failed; /* No suitable config found */
 	}
-
+	io_base = pdev->io.BasePort1;
+	ctl_base = stk->ctl_base;
 	CS_CHECK(RequestIRQ, pcmcia_request_irq(pdev, &pdev->irq));
 	CS_CHECK(RequestConfiguration, pcmcia_request_configuration(pdev, &pdev->conf));
 
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index 21bfac1..8580bec 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -220,103 +220,98 @@ out_release:
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
+struct pcmcia_config_check {
+	config_info_t conf;
+	cistpl_cftable_entry_t dflt;
+	unsigned long ctl_base;
+	int skip_vcc;
+	int is_kme;
+};
+
+static int pcmcia_check_one_config(struct pcmcia_device *pdev,
+				   cistpl_cftable_entry_t *cfg,
+				   void *priv_data)
+{
+	struct pcmcia_config_check *stk = priv_data;
+
+	/* Check for matching Vcc, unless we're desperate */
+	if (!stk->skip_vcc) {
+		if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
+			if (stk->conf.Vcc != cfg->vcc.param[CISTPL_POWER_VNOM] / 10000)
+				goto next_entry;
+		} else if (stk->dflt.vcc.present & (1 << CISTPL_POWER_VNOM)) {
+			if (stk->conf.Vcc != stk->dflt.vcc.param[CISTPL_POWER_VNOM] / 10000)
+				goto next_entry;
+		}
+	}
+
+	if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
+		pdev->conf.Vpp = cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
+	else if (stk->dflt.vpp1.present & (1 << CISTPL_POWER_VNOM))
+		pdev->conf.Vpp = stk->dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
+
+	if ((cfg->io.nwin > 0) || (stk->dflt.io.nwin > 0)) {
+		cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &stk->dflt.io;
+		pdev->conf.ConfigIndex = cfg->index;
+		pdev->io.BasePort1 = io->win[0].base;
+		pdev->io.IOAddrLines = io->flags & CISTPL_IO_LINES_MASK;
+		if (!(io->flags & CISTPL_IO_16BIT))
+			pdev->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
+		if (io->nwin == 2) {
+			pdev->io.NumPorts1 = 8;
+			pdev->io.BasePort2 = io->win[1].base;
+			pdev->io.NumPorts2 = (stk->is_kme) ? 2 : 1;
+			if (pcmcia_request_io(pdev, &pdev->io) != 0)
+				goto next_entry;
+			stk->ctl_base = pdev->io.BasePort2;
+		} else if ((io->nwin == 1) && (io->win[0].len >= 16)) {
+			pdev->io.NumPorts1 = io->win[0].len;
+			pdev->io.NumPorts2 = 0;
+			if (pcmcia_request_io(pdev, &pdev->io) != 0)
+				goto next_entry;
+			stk->ctl_base = pdev->io.BasePort1 + 0x0e;
+		} else
+			goto next_entry;
+		/* If we've got this far, we're done */
+		return 0;
+	}
+next_entry:
+	if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
+		memcpy(&stk->dflt, cfg, sizeof(stk->dflt));
+
+	return -ENODEV;
+}
+
 static int ide_config(struct pcmcia_device *link)
 {
     ide_info_t *info = link->priv;
-    tuple_t tuple;
-    struct {
-	u_short		buf[128];
-	cisparse_t	parse;
-	config_info_t	conf;
-	cistpl_cftable_entry_t dflt;
-    } *stk = NULL;
-    cistpl_cftable_entry_t *cfg;
-    int pass, last_ret = 0, last_fn = 0, is_kme = 0;
+    struct pcmcia_config_check *stk = NULL;
+    int last_ret = 0, last_fn = 0, is_kme = 0;
     unsigned long io_base, ctl_base;
     struct ide_host *host;
 
     DEBUG(0, "ide_config(0x%p)\n", link);
 
-    stk = kzalloc(sizeof(*stk), GFP_KERNEL);
-    if (!stk) goto err_mem;
-    cfg = &stk->parse.cftable_entry;
-
-    tuple.TupleData = (cisdata_t *)&stk->buf;
-    tuple.TupleOffset = 0;
-    tuple.TupleDataMax = 255;
-    tuple.Attributes = 0;
-
     is_kme = ((link->manf_id == MANFID_KME) &&
 	      ((link->card_id == PRODID_KME_KXLC005_A) ||
 	       (link->card_id == PRODID_KME_KXLC005_B)));
 
+    stk = kzalloc(sizeof(*stk), GFP_KERNEL);
+    if (!stk)
+	    goto err_mem;
+    stk->is_kme = is_kme;
+
     /* Not sure if this is right... look up the current Vcc */
     CS_CHECK(GetConfigurationInfo, pcmcia_get_configuration_info(link, &stk->conf));
-
-    pass = io_base = ctl_base = 0;
-    tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
-    tuple.Attributes = 0;
-    CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(link, &tuple));
-    while (1) {
-    	if (pcmcia_get_tuple_data(link, &tuple) != 0) goto next_entry;
-	if (pcmcia_parse_tuple(link, &tuple, &stk->parse) != 0) goto next_entry;
-
-	/* Check for matching Vcc, unless we're desperate */
-	if (!pass) {
-	    if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
-		if (stk->conf.Vcc != cfg->vcc.param[CISTPL_POWER_VNOM] / 10000)
-		    goto next_entry;
-	    } else if (stk->dflt.vcc.present & (1 << CISTPL_POWER_VNOM)) {
-		if (stk->conf.Vcc != stk->dflt.vcc.param[CISTPL_POWER_VNOM] / 10000)
-		    goto next_entry;
-	    }
-	}
-
-	if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
-	    link->conf.Vpp =
-		cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-	else if (stk->dflt.vpp1.present & (1 << CISTPL_POWER_VNOM))
-	    link->conf.Vpp =
-		stk->dflt.vpp1.param[CISTPL_POWER_VNOM] / 10000;
-
-	if ((cfg->io.nwin > 0) || (stk->dflt.io.nwin > 0)) {
-	    cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &stk->dflt.io;
-	    link->conf.ConfigIndex = cfg->index;
-	    link->io.BasePort1 = io->win[0].base;
-	    link->io.IOAddrLines = io->flags & CISTPL_IO_LINES_MASK;
-	    if (!(io->flags & CISTPL_IO_16BIT))
-		link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
-	    if (io->nwin == 2) {
-		link->io.NumPorts1 = 8;
-		link->io.BasePort2 = io->win[1].base;
-		link->io.NumPorts2 = (is_kme) ? 2 : 1;
-		if (pcmcia_request_io(link, &link->io) != 0)
-			goto next_entry;
-		io_base = link->io.BasePort1;
-		ctl_base = link->io.BasePort2;
-	    } else if ((io->nwin == 1) && (io->win[0].len >= 16)) {
-		link->io.NumPorts1 = io->win[0].len;
-		link->io.NumPorts2 = 0;
-		if (pcmcia_request_io(link, &link->io) != 0)
-			goto next_entry;
-		io_base = link->io.BasePort1;
-		ctl_base = link->io.BasePort1 + 0x0e;
-	    } else goto next_entry;
-	    /* If we've got this far, we're done */
-	    break;
-	}
-
-    next_entry:
-	if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
-	    memcpy(&stk->dflt, cfg, sizeof(stk->dflt));
-	if (pass) {
-	    CS_CHECK(GetNextTuple, pcmcia_get_next_tuple(link, &tuple));
-	} else if (pcmcia_get_next_tuple(link, &tuple) != 0) {
-	    CS_CHECK(GetFirstTuple, pcmcia_get_first_tuple(link, &tuple));
+    stk->skip_vcc = io_base = ctl_base = 0;
+    if (pcmcia_loop_config(link, pcmcia_check_one_config, stk)) {
 	    memset(&stk->dflt, 0, sizeof(stk->dflt));
-	    pass++;
-	}
+	    stk->skip_vcc = 1;
+	    if (pcmcia_loop_config(link, pcmcia_check_one_config, stk))
+		    goto failed; /* No suitable config found */
     }
+    io_base = link->io.BasePort1;
+    ctl_base = stk->ctl_base;
 
     CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
     CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link, &link->conf));
-- 
1.5.4.3

