From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Wed, 27 Jan 2010 17:49:49 -0500
Message-ID: <4B60C30D.4040203@teksavvy.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>	 <20100126160243.018b87e3@lxorguk.ukuu.org.uk>	 <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>	 <4B5F62C2.4000800@pobox.com> <aacba7e1001261624m4358e4ebwcf8e2305b0c5fc16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:61239 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756318Ab0A0Wtv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jan 2010 17:49:51 -0500
In-Reply-To: <aacba7e1001261624m4358e4ebwcf8e2305b0c5fc16@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vishal Rao <vishalrao@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

Vishal Rao wrote:
> 2010/1/27 Jeff Garzik <jgarzik@pobox.com>:
>> On 01/26/2010 11:19 AM, Vishal Rao wrote:
>>> 2010/1/26 Alan Cox<alan@lxorguk.ukuu.org.uk>:
>>>> What controllers did you test with ?
>>> Tested with my own Crucial CT128M225 model which has the IndiLinx
>>> Barefoot controller.
>> By controller, I think Alan meant the host controller (ata_piix, ahci,
>> etc.)?
> 
> Oh I see, I have an Intel DP35DP motherboard with onboard IDE controller
> with AHCI enabled. I hope thats sufficient information for now. I did read
..

Okay, that's ICH9.  I'll see if I have an ICH9 kicking around here
that I can put an OCZ/Indilinx drive onto.  The current v1.5 OCZ firmware
is probably pretty close to the 1916 build version that your Crucial has.

-ml
