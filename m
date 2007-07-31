From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Tue, 31 Jul 2007 17:29:29 +0400
Message-ID: <46AF3939.8020805@ru.mvista.com>
References: <1185880124.3483.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:11448 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759829AbXGaN1a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jul 2007 09:27:30 -0400
In-Reply-To: <1185880124.3483.25.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Ham <rah@bash.sh>
Cc: linux-ide@vger.kernel.org

Bob Ham wrote:

> I've had a Highpoint Rocket 1540 (not "RocketRAID") SATA controller for
> a while now, using a proprietary binary driver from Highpoint in a linux
> 2.4 kernel.  The chipset is an hpt374.  The hpt366 driver freezes on
> boot, as reported by others.

    Can we see a bootlog please?

> I'm wondering if there are or will be libata drivers, or any drivers for
> that matter, for hpt374-based SATA cards?

    As HPT374 is not a SATA chip, it needs SATA bridges to work with SATA 
drives, hence no the only HPT374 libata driver that's going to ever be is 
pata_hpt37x.

> Cheers,
> Bob Ham

MBR, Sergei
