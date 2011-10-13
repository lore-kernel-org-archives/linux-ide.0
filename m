From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_ali: cleanup ali_set_piomode()
Date: Thu, 13 Oct 2011 13:53:28 +0100
Message-ID: <20111013135328.5136b50f@lxorguk.ukuu.org.uk>
References: <201110131309.26032.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57418 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752901Ab1JMMy4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 08:54:56 -0400
In-Reply-To: <201110131309.26032.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 13 Oct 2011 13:09:25 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_ali: cleanup ali_set_piomode()
> 
> Merge ali_fifo_control() calls.
> 
> This changes behavior but there shouldn't be any problems with it.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

It's not really much of a 'clean' and the old behaviour matches the
documentation.

