From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IT8212 driver seems to be broken - no DMA or functionality in
 general
Date: Mon, 18 Aug 2008 19:12:16 +0100
Message-ID: <20080818191216.78d145c2@lxorguk.ukuu.org.uk>
References: <4405b24e0808120446s14c42968t870de56a0af109c4@mail.gmail.com>
	<4405b24e0808120449r7ce1466bm3387319549dbaa0b@mail.gmail.com>
	<20080812125735.40f46775@lxorguk.ukuu.org.uk>
	<58cb370e0808120547t75cad09ci973f668d4e8fc6fd@mail.gmail.com>
	<4405b24e0808120609v25abbe54s605ad9b3ad96a6f9@mail.gmail.com>
	<4405b24e0808181051n7fbcbd1eu17f0f398ea7d644a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36326 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753176AbYHRS3X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Aug 2008 14:29:23 -0400
In-Reply-To: <4405b24e0808181051n7fbcbd1eu17f0f398ea7d644a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Wells <pete.wells@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Mon, 18 Aug 2008 18:51:18 +0100
"Peter Wells" <pete.wells@gmail.com> wrote:

> Hi Guys,
> 
> Thanks for your help,
> 
> The RAID array is back up and running now.  The device seems to take a
> little while to be recognised and there are still; some error messages
> in dmesg but it's working none the less.

Yeah the raid mode doesn't quite properly emulate ATA so causes the odd
diagnostic during probe. I need to look into that more as we now pull the
list of really present devices from the firmware.

> 
> I've included the output of dmesg below in case it's useful.
> Hopefully it's the relevant chunk.

Thanks.

Alan
