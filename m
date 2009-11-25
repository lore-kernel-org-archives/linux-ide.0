From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 69/86] pata_scc: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:49:23 +0100
Message-ID: <200911251849.23835.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125171039.5446.68680.sendpatchset@localhost> <20091125174844.7e7b3106@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:40243 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759153AbZKYRuJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:50:09 -0500
In-Reply-To: <20091125174844.7e7b3106@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 25 November 2009 06:48:44 pm Alan Cox wrote:
> On Wed, 25 Nov 2009 18:10:39 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] pata_scc: add 32-bit PIO support
> > 
> > There shouldn't be any problems with it as IDE scc_pata host driver
> > has been allowing 32-bit PIO operations for years.
> 
> NAK; Read the code - it uses its own private data_xfer handler anyway

Ah, this one can be indeed dropped.

--
Bartlomiej Zolnierkiewicz
