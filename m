From: Roland Dreier <rolandd@cisco.com>
Subject: Re: [PATCH] Marvell SATA fixes v2
Date: Fri, 18 Nov 2005 13:57:03 -0800
Message-ID: <52veyp39hs.fsf@cisco.com>
References: <437D2DED.5030602@pobox.com>
	<Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de>
	<20051118215209.GA9425@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ams-iport-1.cisco.com ([144.254.224.140]:18223 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1161251AbVKRV5M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Nov 2005 16:57:12 -0500
In-Reply-To: <20051118215209.GA9425@havoc.gtf.org> (Jeff Garzik's message of
 "Fri, 18 Nov 2005 16:52:09 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

    Jeff> Yes, for both 50xx and 60xx, I had to turn off MSI in order
    Jeff> to get sata_mv to work...

Sounds like MSI is broken in the Marvell chip.  This is exactly the
type of knowledge that needs to be in the low-level driver: which
devices/revisions don't have working MSI.

 - R.
