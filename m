From: Jan Christoph Uhde <UhdeJC@gmx.net>
Subject: Re: disk with ata_piix freezes
Date: Mon, 19 Oct 2009 14:30:17 +0200
Message-ID: <4ADC5BD9.4060907@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46977 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751176AbZJSMaL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Oct 2009 08:30:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

with acpi=off it seems to work, probably i just thought that i had tested that 
option as well and just tried strict, ht, ...
Unfortunately this options causes the video card to fail under X ...

Is there any way to disable acpi for ide only? How do i identify the acpi 
event and ask the piix driver to dismiss the command?

At the moment i am a bit unsure whether this is an ide or acpi problem:(

regards, jan
