From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_cs5520: remove incorrect warning message
Date: Wed, 12 Oct 2011 18:50:07 +0100
Message-ID: <20111012185007.6eb594b0@lxorguk.ukuu.org.uk>
References: <201110112000.44960.bzolnier@gmail.com>
	<20111011205616.15d0b3b3@lxorguk.ukuu.org.uk>
	<201110121727.46778.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201110121727.46778.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

O> This driver dooen't even use DMA mode so warning about forcing the setting
> may be puzzling.  In addition we do the same thing cs5520_reinit_one()
> but without warning the user this time.  Thus removal of the warning makes
> it easier for *_reinit_one() replacement by ->init_host method later
> (patch is ready for this).

The re-init case won't find it mis-set. And the CS5520 is not a normal
controller even for DMA so I'd prefer it left as is.
