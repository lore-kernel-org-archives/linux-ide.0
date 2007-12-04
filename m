From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 4/4] [libata] pata_platform: s/ioport_shift/reg_shift/g
Date: Tue, 04 Dec 2007 20:08:09 +0300
Message-ID: <47558979.40002@ru.mvista.com>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170745.GD15599@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:51941 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751472AbXLDRHx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 12:07:53 -0500
In-Reply-To: <20071204170745.GD15599@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala <galak@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>

Hello.

Anton Vorontsov wrote:

> This patch renames ioport_shift member of pata_platform_info
> structure to reg_shift. Users of pata_platform are followed
> appropriately.

> Rationale of that change is: shifting applies to the whole memory
> mapped region, not only to the command block of the ATA registers,
> despite the fact that shifting is meaningless for ctl register.

> This patch should make Sergei Shtylyov a bit more happy. ;-)

    In fact, I don't care about how platform driver calls this stuff. ;-)
I only care about the property name.

MBR, Sergei
