Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9657EDB7;
	Wed,  9 Sep 2026 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970388; cv=none; b=m1hUC2pf9910lRoorojwoItNiqj0y5iQzM+e3G3iadJcxem4v+dcnGRSW2dDz/gVhMI88v3MEJ4xE65L5/vKsSWlQyMgLZ3NqGjqEMFgNram8dDUdY2fruTPrdaqM7B6mVghJzv+2XeQtIfLY95MVnxAOUxm1czHdz90OoLvGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970388; c=relaxed/simple;
	bh=byE+OFkcdTjyJQc+32oKlCFAplREh8utA4QZ6OpXB9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvDnG2k9b0rRX41HoOTAznYpKy5D3nfHE1hknMpZ+5NkCfDAeINjZGDb2EJnLkuTQSwn5owgc8t1oS3La+y8W5N+LwpXSw7IHks6r1pi6yolybuegUH70Q1A/2SnllshbJJAnUywq6U+Yxg7SKOPb2mPmowqPUC2Re15Dd/44vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REdSnzo8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REdSnzo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5329C1F00A3A;
	Wed,  9 Sep 2026 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970386;
	bh=+XLjACGlnf7x3hBb2vIi5wesWQ0LmqewDIS0LFCfzI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=REdSnzo861ortOykg6YtqA1EKE7giP5iyOdFahxCM9znsrOBHmMo8nSpjG4UOTRbI
	 j60outPVgGUHBO8z01uANqdJvfLzxzvRaN7IJfymydvT2LDwjjaLc0/NWvcH2GCQWd
	 oYJK3ro2/WF1AEMk1w54FSzNqw+VAeJRstoRYgErJpvGP6zBTlYw4MaYMk6ReEA7Iv
	 cGs5fJ1qm3jpqLyiqKB7TKAfAL8a2Lck2k9qyXHqs382dB60leksSGcko/j5w8YtsU
	 O2OqydBhH47tPJxSTh9/nxOteXqlVtWg+laCqySy2ShOhuX0M0Vosxfc3Xw7OGcUA3
	 CXpECC/62534g==
Date: Wed, 9 Sep 2026 18:13:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Nikolay Borisov <nik.borisov@suse.com>, linux-ide@vger.kernel.org,
	dlemoal@kernel.org, Rosen Penev <rosenp@gmail.com>
Subject: Re: [PATCH v2] ata: sata_dwc_460ex: Don't enable interrupt if libATA
 core registration fails
Message-ID: <aqGFjsuIMRIy5xfv@ryzen>
References: <20260909112426.811456-1-nik.borisov@suse.com>
 <20260909113821.A72011F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909113821.A72011F00A3A@smtp.kernel.org>

On Wed, Sep 09, 2026 at 11:38:21AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Inverted teardown sequence for the PHY on probe error path, calling phy_power_off() after phy_exit().

Looking at ahci_platform.c:ahci_probe()

ahci_probe() calls
ahci_platform_enable_resources() which calls ahci_platform_enable_phys()
which calls
phy_init() and phy_power_on().

ahci_probe() later calls
ahci_platform_init_host() which calls ahci_host_activate()

if ahci_platform_init_host() fails, ahci_probe() calls

calls ahci_platform_disable_resources(), which calls
phy_power_off() and and phy_exit().


So the problem is that sata_dwc_460ex calls phy_power_on() in
->port_stop.
(And that it calls phy_power_on() in ->port_start()).


These calls should just be in sata_dwc_probe().
I don't see any other driver doing phy_power_on()/phy_power_off()
in ->port_start()/->port_stop().

It seems very wrong... Because sata_dwc_460ex will call phy_power_off()
for the same phy, when having multiple ports. phy_power_off() should
not be called multiple times on the same phy.


This driver is quite broken.

You could just send a patch that does:

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8e3fc713891a..0690e31719d2 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1185,11 +1185,12 @@ static int sata_dwc_probe(struct platform_device *ofdev)
         * error_handler() to execute a dummy Softreset EH session
         */
        err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
-       if (err)
+       if (err) {
                dev_err(dev, "failed to activate host");
-
-       /* Enable SATA Interrupts */
-       sata_dwc_enable_interrupts(hsdev);
+       } else {
+               /* Enable SATA Interrupts */
+               sata_dwc_enable_interrupts(hsdev);
+       }
        return 0;
 
 error_out:


Or if you want to clean this up, create a patch that moves
the phy_power_on() from ->port_start() to sata_dwc_probe()
and phy_power_off() from ->port_stop() to sata_dwc_probe().

Then you will be able to call goto error_out; on ata_host_activate() failure.


Kind regards,
Niklas
