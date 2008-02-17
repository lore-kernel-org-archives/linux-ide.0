From: "Paul Fleischer" <paul@xpg.dk>
Subject: Re: DMA being disabled during heavy HD activity
Date: Sun, 17 Feb 2008 15:20:19 +0100
Message-ID: <ab2fc2a60802170620u6c717c16u10e14fec7500a1b5@mail.gmail.com>
References: <ab2fc2a60802170323o341fe1d8lfb91de8339f11e6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:1739 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764AbYBQOUU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 09:20:20 -0500
Received: by an-out-0708.google.com with SMTP id d31so302078and.103
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 06:20:19 -0800 (PST)
In-Reply-To: <ab2fc2a60802170323o341fe1d8lfb91de8339f11e6a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi again,

2008/2/17, Paul Fleischer <paul@xpg.dk>:
> Hi,
>
> I am experiencing some strange behaviour. When I have heavy HDD
> activity (running MythTV, for instance), I get 17 of these:
>
> [   90.004956] hda: dma_intr: bad DMA status (dma_stat=76)
> [   90.004963] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> [   90.004966] ide: failed opcode was: unknown

I have now found out that it is not heavy HDD activity that causes
this. It occurs when I start using the 3D capabilities of the fglrx
driver. I suspect that there is some kind of resource conflict between
the fglrx driver and the IDE system. But as the fglrx driver is closed
source I know that I'm on deep water here. Maybe someone has a
suggestions.

I apologize about the noise on the mailing list.

/Paul
