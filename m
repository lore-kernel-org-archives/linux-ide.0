From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH] libata: use FLUSH_EXT only when driver is larger than LBA28 limit
Date: Fri, 10 Nov 2006 20:18:34 +0100
Message-ID: <20061110191834.GA8359@suse.de>
References: <20061110183304.GA22793@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:23680 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161951AbWKJTT1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Nov 2006 14:19:27 -0500
Content-Disposition: inline
In-Reply-To: <20061110183304.GA22793@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Danny Kukawka <dkukawka@suse.de>

On Sat, Nov 11, 2006 at 03:33:04AM +0900, Tejun Heo wrote:

> Interestingly, at least one of such drives (ST960812A) has problems
> dealing with FLUSH_EXT.  It eventually completes the command but take=
s
> around 7 seconds to finish in many cases thus drastically slowing dow=
n
> IO transactions.  This seems to be a firmware bug which sneaked into
> production probably because no other ATA driver including linux IDE
> issues FLUSH_EXT to drives which report support for LBA48 & FLUSH_EXT
> but is smaller than 1<<28 blocks.

Note that i'm quite sure that i have seen this on more than this single
drive. It might be that those were all seagates, though.
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20
