From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Patch] Enable AHCI on certain ich chipsets
Date: Sat, 12 Feb 2011 13:09:37 +0100
Message-ID: <AANLkTimb3+yk2O2gFVi5_FB-rmf78h-ZRE6a7_KR_dkc@mail.gmail.com>
References: <20110209115929.GS5778@Redstar.dorchain.net>
	<4D528F00.1090000@ru.mvista.com>
	<20110210192321.GB5778@Redstar.dorchain.net>
	<4D552B18.8030808@ru.mvista.com>
	<20110211173620.GF5778@Redstar.dorchain.net>
	<4D55A0FE.30505@ru.mvista.com>
	<20110212062701.GG5778@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40493 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab1BLMJi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Feb 2011 07:09:38 -0500
Received: by qyk12 with SMTP id 12so2751363qyk.19
        for <linux-ide@vger.kernel.org>; Sat, 12 Feb 2011 04:09:37 -0800 (PST)
In-Reply-To: <20110212062701.GG5778@Redstar.dorchain.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joerg Dorchain <joerg@dorchain.net>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org

Hi,

On Sat, Feb 12, 2011 at 7:27 AM, Joerg Dorchain <joerg@dorchain.net> wrote:

> The second part just makes sure that the config space change is
> kept after a resume. Otherwise it comes up as a different PCI
> id, the AHCI driver finds nothing to work with, the harddisk is
> gone after resume, not good.

Shouldn't therefore the quirk be applied also during resume (by
additional use of DECLARE_PCI_FIXUP_RESUME_EARLY in addition to
existing DECLARE_PCI_FIXUP_EARLY one)?

Thanks,
Bartomiej
