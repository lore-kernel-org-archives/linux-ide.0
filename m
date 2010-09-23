From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: PDC42819 porr performance: how to debug?
Date: Thu, 23 Sep 2010 13:35:55 +0200
Message-ID: <19611.15259.211249.821102@pilspetsen.it.uu.se>
References: <20100923091018.14139.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:4976 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754742Ab0IWLgG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Sep 2010 07:36:06 -0400
In-Reply-To: <20100923091018.14139.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-ide@vger.kernel.org

George Spelvin writes:
 > I have an AM2 motherboard with onboard SB600 AHCI, connected to 10
 > identical 2 TB hard drives:
 > - 4 from the onboard SB600 (sd[abcd])
 > - 2 from the motherboard PDC42819 (sd[ef])
 > - 4 from a Si3132 PCIe card (sd[ghij])
 > 
 > I can copy (RAID resync, actually) from sda to sdc (or sdb to sdd)
 > at around 100 MB/s.
 > But copying sda to sde (or sdb to sdf) runs around 25-33 MB/s.
...
 > 04:00.0 RAID bus controller [0104]: Promise Technology, Inc. PDC42819 [FastTrak TX2650/TX4650] [105a:3f20]

There's no public documentation for the PDC42819 aka FastTrak TX{2,4}650.
The only reason it works at all is that it includes an AHCI interface.
But all the advanced stuff is hidden from us.

You can try asking Promise for PDC42819 programming documentation, or
failing that for a 100% open-source driver (no binary blobs).
