From: Holger Macht <hmacht@suse.de>
Subject: Re: 2.6.29-rc2: thinkpad dock -- cdrom vs. s2ram
Date: Tue, 20 Jan 2009 19:39:19 +0100
Message-ID: <1232476759.5286.6.camel@homac.suse.de>
References: <20090119202423.GA7070@ucw.cz> <200901192150.59438.rjw@sisk.pl>
	 <20090119221508.GA2576@elf.ucw.cz>
	 <20090120000305.7895eff9@lxorguk.ukuu.org.uk>
	 <20090120124711.GA1920@elf.ucw.cz>
Reply-To: hmacht@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:34628 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757069AbZATSkS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 13:40:18 -0500
In-Reply-To: <20090120124711.GA1920@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com, trenn@suse.de, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Am Dienstag, den 20.01.2009, 13:47 +0100 schrieb Pavel Machek:
> On Tue 2009-01-20 00:03:05, Alan Cox wrote:
> > > I guess I'm confused. I tried:
> > 
> > You want CONFIG_IDE = n, CONFIG_ATA_SFF = y, CONFIG_ATA_PIIX = y
> 
> Thanks.
> 
> With those options, cdrom moved from hda to sr0, and is correctly
> unregistered when undocking. Unfortunately, it is not correctly
> re-registered when I insert machine back into the dock :-(... so
> something is still not right in docking area.

Does this work when you try without the dock station, just removing and
inserting the cdrom?

Regards,
	Holger

