From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Trouble with hdparm -d on Dell D610
Date: Fri, 11 Jan 2008 21:05:57 +0000
Message-ID: <20080111210557.390271a0@lxorguk.ukuu.org.uk>
References: <7f68de3e0801111118x3fecace5n5c1f10b90b595d2f@mail.gmail.com>
	<20080111193036.787a9fdc@lxorguk.ukuu.org.uk>
	<7f68de3e0801111149x15afd429sf48ed7db5fff8fa1@mail.gmail.com>
	<20080111195521.7e771e45@lxorguk.ukuu.org.uk>
	<7f68de3e0801111227x50c9ff31n1435d005e6b6b1f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45968 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758226AbYAKVIU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 16:08:20 -0500
In-Reply-To: <7f68de3e0801111227x50c9ff31n1435d005e6b6b1f3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristin Vadas Marsicano <kristin.marsicano@gmail.com>
Cc: linux-ide@vger.kernel.org

Thanks. You do indeed have both the old IDE and new IDE drivers trying to
drive bits of the system. I don't see the CD-ROM in the dmesg at all
however ?

If you turn off CONFIG_ATA you should get just old IDE drivers and your
disk back working sanely.

Alan
