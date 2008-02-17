From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ICH7: ata_piix twice as fast as ahci?
Date: Sun, 17 Feb 2008 17:20:45 +0000
Message-ID: <20080217172045.050afd14@core>
References: <6b9952490802170741h1de9be53nefccea3775f7de00@mail.gmail.com>
	<20080217161033.3bb420fd@core>
	<6b9952490802170839m4456353ejfd5a68d0aaccdf88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58931 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751708AbYBQR3F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 12:29:05 -0500
In-Reply-To: <6b9952490802170839m4456353ejfd5a68d0aaccdf88@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joris <joris@v5.be>
Cc: Linux IDE <linux-ide@vger.kernel.org>

> Am I interpreting this correctly as having to choose between fast iops
> with low cpu (+ hotplug) with ahci and twice the linear read speed
> with ata_piix?

Some drives do weird things when NCQ is used and turn off some of their
caching in that case so it depends on the drive what happens to linear
speed.

Alan
