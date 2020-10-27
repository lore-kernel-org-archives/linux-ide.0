Return-Path: <SRS0=ctpL=EC=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0240FC388F9
	for <linux-ide@archiver.kernel.org>; Tue, 27 Oct 2020 16:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9152225C
	for <linux-ide@archiver.kernel.org>; Tue, 27 Oct 2020 16:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="K61Pib4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1794903AbgJ0Qqs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:46:48 -0400
Received: from mail-eopbgr150091.outbound.protection.outlook.com ([40.107.15.91]:32910
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1794938AbgJ0POa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 27 Oct 2020 11:14:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFqMn4ECpO6+vbUdxfvzXz1wgKj1BLHhQ4we910ppzEqQc+GYVZ7CEKUGA2tu0xGFCOwr71gDzGoRv/3ZDB0J4dZvp6YMw53WB8sJOZSQNUrrnhw6vz37KfcpFASChMhv9wKSOcnfnZX4RwNZNo9YGlJlGaDH93L0gezBdVh/aN/rCtWSghuT56YJGXS1YPjQcPxYIuoRf+yiG+xmHMMiCCKm33j6GR50y4wBjXfTc9UeCJ8GxGfQ7BYceHOVP13KReiEd57sbqEJG5R3VlyRJOYopFEN5360ekbx2mDZOcu64hv2GjH7hnhaMvy7lF3K/PGDOj1EHKzU+DD6l9Gjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phNw4Gq7zAKvxVCZ8mIQVN35TfqWYICLusxShMKJ9Kw=;
 b=Re4APOUoBH+u6yD1YcsKfkMGn1NOWSMOGl7jQAzJizPE+PioZl2WDCNVjYb+XI4CyDIWIzZYKSrBg0Dv5OJxvTnXZ1d8cBLeZS8qEzYgniz5iKdPW7nCLAk2DESYtkvHD2T02qUmWE709M1mu1t6uHkLPNUhE8K1TVIXolmm2KvVEUGX015AKzo6Kjm69hGpZ05pI21XYwrM8T0GdabVE8tQvRqm5TNYd0OT4aWuU4elnAwtOAVQbip3Hyp0gYggU27mUBTkVxkXct0G0MDc88AHnBJ8c3apjTb0xJ1vmjHawV9lQpwf2MRC2mqce7GDfu1WFIUu0mp3kuySZznmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phNw4Gq7zAKvxVCZ8mIQVN35TfqWYICLusxShMKJ9Kw=;
 b=K61Pib4iEgTxas/DXhLc1vpd3RgVPXC9jSG8KSxm45q2aViLOPOlJbuesLuGT8sZ5ARjsoi9rUWuyQ4ZaI13tz8UmRV5rN31I8XB/C1A+ElowBZHttqtd3ZfCHxf4XY7ZGmKyUs+t8spLYwZk/+yzyQUBqJQUOw2NDrZwLf6Q9s=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM8PR05MB7458.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 15:14:24 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3499.019; Tue, 27 Oct 2020
 15:14:24 +0000
Date:   Tue, 27 Oct 2020 16:14:21 +0100
From:   Sven Auhagen <sven.auhagen@voleatech.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     axboe@kernel.dk, robh+dt@kernel.org, tglx@linutronix.de,
        maz@kernel.org, gregory.clement@bootlin.com,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH 3/7] ata: ahci: mvebu: Add support for A8k legacy DT
 bindings
