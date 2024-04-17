Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A240816FF52
	for <linux-ide@vger.kernel.org>; Wed, 17 Apr 2024 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374486; cv=none; b=OnPoQ/T2kdpppk5hiGgu+GIBC+QC87Rl3x9FR4dSU08HvRyh8KRi4r/+qt64pDxUuis+ksO9uWI9AT0x7YTxWEIDl7mo4QSE69MtC/Jr8/qQzyT1RoVHIaEeUrdpT+O9U5GN+cqSr6DebwiATDJT006DQUTjHFu4WrcE+auPu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374486; c=relaxed/simple;
	bh=n4hvaePBT+OItbIz+QvDce3ETf02MfY3TNcZTw2C0WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6PeOwqnAyfASKvjNn2NnslBz2fQHRvhc+WEqPG81VyRliuhl40hKuuGU96kZ50B0jGoybfZm0/kiPgNrY2oKqNi2+XyzpF/JRX/VJMyLDD1Dpqhac2KShS0BePCkKsCMu6hR8+T4rXfCcfK2fgPtLBAwqJ69W8pzjqldUf9sRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc/T7chU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc/T7chU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0875C2BD11;
	Wed, 17 Apr 2024 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713374486;
	bh=n4hvaePBT+OItbIz+QvDce3ETf02MfY3TNcZTw2C0WY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dc/T7chUzUt6weApc60GwIPgSxNYmmBlZa4OyYOc2R7Tf/OFtiqOt5hWSVHg5AwK/
	 e4ZeLle0MP68Qh4AwBecoPtLOo5yLVIwdjB8SAdSDzhpy2HtLL5obJuoFIa0FpEqDj
	 DMqIIRlqGLNm3AzF/m8MD1QX3hDKRUwUUOi2A/CXRy4n7LnnrR+E/zwQ6OHFbzXQx1
	 5lUa4Hb6gqOqHRWaaWroVCSPEQditZ6ZZCyb6Dx3pxhh+KoTUq4PbKKfwAujBhA0Pr
	 jLRNSIlC4U81OtLifeKwITGuLadAI0VdXFUxk4PWBurYdTT1Yu42SpL2NhpLRFBVJ/
	 8P/gCpK6QbM6g==
Date: Wed, 17 Apr 2024 19:21:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Conrad Kostecki <conikost@gentoo.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH v2] ata: ahci: Add mask_port_map module parameter
Message-ID: <ZiAFEbDnwuqYWaAU@ryzen>
References: <20240405125143.1134539-1-dlemoal@kernel.org>
 <em6045942b-7739-40b7-8c9d-ad047918cdb8@a351f4b0.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pD4S1Be/oPWgwy7q"
Content-Disposition: inline
In-Reply-To: <em6045942b-7739-40b7-8c9d-ad047918cdb8@a351f4b0.com>


--pD4S1Be/oPWgwy7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Conrad,

On Fri, Apr 05, 2024 at 10:53:55PM +0000, Conrad Kostecki wrote:
> Hi Damien,
>
> Am 05.04.2024 14:51:43, "Damien Le Moal" <dlemoal@kernel.org> schrieb:
>
> > <PATCH v2>
> i did run a test on my hardware.
> It seems to work and adjusting the port_map. But I noticed a difference,
> that those virtual hostXY ports are not marked as DUMMY.
> With the previous patch, only six ports reported "ahci" and rest "DUMMY".
> I am not sure, if that should also not happen with your patch?
> Conrad
> [   13.365573] ahci 0000:09:00.0: masking port_map 0xffffff3f -> 0x3f
> [   13.376511] ahci 0000:09:00.0: SSS flag set, parallel bus scan disabled
> [   13.395670] ahci 0000:09:00.0: AHCI 0001.0301 32 slots 32 ports 6 Gbps
> 0x3f impl SATA mode

This print above suggests that you are testing on a v6.8 based kernel.
(The print has been improved in v6.9)

I do not understand why things are not working for you.


Could you please test with v6.9-rc4 + the attached debug patch.

Please make sure that you don't have any other changes on top of v6.9-rc4
other than the debug patch. (mask_port_map is already included in v6.9-rc4.)



Here is a how v6.9-rc4 + the attached debug patch looks for me with
ahci.mask_port_map=0000:00:03.0=0xf
added to the kernel command line.

(If you use a /etc/modprobe.d/ahci.conf file instead, I assume that should
look something like:
options ahci mask_port_map=0000:00:03.0=0xf
)


