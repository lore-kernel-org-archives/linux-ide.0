From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: NCQ blacklist
Date: Mon, 15 Jun 2009 13:20:25 +0100
Message-ID: <20090615132025.3407fbe6@lxorguk.ukuu.org.uk>
References: <5cf1b7b10906141540k6336730ep93bba3d97fda7680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42005 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752386AbZFOMTN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jun 2009 08:19:13 -0400
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

Following some off list discussion - NAK this.

There is something going on clearly but it doesn't appear to be the drive
but rather that the I/O patterns with NCQ (maybe the better performance)
are messing something else up.

Needs further exploration to see if this is vm, I/O scheduling or our
current libata lack of protection against drive firmware unfairness (as
the SCSI layer has)
