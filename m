From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Fri, 30 May 2008 13:19:27 +0900
Message-ID: <483F804F.1@gmail.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200804221444.55483.volker.armin.hemmann@tu-clausthal.de> <480DF1F5.3060208@gmail.com> <200805291654.03617.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:10539 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbYE3ETj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 May 2008 00:19:39 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2901959wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 29 May 2008 21:19:38 -0700 (PDT)
In-Reply-To: <200805291654.03617.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
Cc: Peer Chen <pchen@nvidia.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

Hello,

Hemmann, Volker Armin wrote:
> -AHCI+nomsi: boots fine. Works fine. But: I still can not enable ncq
> -AHCI+msi: the usual. No harddisks found, waiting for the timeouts, then 
> kernel panic because of missing root.
> 
> -NON-RAID/IDE+msi: works fine. No delays. No NCQ (not surprising since mobos 
> handbook says that AHCI mode is required).
> -NON-RAID/IDE+nomsi: see above.

So, sans NCQ, the only remaining issue is MSI, right?  Peer Chen, please
lemme know which controllers are affected by this MSI problem and where
the problem lies.

> but:
> [14315325.624510] ahci 0000:00:0a.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 
> 0xf impl SATA mode
> [14315325.624559] ahci 0000:00:0a.0: flags: 64bit sntf led clo pmp pio
> 
> shouldn't controller and harddisks support turning on NCQ? The handbooks says 
> that NCQ is supported in AHCI mode and the harddisks doesn't seem to be 
> blacklisted.

The controller is not reporting NCQ capability in its cap register
(flags: line contains ncq if the controller is), so NCQ is not enabled.

Thanks.

-- 
tejun
