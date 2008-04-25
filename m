From: Mark Lord <liml@rtr.ca>
Subject: libata-eh/pmp command sequence on NCQ media error
Date: Fri, 25 Apr 2008 09:56:11 -0400
Message-ID: <4811E2FB.4040100@rtr.ca>
References: <480F9D29.4070603@rtr.ca> <480FF229.2060808@rtr.ca> <481168FA.5020709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1180 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754987AbYDYN4O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 09:56:14 -0400
In-Reply-To: <481168FA.5020709@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun,

During testing of my internal version of sata_mv.c here,
I noticed the following:

With no port-multiplier attached, a media error during NCQ
results in an immediate READ_LOG_EXT_10H to retrieve the
task file for the failed I/O.

With a port-multiplier, there is instead a flurry of sata_pmp_read()
attempts.  I'm guessing that the READ_LOG_EXT_10H would normally
then follow those ?

The problem is, on most of the Marvell chips, non-data commands
cannot succeed after any kind of error (until after the port is reset),
so they fail, and we never then get to the READ_LOG_EXT_10H stage.
Oddly, the READ_LOG_EXT_10H command itself is okay (with some errata
goodness tossed in).

So, for sata_mv at least, I'd kinda like to have libata-eh attempt
the READ_LOG_EXT_10H before it tries to (unsuccessfully) access the
per-port SCRs on the PMP.

For now, I'll try and hack something into my local tree to ensure
that things will actually work that way around without any other
unforseen complications.

But for upstream, I'm thinking maybe a HORKAGE flag or something?
I'm still trying to avoid having to pull a lot of libata-eh/pmp code
into sata_mv for local customizations.

Suggestions?

Cheers

