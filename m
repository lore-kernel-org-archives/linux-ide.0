From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Tue, 26 Jan 2010 16:46:42 -0500
Message-ID: <4B5F62C2.4000800@pobox.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com> <20100126160243.018b87e3@lxorguk.ukuu.org.uk> <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:59166 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546Ab0AZVqr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jan 2010 16:46:47 -0500
In-Reply-To: <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vishal Rao <vishalrao@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

On 01/26/2010 11:19 AM, Vishal Rao wrote:
> 2010/1/26 Alan Cox<alan@lxorguk.ukuu.org.uk>:
>>> Should work with 64, 128 (tested) and 256 GB capacities with any
>>> firmware versions in
>>> drivers/ata/libata-core.c because of ATA errors in dmesg, hangs and
>>> filesystem corruption.
>>
>> If you've only tested one type why list all three ? Also you've not
>> listed a firmware version so do you know which are affected ?
>>
>> What controllers did you test with ?
>>
>> Alan
>>
>
> The 3 IDs should match I believe and the firmware parameter is NULL.
> Affected firmware versions include at least the latest 1916 and the
> previous 1819, likely older ones as well.
>
> Tested with my own Crucial CT128M225 model which has the IndiLinx
> Barefoot controller.

By controller, I think Alan meant the host controller (ata_piix, ahci, 
etc.)?

	Jeff



