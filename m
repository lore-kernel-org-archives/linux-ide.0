From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] block: export SSD/non-rotational queue flag through
 sysfs
Date: Mon, 5 Jan 2009 18:58:32 +0000
Message-ID: <20090105185832.764cfef0@lxorguk.ukuu.org.uk>
References: <200901051952.58029.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40086 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752332AbZAES6Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 13:58:16 -0500
In-Reply-To: <200901051952.58029.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, 5 Jan 2009 19:52:57 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] block: export SSD/non-rotational queue flag through sysfs
> 
> For some devices (i.e. CFA ATA) we can't reliably detect whether
> the device is of rotational or non-rotational type so we need to
> leave the final decision about this setting to the user-space.
> 
> Suggested-by: Alan Cox <alan@lxorguk.ukuu.org.uk>

Nice - exactly what is needed

Acked-by: Alan Cox <alan@redhat.com>
