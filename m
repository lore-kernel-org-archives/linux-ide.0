From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_rdc: parallel scanning needs an extra locking
Date: Thu, 13 Oct 2011 20:11:36 +0100
Message-ID: <20111013201136.20594eff@lxorguk.ukuu.org.uk>
References: <201110131606.04496.bzolnier@gmail.com>
	<20111013164923.23683fcb@lxorguk.ukuu.org.uk>
	<201110131808.31470.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201110131808.31470.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, 13 Oct 2011 18:08:31 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> Alan Cox wrote:
> 
> > On Thu, 13 Oct 2011 16:06:04 +0200
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Subject: [PATCH] pata_rdc: parallel scanning needs an extra locking
> > > 
> > > This is similar change as commit 60c3be3 ("ata_piix: parallel scanning
> > > on PATA needs an extra locking") for ata_piix host driver.
> > 
> > Again has anyone verified with the vendor that the RDC can support
> > parallel scanning ?
> 
> Upstream has always used it:

Fair enough as nobody has complained.
