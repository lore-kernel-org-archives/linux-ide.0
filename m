From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: BIOS does not recognize 500GB-disk
Date: Tue, 3 Jul 2007 19:21:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707031920570.2577@p34.internal.lan>
References: <20070703225517.GA22912@danisch.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:43781 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761076AbXGCXVS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 19:21:18 -0400
In-Reply-To: <20070703225517.GA22912@danisch.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hadmut Danisch <hadmut@danisch.de>
Cc: linux-ide@vger.kernel.org



On Wed, 4 Jul 2007, Hadmut Danisch wrote:

> Hi,
>
> just a question:
>
> I have an older computer with a ASRock K7VT4A Pro mainboard and a VIA sata
> controller.
>
> A 320GB Seagate SATA disk worked pretty well with that board, but now I replaced
> it with a 500GB Western Digital SATA, and the BIOS does not recognize that
> new disk, allthough I've updated the BIOS to the latest available version.
> The disk is not available under Linux (latest Ubuntu, 2.6.20).
>
> I guess it is a BIOS problem, since the disk works in a different, newer
> machine with a newer mainboard.
>
> Is there any way to have Linux to ignore the BIOS and to access that disk
> even if the BIOS didn't recognize it?
>
> regards
> Hadmut
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Turn off NCQ on the drive, limit to 1.5GBps operation, try again, I have 
the same issue with a new RAPTOR (NCQ) and old motherboard.

Justin.
