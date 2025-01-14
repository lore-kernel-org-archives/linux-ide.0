Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203015C15C;
	Tue, 14 Jan 2025 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870751; cv=none; b=oyXvqCKFKwTuPaHJ1+9wfQbAAMPX4bCxCsIrWTc0fGKJoBdSL/gGuPDjnyYcMHh/fAbhHKYM3e3YinoTLtans13r6klZ60LJ6Cti/zIrF1SPcfJO3AOOeBcG3ODb4ITFjTrPIvQSpP+JdjJS7e2y+ig+wosty8cX0a1rvKbu6FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870751; c=relaxed/simple;
	bh=jEKW4ix6fbG3EtdpQ1O5QGEYyn/UlNiiMUk/Jdm1yP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoL894jFRK52CJU3PysMix4yUMruK+7WA1Yu983olLgexLMSA91sJT2rCOMxMDLxiIS/Ow5FtV0A3HQ0B45M+TDiLiSgMYpiVqv5P4g2qWFBwkO3YLujm8aB1awr+tuBCAW+wASWvIzjm4hWq+qCcUo7m9KdJXPF9bW9pQVtZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtQTf/UI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtQTf/UI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB93C4CEDD;
	Tue, 14 Jan 2025 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736870751;
	bh=jEKW4ix6fbG3EtdpQ1O5QGEYyn/UlNiiMUk/Jdm1yP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtQTf/UISUxpGRiXKfTw3vR3It0VVctLBNxLvC7n6klcHWkzVXvsK4dAIRViCG4F6
	 gDlHhLL65vFbJF0m7BdiPkKrmwd+fdoCdNW/4JXiVNAeFuHMPJWi6ko4Q8gUz1oP6S
	 XRxMxhg6vqy/4S2MW4yNBkm+Q7cKUlNP5z3SI7myHL47S9n3plnZPX33JK7z0+MbVb
	 K/8jeavXZUg90x4DnLv9isBrU34CtD+85Y7ocoqVxsLYhbdiEZHgBHFWD/XEX13KwD
	 HpY9h3Ec8Guw7TgBK3gqN7byoS7qPsbQA7lhFo60/R8FDTxn62Oz52N8j9+1e/JNQC
	 ptTW5fA5HeqqA==
Date: Tue, 14 Jan 2025 17:05:46 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Heusel <christian@heusel.eu>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
Message-ID: <Z4aLWmt1Y2jL1-pD@ryzen>
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
 <Z4EDf4ecHyfTq3Hp@x1-carbon>
 <69589dad-c0c8-4a72-9f3d-c1b0c29c96c1@heusel.eu>
 <e167b28c-94a2-45bf-8330-2487baf7199b@heusel.eu>
 <Z4U-rc3VUeegHGAg@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4U-rc3VUeegHGAg@ryzen>

Hello Christian,

Looking at the Arch Linux thread, it seems that the person reporting the
problem says that even on a working kernel, you only see the device the
user presses the open button on the Blu-Ray player.

This suggests to me that it sends a hotplug/PhyRdy event when the user
presses the open button.

In Linux, if we don't detect anything connected to the port during initial
boot, and if the port is not marked (by firmware) as either Hotplug Capable,
or External, then we mask the PhyRdy interrupt.

We could reconsider this, and leave the PhyRdy interrupt enabled even for a
port that is not Hotplug Capable or External, if there is no devices detected
on the port.


However, a device should really show up after a COMRESET... A device that
does not do so seems to be non-spec compliant.
It would be nice if we could understand why this device does not show up
after a COMRESET. (If it did, we most likely would not need the workaround
suggested above.)


Could you please run with this debug prints, which might tell us what is
going on:


diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index fdfa7b266218..eab9fd3316a6 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -804,6 +804,18 @@ static void ahci_power_up(struct ata_port *ap)
        writel(cmd | PORT_CMD_ICC_ACTIVE, port_mmio + PORT_CMD);
 }
 
+static void ahci_dump_regs(struct ata_port *ap, char *str)
+{
+       void __iomem *port_mmio = ahci_port_base(ap);
+
+       ata_port_err(ap, "%s PxSSTS %#x PxSCTL %#x PxCMD %#x PxDEVSLP %#x\n",
+                    str,
+                    readl(port_mmio + PORT_SCR_STAT),
+                    readl(port_mmio + PORT_SCR_CTL),
+                    readl(port_mmio + PORT_CMD),
+                    readl(port_mmio + PORT_DEVSLP));
+}
+
 static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
                        unsigned int hints)
 {
@@ -824,6 +836,9 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
                pp->intr_mask &= ~PORT_IRQ_PHYRDY;
                writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 
+               if (!(ata_link_nr_enabled(link) > 0))
+                       ahci_dump_regs(ap, "before offline");
+
                sata_link_scr_lpm(link, policy, false);
        }
 
@@ -1607,8 +1622,15 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 
        ahci_port_clear_pending_irq(ap);
 
+       ahci_dump_regs(ap, "before wakeup");
+       ahci_power_up(ap);
+       ata_msleep(ap, 500);
+
+       ahci_dump_regs(ap, "before reset");
        rc = sata_link_hardreset(link, timing, deadline, online,
                                 ahci_check_ready);
+       ata_port_err(ap, "sata_link_hardreset returned: %d online: %d\n", rc, *online);
+       ahci_dump_regs(ap, "after reset");
 
        hpriv->start_engine(ap);
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 9c76fb1ad2ec..21ad2828385c 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -660,15 +660,17 @@ int sata_link_hardreset(struct ata_link *link, const unsigned int *timing,
        /* Couldn't find anything in SATA I/II specs, but AHCI-1.1
         * 10.4.2 says at least 1 ms.
         */
-       ata_msleep(link->ap, 1);
+       ata_msleep(link->ap, 500);
 
        /* bring link back */
        rc = sata_link_resume(link, timing, deadline);
        if (rc)
                goto out;
        /* if link is offline nothing more to do */
-       if (ata_phys_link_offline(link))
+       if (ata_phys_link_offline(link)) {
+               ata_port_err(link->ap, "phys link offline, no reason to wait\n");
                goto out;
+       }
 
        /* Link is online.  From this point, -ENODEV too is an error. */
        if (online)






Kind regards,
Niklas
