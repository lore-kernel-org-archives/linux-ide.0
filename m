From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 03/64] pata_ali: cleanup ali_set_piomode()
Date: Mon, 18 Jan 2010 17:46:02 +0000
Message-ID: <20100118174602.47f8ec24@lxorguk.ukuu.org.uk>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118171412.14623.94854.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37212 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753988Ab0ARRnR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:43:17 -0500
In-Reply-To: <20100118171412.14623.94854.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Mon, 18 Jan 2010 18:14:12 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_ali: cleanup ali_set_piomode()
> 
> Merge ali_fifo_control() calls.

This also changes the behaviour. The old driver, reference code and old
IDE driver (at least at the time I did pata_ali) all did the fifo off
case, then the mode change, then the FIFO on case.

I don't see why it should matter but it ought to be noted in the changelog

