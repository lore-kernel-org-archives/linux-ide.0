From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 18:49:19 +0100
Message-ID: <201001041849.19591.bzolnier@gmail.com>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20100104172816.GD18335@flint.arm.linux.org.uk> <20100104173958.28439d63@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41485 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab0ADRuk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 12:50:40 -0500
Received: by ewy19 with SMTP id 19so7543936ewy.21
        for <linux-ide@vger.kernel.org>; Mon, 04 Jan 2010 09:50:39 -0800 (PST)
In-Reply-To: <20100104173958.28439d63@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

On Monday 04 January 2010 06:39:58 pm Alan Cox wrote:
> > Firstly, icside shares its two IDE channels with one DMA engine - so it's
> > a simplex interface.  IDE supports those (or did when the code was written)
> > serializing requests between the two interfaces.  libata does not.
> 
> Libata does the driver may not.

IIRC it didn't at the time pata_icside was written.

--
Bartlomiej Zolnierkiewicz
