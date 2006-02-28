From: "Shem Multinymous" <multinymous@gmail.com>
Subject: ICH6M legacy hotswap?
Date: Tue, 28 Feb 2006 11:35:45 +0200
Message-ID: <41840b750602280135j511a7584m80b0b1f549780bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:18273 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932140AbWB1Jfq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 04:35:46 -0500
Received: by wproxy.gmail.com with SMTP id i13so92123wra
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 01:35:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>

Hi,

Is there currently any kludge/patch/hack for hot/warm/cold swapping on
the PATA port of ICH6M in legacy mode with ata_piix/libata? Or a way
to switch the ICH6M to AHCI mode (in the absence of BIOS support) and
then get AHCI hot/warm/coldwap?

I'm trying to get hot-swapping of the UltraBay DVD drive on a ThinkPad T43.

(There's a new kernel module, lt_hotswap, that provides IDE
hotswapping on some PATA machines, such as older ThinkPads. It fiddles
with ACPI and the legacy ide driver's internals, so it doesn't work
with the ata_piix driver needed on the ThinkPad T43.)

  Shem
