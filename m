From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VT6421 problems with sata_via
Date: Sun, 11 Oct 2009 14:16:38 +0100
Message-ID: <20091011141638.616084c0@lxorguk.ukuu.org.uk>
References: <71cd59b00910110254q2e5318cfw30ac0a4f86770487@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36965 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757188AbZJKNPx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Oct 2009 09:15:53 -0400
In-Reply-To: <71cd59b00910110254q2e5318cfw30ac0a4f86770487@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Sun, 11 Oct 2009 11:54:49 +0200
Corentin Chary <corentin.chary@gmail.com> wrote:

> Hi,
> I recently needed some more space and bought a Deskstar 7K1000.B for my server.
> The motherboard is old, and did not have SATA port, so I added a
> VT6421 PCI SATA controller.

Lots of 6421 setups do not work on Linux full stop. I've asked VIA
several times for the relevant data sheet/info to fix this and they've
never done more than acknowledge receipt of the mail.

Alan
