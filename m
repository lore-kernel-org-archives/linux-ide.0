From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: prepare for removal of experimental tag on PATA
 drivers
Date: Sat, 14 Nov 2009 15:23:47 +0000
Message-ID: <20091114152347.733a52b7@lxorguk.ukuu.org.uk>
References: <200911141537.19068.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44628 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753340AbZKNP1D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Nov 2009 10:27:03 -0500
In-Reply-To: <200911141537.19068.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 14 Nov 2009 15:37:19 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> Push experimental tags to host drivers that still need it so we can
> remove the "global" experimental tag for PATA drivers.
> 
> I hear that some issues are being worked on but the patch reflects
> the current situation and we can trivially update status of affected
> host drivers after new fixes are merged.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

NAK

