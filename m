From: Ricky Beam <jfbeam@bluetronic.net>
Subject: Re: [BK-Patch] ST3160023AS needs mod15
Date: Fri, 2 Jul 2004 12:22:07 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.33.0407021219460.25702-100000@sweetums.bluetronic.net>
References: <40E58BE9.7090000@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sweetums.bluetronic.net ([24.199.150.42]:52954 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264723AbUGBQ25 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 12:28:57 -0400
In-Reply-To: <40E58BE9.7090000@superbug.demon.co.uk>
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Fri, 2 Jul 2004, James Courtier-Dutton wrote:
>What does SIL_QUIRK_MOD15WRITE do?

Limits max_sectors to 15.  This prevents odd problems with DMA writes to the
drive. (And maybe reads too, but those don't lock up the controller.)

>I have used ST3160023AS for a long time now without any problems in
>kernel 2.6.x

What's that drives firmware revision? (dmesg, eg.)

  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05

--Ricky


