From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.29-rc2: thinkpad dock -- cdrom vs. s2ram
Date: Tue, 20 Jan 2009 00:03:05 +0000
Message-ID: <20090120000305.7895eff9@lxorguk.ukuu.org.uk>
References: <20090119202423.GA7070@ucw.cz>
	<200901192150.59438.rjw@sisk.pl>
	<20090119221508.GA2576@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49185 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758196AbZATADX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 19:03:23 -0500
In-Reply-To: <20090119221508.GA2576@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com, trenn@suse.de, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

> I guess I'm confused. I tried:

You want CONFIG_IDE = n, CONFIG_ATA_SFF = y, CONFIG_ATA_PIIX = y

Alan
