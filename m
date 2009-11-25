From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 69/86] pata_scc: add 32-bit PIO support
Date: Wed, 25 Nov 2009 17:48:44 +0000
Message-ID: <20091125174844.7e7b3106@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125171039.5446.68680.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40291 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932456AbZKYRqj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:46:39 -0500
In-Reply-To: <20091125171039.5446.68680.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Wed, 25 Nov 2009 18:10:39 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_scc: add 32-bit PIO support
> 
> There shouldn't be any problems with it as IDE scc_pata host driver
> has been allowing 32-bit PIO operations for years.

NAK; Read the code - it uses its own private data_xfer handler anyway
