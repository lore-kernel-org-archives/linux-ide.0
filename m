From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Thu, 22 Oct 2009 14:56:13 +0100
Message-ID: <20091022145613.2b7c8c08@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
	<200910212139.24675.bzolnier@gmail.com>
	<20091021.174155.44894825.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36296 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755597AbZJVNyu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Oct 2009 09:54:50 -0400
In-Reply-To: <20091021.174155.44894825.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, mpatocka@redhat.com, linux-ide@vger.kernel.org, elendil@planet.nl

I doubt there is any hardware bug with the SSD. Some CMD64x hardware
certainly has errata and as the data sheets were published your starting
point would be the data sheets for the various chip versions. Does the
sparc use the same off the shelf part as the PC people or does it have
different glue or chip versions (eg as a macro cell in something else ?)

Alan
