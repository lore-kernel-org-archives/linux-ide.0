From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.22-rc3 hibernate(?) disables SMART on ide
Date: Sat, 2 Jun 2007 23:22:23 +0100
Message-ID: <20070602232223.463932da@the-village.bc.nu>
References: <8rnax-6XX-11@gated-at.bofh.it>
	<8rA7H-1B4-1@gated-at.bofh.it>
	<E1Hub8O-0000rF-Hb@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38844 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751192AbXFDMrt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jun 2007 08:47:49 -0400
In-Reply-To: <E1Hub8O-0000rF-Hb@be1.lrz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7eggert@gmx.de
Cc: Tejun Heo <htejun@gmail.com>, David Greaves <david@dgreaves.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, IDE Linux <linux-ide@vger.kernel.org>, ballen@gravity.phys.uwm.edu

> 3) There should be no bad effect from enabling smart, except if the BIOS
>    insists on not booting because of a bad RAID disk. (That's why I like
>    to disable it in the BIOS)

With a couple of exceptions unfortunately. Belongs in udev and smartd so
its controllable and flexible (and also swappable).

Alan