Message-ID: <20201027151421.ko4usn4dgxjrouo2@svensmacbookair.sven.lan>
References: <20201007154554.66650-1-sven.auhagen@voleatech.de>
 <20201007154554.66650-4-sven.auhagen@voleatech.de>
 <64ef8072-b217-275b-be98-c72f52064dff@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ef8072-b217-275b-be98-c72f52064dff@redhat.com>
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM0PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::49) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM0PR07CA0036.eurprd07.prod.outlook.com (2603:10a6:208:ac::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.11 via Frontend Transport; Tue, 27 Oct 2020 15:14:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a55b143c-2d6f-429a-4c1d-08d87a8afcf8
X-MS-TrafficTypeDiagnostic: AM8PR05MB7458:
X-Microsoft-Antispam-PRVS: <AM8PR05MB7458CB3362A175EE2908F1D1EF160@AM8PR05MB7458.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWbcGWZRaIIYoI2OR8PVlaRFBQdmNEI+Evj6NAh8b2aqLBPKwKJcvVqqDDE8ACeH7nZYpS46aT3N3roDdnxRLdz9bfKtFgF9Z0aWEVKCVFBAGBLZYHwxWrr1gOrxo/Ykm6HLc7W0QU+Xb5b29HdsbEnUkas8rjlQNdLGHvwRmDhwhk8wgZVFlj8thzNI2xxbs6a8O9GtCj4wdpE9TYmTHsu/08GOmJC4KQpRjIkk3+3GcutWwqj0fm8Rhuf0eoTU46/iACwr4APrf84a/YWoqesRiEHL+PX5nTnkbAHUYtwQf8I20+AOjvPqxjSDWKGKROkaTpQu3i9sJorLHwZPfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(396003)(366004)(136003)(376002)(52116002)(6916009)(44832011)(316002)(7416002)(956004)(478600001)(8936002)(55016002)(26005)(53546011)(16526019)(86362001)(6506007)(7696005)(186003)(8676002)(2906002)(83380400001)(9686003)(5660300002)(30864003)(66476007)(1076003)(66946007)(66556008)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ym1rdkzTMb+lsk7MJKMmYSeazoZwSAB6/cfN0Kb8ivlZf0BDWW5CnS3/qC+gLe/oQYy4L8fwD+Q7yu48lDqKU1R8DhxnzbahTBYgKxUgSRtqkOuafjHJCWTZPelCQKXcDHJ87ruOjlC9YWJrruoEtgMFV2Oybq63ahXu4ZvwygcTB5pEW4wHrr2r1wPFI2HmlzmHfrOyuoCpnxN58WFoq/lbkgkQEFtsXNoBfRrMx0Mo9zKQgXW1LrTGjMzCkf3G19OkCt1P7TZPA0zkXUIfW8yvF5MxB9azwQu6BjxZUsWIwLluNOjhioiE8D7MT/Uw02a7tb/8yuQ7c+yzhc7lQnmqAY5SAmYnfnh7cpEnsUi5cgAbGlQtA4kEupvduC9HKN9HRcmAcvYmOOBuBzb3FQ2AL4g1OocHIy/aat3o6+IN6LGnGCrkyWX83BNEkpCOunHYsIU8Fb/diT0TnlQMcgDO5O+gApZ1fUZZ7rPVIk/qzTiOQWGnyrNfpuWoByfHArbIAGEsuAv5GwqgEyuZSKdS32kSOjy245s0Sr+Hdu9xGcRlCQGIEo14sFzupnM3o7pKF5RE3L2PqeOzmKpV9ylLOISL0wMPCcdzQ7ZuX6Lbd4LQ2PI+f29h3kCXXbXgTAIX7wuaxrQE0JQwvJltiw==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a55b143c-2d6f-429a-4c1d-08d87a8afcf8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 15:14:24.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Pf9F9twHhthRHmuqICKOfPJ7EiURzRAnHWEPwsRHHDzHSbF0ox+V5zqgJ1bUQrQ3MIL8f9xjDTCi5itY2JEtj0XWQAkfAHvoCJeJsrYOCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7458
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Oct 27, 2020 at 03:22:15PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 10/7/20 5:45 PM, sven.auhagen@voleatech.de wrote:
> > From: Sven Auhagen <sven.auhagen@voleatech.de>
> > 
> > The CP110 SATA unit has 2 ports, and a dedicated ICU entry per
> > port. In the past, the AHCI SATA driver only supported one interrupt
> > per SATA unit. To solve this conflict, the 2 SATA wired interrupts in
> > the South-Bridge got configured as 1 GIC interrupt in the
> > North-Bridge, regardless of the number of SATA ports actually
> > enabled/in use, and the DT bindings only referenced the interrupt of
> > one port.
> > 
> > Since then, this limitation has been addressed and this patch ensures
> > backward compatibility with old DTs not describing SATA ports
> > correctly directly from the AHCI MVEBU driver. This way, we will be
> > able to drop the hack from the ICU driver. IOW, when the A8k
> > compatible string is used and there is no sub-nodes in the DT, we
> > fake the creation and mapping of the second (missing) interrupt.
> > 
> > Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> See my comments inline.

Hi Hans,

thank you for your feedback, that is very helpful.
I will get on the changes and resubmit a new patch series.

Best
Sven

> 
> > ---
> >  drivers/ata/ahci.h             |   3 +
> >  drivers/ata/ahci_mvebu.c       | 235 ++++++++++++++++++++++++++++++++-
> >  drivers/ata/libahci.c          |   3 +-
> >  drivers/ata/libahci_platform.c |   3 +
> >  include/linux/ahci_platform.h  |   1 +
> >  5 files changed, 239 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> > index d991dd46e89c..8cb256eec86b 100644
> > --- a/drivers/ata/ahci.h
> > +++ b/drivers/ata/ahci.h
> > @@ -407,6 +407,9 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
> >  int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
> >  		      unsigned long deadline, bool *online);
> >  
> > +void ahci_handle_port_interrupt(struct ata_port *ap,
> > +				       void __iomem *port_mmio, u32 status);
> > +
> >  unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
> >  int ahci_stop_engine(struct ata_port *ap);
> >  void ahci_start_fis_rx(struct ata_port *ap);
> 
> This bit + the but making the function non static and exporting
> it needs to go into its own separate patch.
> 
> > diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
> > index 1cdc126882eb..62e9b94e2bba 100644
> > --- a/drivers/ata/ahci_mvebu.c
> > +++ b/drivers/ata/ahci_mvebu.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/mbus.h>
> >  #include <linux/module.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/platform_device.h>
> >  #include "ahci.h"
> >  
> > @@ -28,9 +29,14 @@
> >  #define AHCI_WINDOW_BASE(win)	(0x64 + ((win) << 4))
> >  #define AHCI_WINDOW_SIZE(win)	(0x68 + ((win) << 4))
> >  
> > +#define ICU_SATA0_ICU_ID 109
> > +#define ICU_SATA1_ICU_ID 107
> > +
> >  struct ahci_mvebu_plat_data {
> >  	int (*plat_config)(struct ahci_host_priv *hpriv);
> >  	unsigned int host_flags;
> > +	unsigned int resource_flags;
> > +	unsigned int port_irq[2];
> >  };
> >  
> >  static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
> > @@ -96,6 +102,213 @@ static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
> >  	return 0;
> >  }
> >  
> > +static int ahci_get_per_port_irq_armada8k(struct ata_host *host, int port)
> > +{
> > +	struct ahci_host_priv *hpriv = host->private_data;
> > +	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
> > +
> > +	return pdata->port_irq[port];
> > +}
> > +
> > +static irqreturn_t ahci_multi_irqs_intr_hard_armada8k(int irq, void *dev_instance)
> > +{
> > +	struct ata_port *ap = dev_instance;
> > +	struct ata_host *host = ap->host;
> > +	struct ahci_host_priv *hpriv = host->private_data;
> > +	void __iomem *port_mmio = ahci_port_base(ap);
> > +	void __iomem *mmio = hpriv->mmio;
> > +	u32 status;
> > +
> > +	VPRINTK("ENTER\n");
> > +
> > +	status = readl(port_mmio + PORT_IRQ_STAT);
> > +	writel(status, port_mmio + PORT_IRQ_STAT);
> > +
> > +	spin_lock(ap->lock);
> > +	ahci_handle_port_interrupt(ap, port_mmio, status);
> > +	spin_unlock(ap->lock);
> > +
> > +	writel(BIT(ap->port_no), mmio + HOST_IRQ_STAT);
> > +
> > +	VPRINTK("EXIT\n");
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int ahci_host_activate_multi_irqs_armada8k(struct ata_host *host,
> > +					 struct scsi_host_template *sht)
> > +{
> > +	struct ahci_host_priv *hpriv = host->private_data;
> > +	int i, rc;
> > +
> > +	rc = ata_host_start(host);
> > +	if (rc)
> > +		return rc;
> > +	/*
> > +	 * Requests IRQs one per port
> > +	 */
> > +	for (i = 0; i < host->n_ports; i++) {
> > +		struct ahci_port_priv *pp = host->ports[i]->private_data;
> > +		int irq = hpriv->get_irq_vector(host, i);
> > +
> > +		/* Do not receive interrupts sent by dummy ports */
> > +		if (!pp) {
> > +			disable_irq(irq);
> > +			continue;
> > +		}
> > +
> > +		rc = devm_request_irq(host->dev, irq, ahci_multi_irqs_intr_hard_armada8k,
> > +				0, pp->irq_desc, host->ports[i]);
> > +
> > +		if (rc)
> > +			return rc;
> > +		ata_port_desc(host->ports[i], "irq %d", irq);
> > +	}
> > +
> > +	return ata_host_register(host, sht);
> > +}
> 
> This is more or less a 1:1 copy of ahci_host_activate_multi_irqs(). Please don't go
> around and make copies of functions (also see below).
> 
> The only difference seems to be the use of ahci_multi_irqs_intr_hard_armada8k
> where as ahci_host_activate_multi_irqs() uses ahci_multi_irqs_intr_hard as IRQ handler.
> 
> And ahci_multi_irqs_intr_hard_armada8k itself is a copy of
> ahci_multi_irqs_intr_hard() with a small change
> 
> No, just no all this function copying is not ok, hard NACK!
> 
> Instead I suggest that you add an "multi_irq_host_ack" callback to some
> shared data struct, which will then get called by ahci_multi_irqs_intr_hard()
> (when defined) in the place where you have added the following line:
> 
> 	writel(BIT(ap->port_no), mmio + HOST_IRQ_STAT);
> 
> To your private copy of ahci_multi_irqs_intr_hard(), then you can drop
> both the ahci_multi_irqs_intr_hard() and the ahci_host_activate_multi_irqs()
> copies and reduce the size of this patch by a lot of lines, again also see
> below for dropping even more lines!
> 
> > +
> > +static int ahci_mvebu_armada_8k_irq_backwards(struct ahci_host_priv *hpriv,
> > +				       struct device *dev)
> > +{
> > +	struct device_node *np = of_irq_find_parent(dev->of_node);
> > +	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
> > +	struct irq_data *irqd = irq_get_irq_data(pdata->port_irq[0]);
> > +	int host_irq = irqd ? irqd_to_hwirq(irqd) : 0;
> > +	int missing_irq = (host_irq == ICU_SATA1_ICU_ID) ?
> > +		ICU_SATA0_ICU_ID : ICU_SATA1_ICU_ID;
> > +	struct irq_fwspec fwspec = {
> > +		.fwnode = of_node_to_fwnode(np),
> > +		.param_count = 2,
> > +		.param = {missing_irq, IRQ_TYPE_LEVEL_HIGH},
> > +	};
> > +
> > +	if (of_get_child_count(dev->of_node))
> > +		return 0;
> > +
> > +	pdata->port_irq[1] = irq_create_fwspec_mapping(&fwspec);
> > +	if (pdata->port_irq[1])
> > +		hpriv->mask_port_map = GENMASK(1, 0);
> > +
> > +	return 0;
> > +}
> > +
> 
> 
> > +static int ahci_platform_init_host_armada8k(struct platform_device *pdev,
> > +			    struct ahci_host_priv *hpriv,
> > +			    const struct ata_port_info *pi_template,
> > +			    struct scsi_host_template *sht)
> > +{
> > +	struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
> > +	struct device *dev = &pdev->dev;
> > +	struct ata_port_info pi = *pi_template;
> > +	const struct ata_port_info *ppi[] = { &pi, NULL };
> > +	struct device_node *child;
> > +	struct ata_host *host;
> > +	int i, port_irq, n_ports, rc, child_nodes, port = 0;
> > +
> > +	/* Get IRQs per port */
> > +	child_nodes = of_get_child_count(dev->of_node);
> > +	if (child_nodes) {
> > +		for_each_child_of_node(dev->of_node, child) {
> > +
> > +			port_irq = of_irq_get(child, 0);
> > +			if (!port_irq)
> > +				port_irq = -EINVAL;
> > +			if (port_irq < 0) {
> > +				rc = port_irq;
> > +				return rc;
> > +			}
> > +
> > +			pdata->port_irq[port] = port_irq;
> > +			port++;
> > +		}
> > +	} else {
> > +		/* Backwards Compatibility Check */
> > +		port_irq = platform_get_irq(pdev, 0);
> > +		if (port_irq > 0) {
> > +			pdata->port_irq[0] = port_irq;
> > +			ahci_mvebu_armada_8k_irq_backwards(hpriv, dev);
> > +		} else {
> > +			dev_err(dev, "no irq\n");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	hpriv->get_irq_vector = ahci_get_per_port_irq_armada8k;
> > +
> > +	/* prepare host */
> > +	pi.private_data = (void *)(unsigned long)hpriv->flags;
> > +
> > +	ahci_save_initial_config(dev, hpriv);
> > +
> > +	if (hpriv->cap & HOST_CAP_NCQ)
> > +		pi.flags |= ATA_FLAG_NCQ;
> > +
> > +	if (hpriv->cap & HOST_CAP_PMP)
> > +		pi.flags |= ATA_FLAG_PMP;
> > +
> > +	ahci_set_em_messages(hpriv, &pi);
> > +
> > +	/* CAP.NP sometimes indicate the index of the last enabled
> > +	 * port, at other times, that of the last possible port, so
> > +	 * determining the maximum port number requires looking at
> > +	 * both CAP.NP and port_map.
> > +	 */
> > +	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
> > +
> > +	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
> > +	if (!host)
> > +		return -ENOMEM;
> > +
> > +	host->private_data = hpriv;
> > +
> > +	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
> > +		host->flags |= ATA_HOST_PARALLEL_SCAN;
> > +	else
> > +		dev_info(dev, "SSS flag set, parallel bus scan disabled\n");
> > +
> > +	if (pi.flags & ATA_FLAG_EM)
> > +		ahci_reset_em(host);
> > +
> > +	for (i = 0; i < host->n_ports; i++) {
> > +		struct ata_port *ap = host->ports[i];
> > +
> > +		ata_port_desc(ap, "mmio %pR",
> > +			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
> > +		ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
> > +
> > +		/* set enclosure management message type */
> > +		if (ap->flags & ATA_FLAG_EM)
> > +			ap->em_message_type = hpriv->em_msg_type;
> > +
> > +		/* disabled/not-implemented port */
> > +		if (!(hpriv->port_map & (1 << i)))
> > +			ap->ops = &ata_dummy_port_ops;
> > +	}
> > +
> > +	if (hpriv->cap & HOST_CAP_64) {
> > +		rc = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +		if (rc) {
> > +			rc = dma_coerce_mask_and_coherent(dev,
> > +							  DMA_BIT_MASK(32));
> > +			if (rc) {
> > +				dev_err(dev, "Failed to enable 64-bit DMA.\n");
> > +				return rc;
> > +			}
> > +			dev_warn(dev, "Enable 32-bit DMA instead of 64-bit.\n");
> > +		}
> > +	}
> > +
> > +	rc = ahci_reset_controller(host);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ahci_init_controller(host);
> > +	ahci_print_info(host, "platform");
> > +
> > +	return ahci_host_activate_multi_irqs_armada8k(host, sht);
> > +}
> > +
> 
> So this is basically a copy of ahci_platform_init_host() with:
> 
> 1. This bit:
> 
>         irq = platform_get_irq(pdev, 0);
>         if (irq <= 0) {
>                 if (irq != -EPROBE_DEFER)
>                         dev_err(dev, "no irq\n");
>                 return irq;
>         }
> 
>         hpriv->irq = irq;
> 
> Replaced with:
> 
> > +	/* Get IRQs per port */
> > +	child_nodes = of_get_child_count(dev->of_node);
> > +	if (child_nodes) {
> > +		for_each_child_of_node(dev->of_node, child) {
> > +
> > +			port_irq = of_irq_get(child, 0);
> > +			if (!port_irq)
> > +				port_irq = -EINVAL;
> > +			if (port_irq < 0) {
> > +				rc = port_irq;
> > +				return rc;
> > +			}
> > +
> > +			pdata->port_irq[port] = port_irq;
> > +			port++;
> > +		}
> > +	} else {
> > +		/* Backwards Compatibility Check */
> > +		port_irq = platform_get_irq(pdev, 0);
> > +		if (port_irq > 0) {
> > +			pdata->port_irq[0] = port_irq;
> > +			ahci_mvebu_armada_8k_irq_backwards(hpriv, dev);
> > +		} else {
> > +			dev_err(dev, "no irq\n");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	hpriv->get_irq_vector = ahci_get_per_port_irq_armada8k;
> 
> You can just do this new bit, before calling ahci_platform_init_host()
> and then disable the bit of ahci_platform_init_host() which you do not
> want by adding an if around it like this:
> 
> 	if (!(hpriv->flags & AHCI_HFLAG_MULTI_MSI)) {
> 	        irq = platform_get_irq(pdev, 0);
>         	if (irq <= 0) {
>                 	if (irq != -EPROBE_DEFER)
>                         	dev_err(dev, "no irq\n");
> 	                return irq;
>         	}
> 	        hpriv->irq = irq;
> 	}
> 
> Note please add this new if() check in a separate patch.
> 
> The only other change to ahci_platform_init_host() here is
> the function ending with:
> 
> 	return ahci_host_activate_multi_irqs_armada8k(host, sht);
> 
> Instead of with:
> 
>        return ahci_host_activate(host, sht);
> 
> As mentioned above you really do NOT need that function, which
> is yet another copy. Instead make the changes which I suggested
> above and set the AHCI_HFLAG_MULTI_MSI flag to make
> ahci_host_activate() do what you want.
> 
> After this you can drop all 3 private functions of pre-existing
> ahci functions AFAICT.
> 
> >  static int ahci_mvebu_armada_8k_config(struct ahci_host_priv *hpriv)
> >  {
> >  	return 0;
> > @@ -189,15 +402,22 @@ static struct scsi_host_template ahci_platform_sht = {
> >  
> >  static int ahci_mvebu_probe(struct platform_device *pdev)
> >  {
> > -	const struct ahci_mvebu_plat_data *pdata;
> > +	const struct ahci_mvebu_plat_data *pdata_plat;
> > +	struct ahci_mvebu_plat_data *pdata;
> >  	struct ahci_host_priv *hpriv;
> >  	int rc;
> >  
> > -	pdata = of_device_get_match_data(&pdev->dev);
> > -	if (!pdata)
> > +	pdata_plat = of_device_get_match_data(&pdev->dev);
> > +	if (!pdata_plat)
> >  		return -EINVAL;
> >  
> > -	hpriv = ahci_platform_get_resources(pdev, 0);
> > +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata)
> > +		return -ENOMEM;
> > +
> > +	memcpy(pdata, pdata_plat, sizeof(*pdata));
> > +
> > +	hpriv = ahci_platform_get_resources(pdev, pdata->resource_flags);
> >  	if (IS_ERR(hpriv))
> >  		return PTR_ERR(hpriv);
> >  
> > @@ -214,7 +434,11 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
> >  	if (rc)
> >  		goto disable_resources;
> >  
> > -	rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
> > +	if (pdata->resource_flags & AHCI_PLATFORM_A8K_QUIRK)
> > +		rc = ahci_platform_init_host_armada8k(pdev, hpriv, &ahci_mvebu_port_info,
> > +				     &ahci_platform_sht);
> > +	else
> > +		rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
> >  				     &ahci_platform_sht);
> 
> And this change can go away then too...
> 
> >  	if (rc)
> >  		goto disable_resources;
> > @@ -237,6 +461,7 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
> >  
> >  static const struct ahci_mvebu_plat_data ahci_mvebu_armada_8k_plat_data = {
> >  	.plat_config = ahci_mvebu_armada_8k_config,
> > +	.resource_flags = AHCI_PLATFORM_A8K_QUIRK,
> >  };
> >  
> >  static const struct of_device_id ahci_mvebu_of_match[] = {
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > index ea5bf5f4cbed..0e6eaa2e03a9 100644
> > --- a/drivers/ata/libahci.c
> > +++ b/drivers/ata/libahci.c
> > @@ -1799,7 +1799,7 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
> >  		ata_port_abort(ap);
> >  }
> >  
> > -static void ahci_handle_port_interrupt(struct ata_port *ap,
> > +void ahci_handle_port_interrupt(struct ata_port *ap,
> >  				       void __iomem *port_mmio, u32 status)
> >  {
> >  	struct ata_eh_info *ehi = &ap->link.eh_info;
> > @@ -1882,6 +1882,7 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
> >  		ata_port_freeze(ap);
> >  	}
> >  }
> > +EXPORT_SYMBOL_GPL(ahci_handle_port_interrupt);
> >  
> >  static void ahci_port_intr(struct ata_port *ap)
> >  {
> 
> As already mentioned this needs to go to a separate patch.
> 
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 129556fcf6be..21332a33f766 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -464,6 +464,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >  	if (!child_nodes)
> >  		hpriv->nports = 1;
> >  
> > +	if (!child_nodes && flags & AHCI_PLATFORM_A8K_QUIRK)
> > +		hpriv->nports = 2;
> > +
> >  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
> >  	if (!hpriv->phys) {
> >  		rc = -ENOMEM;
> > diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> > index 49e5383d4222..b31972e0bfbf 100644
> > --- a/include/linux/ahci_platform.h
> > +++ b/include/linux/ahci_platform.h
> > @@ -42,5 +42,6 @@ int ahci_platform_suspend(struct device *dev);
> >  int ahci_platform_resume(struct device *dev);
> >  
> >  #define AHCI_PLATFORM_GET_RESETS	0x01
> > +#define AHCI_PLATFORM_A8K_QUIRK		0x02
> >  
> >  #endif /* _AHCI_PLATFORM_H */
> > 
> 
> These last 2 changes need to go into a separate patch and please rename the quirk to
> AHCI_PLATFORM_ARMADA8K_QUIRK to make it clear that it is for armada SoCs.
> 
> Regards,
> 
> Hans
> 