[    0.538102] ahci 0000:00:03.0: masking port_map 0x3f -> 0xf
[    0.539063] ahci 0000:00:03.0: port 1/6 is implemented (port_map 0xf)
[    0.539933] ahci 0000:00:03.0: port 2/6 is implemented (port_map 0xf)
[    0.540750] ahci 0000:00:03.0: port 3/6 is implemented (port_map 0xf)
[    0.541663] ahci 0000:00:03.0: port 4/6 is implemented (port_map 0xf)
[    0.542990] ahci 0000:00:03.0: port 5/6 not implemented, mark as dummy (port_map 0xf)
[    0.544121] ahci 0000:00:03.0: port 6/6 not implemented, mark as dummy (port_map 0xf)
[    0.545766] ahci 0000:00:03.0: port 1/6 is implemented, calling init (port_map 0xf)
[    0.546718] ahci 0000:00:03.0: port 2/6 is implemented, calling init (port_map 0xf)
[    0.547642] ahci 0000:00:03.0: port 3/6 is implemented, calling init (port_map 0xf)
[    0.548399] ahci 0000:00:03.0: port 4/6 is implemented, calling init (port_map 0xf)
[    0.549418] ahci 0000:00:03.0: port 5/6 is not implemented, skipping init (port_map 0xf)
[    0.550650] ahci 0000:00:03.0: port 6/6 is not implemented, skipping init (port_map 0xf)
[    0.551306] ahci 0000:00:03.0: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
[    0.551947] ahci 0000:00:03.0: 4/6 ports implemented (port mask 0xf)
[    0.552444] ahci 0000:00:03.0: flags: 64bit ncq only
[    0.553652] scsi host0: ahci
[    0.554138] scsi host1: ahci
[    0.554535] scsi host2: ahci
[    0.555332] scsi host3: ahci
[    0.555806] scsi host4: ahci
[    0.556212] scsi host5: ahci
[    0.556502] ata1: SATA max UDMA/133 abar m4096@0xfebd1000 port 0xfebd1100 irq 43 lpm-pol 3
[    0.557146] ata2: SATA max UDMA/133 abar m4096@0xfebd1000 port 0xfebd1180 irq 43 lpm-pol 3
[    0.557791] ata3: SATA max UDMA/133 abar m4096@0xfebd1000 port 0xfebd1200 irq 43 lpm-pol 3
[    0.558429] ata4: SATA max UDMA/133 abar m4096@0xfebd1000 port 0xfebd1280 irq 43 lpm-pol 3
[    0.559064] ata5: DUMMY
[    0.559260] ata6: DUMMY

Please post your whole log, including both lines prefixed with "scsi" and
"ata".

As you can see, you should see, with your configuration,
32 "scsi: hostX: ahci" prints,
6  "ataX: SATA max ..." prints,
26 "ataX: DUMMY" prints.


If your operating system is using systemd (considering your gentoo address,
this is not a given), you could run:

$ systemd-analyze

both with and without the kernel module option.

You should be able to see a difference.

Or if you don't have systemd, please just upload the full dmesg with and
without the kernel module option, so that we can look at the timestamps.


Kind regards,
Niklas

--pD4S1Be/oPWgwy7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mask_port_map-debug-prints.patch"

From 6b5f6be5ade9bfed6765724877ea72524d965fbb Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 17 Apr 2024 15:41:24 +0200
Subject: [PATCH] mask_port_map debug prints

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c    | 8 +++++++-
 drivers/ata/libahci.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6548f10e61d9..6b54b128ac93 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2011,8 +2011,14 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		ahci_update_initial_lpm_policy(ap);
 
 		/* disabled/not-implemented port */
-		if (!(hpriv->port_map & (1 << i)))
+		if (!(hpriv->port_map & (1 << i))) {
 			ap->ops = &ata_dummy_port_ops;
+			dev_info(host->dev, "port %d/%d not implemented, mark as dummy (port_map %#x)\n",
+				 i+1, host->n_ports, hpriv->port_map);
+		} else {
+			dev_info(host->dev, "port %d/%d is implemented (port_map %#x)\n",
+				 i+1, host->n_ports, hpriv->port_map);
+		}
 	}
 
 	/* apply workaround for ASUS P5W DH Deluxe mainboard */
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 83431aae74d8..11d97d4f44ad 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1303,8 +1303,14 @@ void ahci_init_controller(struct ata_host *host)
 		struct ata_port *ap = host->ports[i];
 
 		port_mmio = ahci_port_base(ap);
-		if (ata_port_is_dummy(ap))
+		if (ata_port_is_dummy(ap)) {
+			dev_info(host->dev, "port %d/%d is not implemented, skipping init (port_map %#x)\n",
+				 i+1, host->n_ports, hpriv->port_map);
 			continue;
+		} else {
+			dev_info(host->dev, "port %d/%d is implemented, calling init (port_map %#x)\n",
+				 i+1, host->n_ports, hpriv->port_map);
+		}
 
 		ahci_port_init(host->dev, ap, i, mmio, port_mmio);
 	}
-- 
2.44.0


--pD4S1Be/oPWgwy7q--
