From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 51/86] libata: remove no longer needed pata_qdi driver
Date: Wed, 25 Nov 2009 17:41:05 +0000
Message-ID: <20091125174105.33761baa@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170823.5446.16710.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53906 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759442AbZKYRjA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:39:00 -0500
In-Reply-To: <20091125170823.5446.16710.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Wed, 25 Nov 2009 18:08:23 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] libata: remove no longer needed pata_qdi driver
> 
> QDI65x0 controllers are fully supported by pata_legacy driver
> so remove no longer needed pata_qdi driver.
> 
> Leave PATA_QDI config option for compatibility reasons and teach
> pata_legacy to preserve the old behavior of pata_qdi driver. 

Just delete it nobody will care. I sent Jeff patches to delete it a
couple of times before but they got dropped
