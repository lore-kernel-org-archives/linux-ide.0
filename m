From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] cs5520: add missing IRQ setup for the second port
Date: Tue, 23 Jun 2009 16:33:24 +0100
Message-ID: <20090623163324.715421f5@lxorguk.ukuu.org.uk>
References: <200906221348.02632.bzolnier@gmail.com>
	<200906230158.12805.elendil@planet.nl>
	<20090623094206.4d1f1b5b@lxorguk.ukuu.org.uk>
	<200906231159.01295.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56842 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760792AbZFWPcD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 11:32:03 -0400
In-Reply-To: <200906231159.01295.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Frans Pop <elendil@planet.nl>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > The cs5520 isn't a standard IDE controller in the first place and doesn't
> > have two channels anyway. It's special as it uses non standard bar
> 
> Please note that both cs5520.c / pata_cs5520.c assume that the controller
> has two ports (please verify whether they need some fixing, thanks)..

It can it turns out have two if the relevant external logic is present.

Alan
