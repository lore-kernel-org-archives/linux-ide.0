From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SiS 180 pata
Date: Sun, 11 Jul 2004 17:57:33 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40F1B7CD.4060301@pobox.com>
References: <200407051253.47003.ivololeribar@yahoo.it>	 <200407071154.48626.bzolnier@elka.pw.edu.pl>	 <200407071202.55091.bzolnier@elka.pw.edu.pl>	 <200407071618.43587.ivololeribar@yahoo.it> <1089582373.2554.8.camel@uk3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10716 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266566AbUGKV5q
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jul 2004 17:57:46 -0400
In-Reply-To: <1089582373.2554.8.camel@uk3.local>
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: linux-ide@vger.kernel.org, Nicola <ivololeribar@yahoo.it>

Uwe Koziolek wrote:
> Hello Jeff,
> 
> will you support this specific constellation?, or should i try to
> implemenent master/slave support to sata_sis and hope this will solve
> the problem.


It is a similar problem to supporting PATA port of Promise hardware, in 
that you need to use different code paths when talking to the same 
hardware.  It isn't as easy as the solution in ata_piix unfortunately. 
I need to split struct ata_probe_ent into per-bus pieces, then both 
Promise and SIS180 PATA can be supported.

	Jeff


