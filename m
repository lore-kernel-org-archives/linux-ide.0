From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 11/86] pata_atiixp: remove custom BMDMA methods
Date: Wed, 25 Nov 2009 17:34:14 +0000
Message-ID: <20091125173414.6a87c74b@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170337.5446.40572.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41301 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758867AbZKYRcJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:32:09 -0500
In-Reply-To: <20091125170337.5446.40572.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Wed, 25 Nov 2009 18:03:37 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_atiixp: remove custom BMDMA methods
> 
> Enable/disable UDMA bit only once in ->set_dmamode method
> and then remove custom ->bmdma_[start,stop] methods.
> 
> There shouldn't be any problems with it as IDE atiixp host driver
> has been doing it this way for last two years.

This comes from the original ATI code so should be double checked with
ATI but seems reasonable if it works.
