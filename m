From: Vishal Rao <vishalrao@gmail.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Wed, 27 Jan 2010 05:54:56 +0530
Message-ID: <aacba7e1001261624m4358e4ebwcf8e2305b0c5fc16@mail.gmail.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>
	 <20100126160243.018b87e3@lxorguk.ukuu.org.uk>
	 <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
	 <4B5F62C2.4000800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:38940 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab0A0AZH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jan 2010 19:25:07 -0500
In-Reply-To: <4B5F62C2.4000800@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

2010/1/27 Jeff Garzik <jgarzik@pobox.com>:
> On 01/26/2010 11:19 AM, Vishal Rao wrote:
>> 2010/1/26 Alan Cox<alan@lxorguk.ukuu.org.uk>:
>>> What controllers did you test with ?
>> Tested with my own Crucial CT128M225 model which has the IndiLinx
>> Barefoot controller.
>
> By controller, I think Alan meant the host controller (ata_piix, ahci,
> etc.)?

Oh I see, I have an Intel DP35DP motherboard with onboard IDE controller
with AHCI enabled. I hope thats sufficient information for now. I did read
that simply setting the mode to legacy IDE would disable NCQ there but
would disable for all drives connected.

Please let me know if further info/log files (dmesg, lspci etc) would help
and I will pastebin them...
