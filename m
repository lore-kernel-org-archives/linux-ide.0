From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] pata_serverworks: cleanup cable detection
Date: Wed, 12 Oct 2011 18:55:48 +0100
Message-ID: <20111012185548.4fa03544@lxorguk.ukuu.org.uk>
References: <201110112011.44748.bzolnier@gmail.com>
	<20111011205141.7a8bac1c@lxorguk.ukuu.org.uk>
	<201110121705.39026.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60997 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751580Ab1JLR4d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 13:56:33 -0400
In-Reply-To: <201110121705.39026.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 12 Oct 2011 17:05:38 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> Alan Cox wrote:
> 
> > On Tue, 11 Oct 2011 20:11:44 +0200
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Subject: [PATCH] pata_serverworks: cleanup cable detection
> > > 
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > 
> > Again no documentation although its at least a bit more obvious why
> 
> The patch only merges identical cable routines for Dell and Sun
> systems into common oem_cable() one.  No behavior changes here.

So put that that in the patch info. It seems fine to me but it ought to
be there
