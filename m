From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] pmac ide doesn't properly cleanup hwif when
	releasing controller
Date: Sun, 30 Oct 2005 09:09:55 +1100
Message-ID: <1130623795.29054.179.camel@gaston>
References: <20051029044852.1a518908@Tatooine.r3z0>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:15081 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932465AbVJ2WKi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Oct 2005 18:10:38 -0400
In-Reply-To: <20051029044852.1a518908@Tatooine.r3z0>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, linux-ide@vger.kernel.org

On Sat, 2005-10-29 at 04:48 +0200, Thibaut VARENE wrote:

> I've been investigating the IDE code a bit, and it seems that it generally
> assumes that an interface cannot be released once claimed. Cleaning up the
> hwif without knowing its previous state in pmac.c is a big and potentially
> dangerous job, and there seems to be no generic code interface that would
> provide either a way to properly release an hwif or to clean it up.
> 
> The rationale behind this is related to the value of MAX_HWIFS, which is
> usually pretty low (usually between 2 and 10).
> 
> So the question is "what should be done (and how)"?

Bart, the problem here is indeed the code in pmac IDE that tries to
"release" HWIFs to the core if they are probed empty. For some reason,
it used to work (I think ide-dma used to unconditionally override the
callbacks) but not any more.

Thus my question: Should I

 - Manually in ide-pmac clean up all callbacks & revert everything in
the HWIF when I want to hand it back

 - Call init_hwif_data() despite the nasty comment on top

 - Just don't release the interface...

Ben.


