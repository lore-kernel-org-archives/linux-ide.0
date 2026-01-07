Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F830ACE8
	for <linux-ide@vger.kernel.org>; Wed,  7 Jan 2026 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767784849; cv=none; b=Qd2OQgIeEt2ZH3llYpNoUHx85yYDa5FdDNh54Dijuqz1ToZ5UvjKzWiJzZJZFJkRZcJ1reK0QidDpeYH9JFt8hSl47nRQ7w6B80/fs2HHU4RvuP/g4A1tUNQ348mpbtoQcvG7ZxKuw4CG/LV27djWKlndr6UregiGXisP/c/eCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767784849; c=relaxed/simple;
	bh=Fjg7mImYvpisuz4vN6cVY48lD7rwKIpdUI5j0T2Kty0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKLwgbgOWZSmRuKG9oSlklfqgMTJra0d+6jbG2beHyaeS+QZNo4nop4APrw4SopDqcHx94ArSekdEKSavubY5N6rf/jL4I2B3hwzDJNEUyxQcJSYX3C2QMiEgpKco89nvMTWDMKeuHyrUYXQdNAKMu1EyLxgmLEGBlhW7bT2xfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exn/gUKy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exn/gUKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8248C19422;
	Wed,  7 Jan 2026 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767784847;
	bh=Fjg7mImYvpisuz4vN6cVY48lD7rwKIpdUI5j0T2Kty0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exn/gUKySOT3xrBerPjwOlp7Ayd8eaqs527DplsjRovMh/npge+3PflWCYXYFv6BD
	 ozLw5LI12/uTXaLbFTFNAsnHZ3ML9b2fl5hkbOaAKDvHcd1jVMn+Ltlpix9pf4umWr
	 FKySm0CrRIMcZ4tQ90Wu8awo+qI3NKha0J/971wLFGI6a1yhZJnZ3W2LwbT/LZJau8
	 PWBKpVRCz8eiQGUfdtHQiRL0p/eWW3Vn6ZwwzLM4KsPMi3FqKckZbKxan0WybMNdxo
	 +ozEDt2B+EVrWvlJnOy8s4OS5srwixhggtA+TmjKLKDtE2sf8jIs2d8Yaw+oLFxgMX
	 XUQwVcRRfnNZQ==
Date: Wed, 7 Jan 2026 12:20:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: wolf@yoxt.cc, linux-ide@vger.kernel.org
Subject: Re: [REGRESSION] libata: SATA LPM forcibly disabled on Intel Raptor
 Lake since Linux 6.14.
Message-ID: <aV5BjOXc1uK2HSZA@ryzen>
References: <605b34a7723436284699c9a8e524907b@yoxt.cc>
 <aV4yBZkxVD2Olg3X@ryzen>
 <85cae643-f3bc-43db-966c-3f57d8daa6b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85cae643-f3bc-43db-966c-3f57d8daa6b6@kernel.org>

On Wed, Jan 07, 2026 at 11:19:42AM +0100, Damien Le Moal wrote:
> > 
> > This is most likely because your ports are marked as External / Hotplug
> > capable by BIOS.
> 
> I do not think so. There is no "ext" advertized in the log for the valid ports.
> But still worth trying to see if the BIOS has a hotplug option and disable it if
> it does.

Good catch.

One thing that caught my eye:
[    1.433187] ata6.00: ATAPI: PIONEER BD-RW  BDR-S12JX, 1.01, max UDMA/100
[    1.433272] ata5.00: ATAPI: PIONEER BD-RW  BDR-S12JX, 1.01, max UDMA/100

We've had so many problems with PIONEER...


So, since we concluded that you don't have any ports marked as External,
to get deeper sleep states, all SATA ports will need to be in a power
saving state.

Ports that don't have any device connected will get powered off, so they
are no problem.


For LPM to work, you need to use either HIPM (host-initiated) or DIPM
(device initiated). You can have both enabled, but the device needs to
support one of them to enter a power saving state.


I think the problem is:

[    3.010059] ata8.00: ATA-11: ST16000NM000J-2TW103, SN06, max UDMA/133
[    3.010079] ata7.00: ATA-11: ST16000NM000J-2TW103, SN06, max UDMA/133
[    3.012748] ata6.00: ATAPI: PIONEER BD-RW  BDR-S12JX, 1.01, max UDMA/100
[    3.012779] ata5.00: ATAPI: PIONEER BD-RW  BDR-S12JX, 1.01, max UDMA/100
[    3.061873] ata8.00: Features: DIPM NCQ-sndrcv
[    3.065319] ata7.00: Features: DIPM NCQ-sndrcv

The ST drives advertise support for DIPM, so these two ports should enter
a lower power state.


For the PIONEER optical drives however, we don't seem to get any "Features: "
print at all. My guess is that the support neither HIPM nor DIPM, and thus
stops the whole system from entering a lower power state.


What I think happens:

For a device that does not support HIPM, we will clear flag ATA_LPM_HIPM from
hints:
https://github.com/torvalds/linux/blob/v6.19-rc4/drivers/ata/libata-eh.c#L2168-L2169

If flag ATA_LPM_HIPM is not set, we will disable HIPM (ALPE) for the port:
https://github.com/torvalds/linux/blob/v6.19-rc4/drivers/ata/libahci.c#L835-L847

Thus the HBA will never tell the device to enter a low power state.
(And if DIPM is not supported, the device itself will never enter a low
power state.)


Questions:
-Why was this not a problem on older kernels?

If you are willing try some patches from us, we could give you a patch with more
debug prints, to show for each device, when we {enable,disable} {HIPM,DIPM}.


-Why don't we get the Features: print for ATAPI devices?

We probably need something like this:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fc250b494ce3..a8af200ac24f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3161,11 +3161,13 @@ int ata_dev_configure(struct ata_device *dev)
                /* print device info to dmesg */
                if (print_info)
                        ata_dev_info(dev,
-                                    "ATAPI: %s, %s, max %s%s%s%s\n",
+                                    "ATAPI: %s, %s, max %s%s%s%s%s%s\n",
                                     modelbuf, fwrevbuf,
                                     ata_mode_string(xfer_mask),
                                     cdb_intr_string, atapi_an_string,
-                                    dma_dir_string);
+                                    dma_dir_string,
+                                    ata_id_has_hipm(dev->id) ? " HIPM" : "",
+                                    ata_id_has_dipm(dev->id) ? " DIPM" : "");
        }
 
        /* determine max_sectors */



Kind regards,
Niklas
