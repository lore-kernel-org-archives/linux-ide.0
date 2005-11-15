From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: ata_port->device[] question
Date: Tue, 15 Nov 2005 13:33:04 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0511151328070.28745@shark.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:4785 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750847AbVKOVdH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2005 16:33:07 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2005 13:33:04 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


libata-core.c, around line 1299, says:

static inline u8 ata_dev_knobble(const struct ata_port *ap)
{
	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device->id)));
}

That's the same as this: (right?)

	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device[0]->id)));
	                                                                ~~~

and is this intentional?
I.e., always using device[0] for this bridge check?

Just curious.
thanks,
-- 
~Randy
