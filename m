From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: NCQ blacklist
Date: Mon, 15 Jun 2009 00:01:04 +0100
Message-ID: <20090615000104.4c65548e@lxorguk.ukuu.org.uk>
References: <5cf1b7b10906141540k6336730ep93bba3d97fda7680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46655 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752571AbZFNW7w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Jun 2009 18:59:52 -0400
In-Reply-To: <5cf1b7b10906141540k6336730ep93bba3d97fda7680@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrea Bravetti <andreabravetti@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, 15 Jun 2009 00:40:23 +0200
Andrea Bravetti <andreabravetti@gmail.com> wrote:

> Please add "WDC WD3200BEVT-22ZCT0" to the NCQ blacklist.
> 
> I had some performance problem and I added this line:
> 
>         { "WDC WD3200BEVT-22ZCT0", NULL, ATA_HORKAGE_NONCQ },
> 
> around line 4184 of drivers/ata/libata-core.c (linux 2.6.30),
> and now it work quite well...

Which controller, what firmware revision, what sort of performance problem

Before blacklisting a drive we really need a lot more data. In paticular
any error messages in dmesg. Ideally also two or three different systems
seeing the same problem (so we know the drive is really the root cause)

Alan
