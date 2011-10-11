From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_scc: add proper cable detection method
Date: Tue, 11 Oct 2011 20:54:15 +0100
Message-ID: <20111011205415.1d5708af@lxorguk.ukuu.org.uk>
References: <201110112007.24530.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35140 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754933Ab1JKTyN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Oct 2011 15:54:13 -0400
In-Reply-To: <201110112007.24530.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 11 Oct 2011 20:07:24 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_scc: add proper cable detection method
> 
> Use standard ata_cable_80wire() method for the cable detection,
> as a bonus this allows us to use the default ->prereset method.

What documentation have you got that confirms that the hardcoding is not
needed. It goes back to the original code and I see nothing saying that
the device has standard PC style cable detect.

You should also I think cc the Toshiba maintainers
