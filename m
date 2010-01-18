From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 15/64] pata_efar: always program master_data before
 slave_data
Date: Mon, 18 Jan 2010 17:55:56 +0000
Message-ID: <20100118175556.755ae155@lxorguk.ukuu.org.uk>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118171555.14623.3131.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37504 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754435Ab0ARRxK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:53:10 -0500
In-Reply-To: <20100118171555.14623.3131.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Mon, 18 Jan 2010 18:15:55 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_efar: always program master_data before slave_data
> 
> We may need to set SITRE before programming slave_data.

You don't - but making them all the same is worth doing anyway for
readability and future possibly merging into helpers


