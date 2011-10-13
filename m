From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] libata: remove no longer needed pata_qdi driver
Date: Thu, 13 Oct 2011 16:57:27 +0100
Message-ID: <20111013165727.02f4680b@lxorguk.ukuu.org.uk>
References: <201110131511.39842.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55831 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755659Ab1JMP5k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 11:57:40 -0400
In-Reply-To: <201110131511.39842.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 13 Oct 2011 15:11:39 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] libata: remove no longer needed pata_qdi driver
> 
> QDI65x0 controllers are fully supported by pata_legacy driver
> so remove no longer needed pata_qdi driver.
> 
> Leave PATA_QDI config option for compatibility reasons and teach
> pata_legacy to preserve the old behavior of pata_qdi driver.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>
