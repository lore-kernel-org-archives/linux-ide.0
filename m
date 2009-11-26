From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 16/86] pata_efar: MWDMA0 is unsupported
Date: Thu, 26 Nov 2009 18:33:13 +0300
Message-ID: <4B0E9FB9.8050508@ru.mvista.com>
References: <20091125170218.5446.13513.sendpatchset@localhost>	<20091125170415.5446.15073.sendpatchset@localhost>	<20091125172552.6817e3da@lxorguk.ukuu.org.uk>	<200911261553.58941.bzolnier@gmail.com> <20091126151546.6c891014@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:41666 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752690AbZKZPcQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 10:32:16 -0500
In-Reply-To: <20091126151546.6c891014@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

>>On Wednesday 25 November 2009 06:25:52 pm Alan Cox wrote:

>>>On Wed, 25 Nov 2009 18:04:15 +0100
>>>Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

>>>>From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>>>Subject: [PATCH] pata_efar: MWDMA0 is unsupported

>>>>MWDMA0 timings cannot be met with the PIIX based controller
>>>>programming interface.

>>>The efar documentation makes no reference to not being capable of MWDMA0,
>>>so where does this come from ? No MWDMA0 is an Intel erratum it appears.

>>No MWDMA0 support is a common issue on all 'PIIX-like' controllers.

>>In case of this chipset while the (preliminary) documentation claims MWDMA0
>>support on the 'FEATURES' page the later 'programming guide' part describes
>>only PIO0-4, SWDMA2, MWDMA1-2 and UDMA0-4 transfer modes as supported.

> Cool - I only have the original docs.

    Hm, me too... perhaps worth putting in Jeff's documentation archive?

MBR, Sergei
