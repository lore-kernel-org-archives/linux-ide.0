From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] SATA/PATA: convert drivers/ata/* to use module_platform_driver()
Date: Sun, 27 Nov 2011 08:06:51 +0100
Message-ID: <201111270806.52117.marek.vasut@gmail.com>
References: <1322376266.2226.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46127 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab1K0HGz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Nov 2011 02:06:55 -0500
In-Reply-To: <1322376266.2226.3.camel@phoenix>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Alessandro Zummo <a.zummo@towertech.it>, Sylvain Munaut <tnt@246tnt.com>, Anton Vorontsov <avorontsov@ru.mvista.com>, Florian Fainelli <florian@openwrt.org>, Mark Miesfeld <mmiesfeld@amcc.com>, Ashish Kalra <ashish.kalra@freescale.com>, Paul Mundt <lethal@linux-sh.org>, Viresh Kumar <viresh.kumar@st.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

> This patch converts the drivers in drivers/ata/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.
> 
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Sylvain Munaut <tnt@246tNt.com>
> Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Florian Fainelli <florian@openwrt.org>
> Cc: Mark Miesfeld <mmiesfeld@amcc.com>
> Cc: Ashish Kalra <ashish.kalra@freescale.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>


For pata_pxa and pata_palmld please add:

Acked-by: Marek Vasut <marek.vasut@gmail.com>
