From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Let AHCI dirver skip Lenovo SWRAID controller
Date: Mon, 25 Jan 2016 13:18:50 +0000
Message-ID: <20160125131850.64c5c22a@lxorguk.ukuu.org.uk>
References: <1453691440-42035-1-git-send-email-hehy1@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:42540 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213AbcAYNTE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jan 2016 08:19:04 -0500
In-Reply-To: <1453691440-42035-1-git-send-email-hehy1@lenovo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ocean HY1 He <hehy1@lenovo.com>
Cc: "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 25 Jan 2016 03:11:40 +0000
Ocean HY1 He <hehy1@lenovo.com> wrote:

> Lenovo SWRAID solution is based on Intel Non-RSTE RAID controller which
> is called Lenovo SWRAID controller by set Lenovo dedicated PCI
> SVID:SDID.
> 
> Because AHCI driver now take control this Lenovo SWRAID controller for
> MDRAID, Lenovo SWRAID driver fails to load later. It's not proper to
> disable AHCI driver, because system has SATA contoller used for SATA
> DVD, M.2 etc. There is no chance to load Lenovo SWRAID first, because
> almost all Linux distros load AHCI driver first during installation.
> 
> As default, when Lenovo SWRAID controller is detected, let AHCI driver
> skip it thus MDRAID is disabled. Use the boot option 'ahci.lenovo_swraid=0'
> could disable Lenovo SWRAID.

You need to submit the Lenovo SWRAID driver to the kernel first.
Otherwise this breaks things.

Alan
