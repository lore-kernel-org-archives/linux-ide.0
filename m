From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 14:33:51 +0000
Message-ID: <20091119143351.1d0e2c59@lxorguk.ukuu.org.uk>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>
	<200911182056.16517.bzolnier@gmail.com>
	<20091119131636.15800a11@linux.intel.com>
	<200911191517.15090.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35610 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753346AbZKSOby (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 09:31:54 -0500
In-Reply-To: <200911191517.15090.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, 19 Nov 2009 15:17:14 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Thursday 19 November 2009 14:16:36 Alan Cox wrote:
> > > Only pata_hpt37x has broken cable detection while pata_hpt3x2n is
> > > okay. ;)
> > 
> > I think you have that backwards according to the vendor drivers. 3x2n
> > looks like it needs adjusting.
> 
> lol, just fix the damn pata_hpt37x driver _lacking_ ->cable_detect method..

It doesn't need one. It still sets the cable type in the pre reset
function as the older drivers that haven't converted to a cable_detect
method do.
