From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Random host bus errors with pata_it821x, filesystem corruption
Date: Thu, 4 Dec 2008 21:37:49 +0000
Message-ID: <20081204213749.78dd2eaf@lxorguk.ukuu.org.uk>
References: <200812042101.08613.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42919 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755196AbYLDVhy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 16:37:54 -0500
In-Reply-To: <200812042101.08613.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> Dec  3 21:30:42 pentium kernel: ata3.00: status: { DRDY ERR }
> Dec  3 21:30:42 pentium kernel: ata3.00: error: { IDNF }

The drive firmware is reporting an unreadable block (or invalid block
number)

> I wonder what might cause these errors? I switched the controller into non-RAID mode and read SMART - both drives
> are 100% OK (no pending or reallocated sectors, no errors logged).

I would keep the controller in that mode anyway to be honest - the RAID
mode firmware is a bit variable and some versions blow up for reasons
I've never figured.

Alan
