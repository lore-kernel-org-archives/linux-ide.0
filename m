From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/68] ide2libata
Date: Sat, 30 Jan 2010 16:24:10 +0100
Message-ID: <201001301624.10174.bzolnier@gmail.com>
References: <20100129160308.21495.14120.sendpatchset@localhost> <4B6355DF.9050001@garzik.org> <20100129232540.41f6c4f6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:57254 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab0A3PYx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jan 2010 10:24:53 -0500
In-Reply-To: <20100129232540.41f6c4f6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 30 January 2010 12:25:40 am Alan Cox wrote:

> So I think its an extremely useful exercise to figure out what subtle
> differences there are between the drivers. It's not then a trivial
> assumption that they can just be pasted over. The include stuff though is

Fully agreed, that is why a fair deal of review work went into making
sure that porting of a each driver to ide2libata doesn't cause functionality
changes.

> too ugly to merge even if its an excellent research project to identify
> the differences and quirks.

Well, looks acceptable to me when the alternative is a duplicated code
(though I don't insists on getting it merged anyway)..

--
Bartlomiej Zolnierkiewicz
