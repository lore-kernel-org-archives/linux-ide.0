From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 86/86] libata: add private driver field to struct ata_device
Date: Wed, 25 Nov 2009 19:02:44 +0100
Message-ID: <200911251902.45049.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125171248.5446.22482.sendpatchset@localhost> <20091125175650.64de8a10@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:59566 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbZKYSD0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 13:03:26 -0500
In-Reply-To: <20091125175650.64de8a10@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

On Wednesday 25 November 2009 06:56:50 pm Alan Cox wrote:
> On Wed, 25 Nov 2009 18:12:48 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] libata: add private driver field to struct ata_device
> > 
> > This brings struct ata_device in-line with struct ata_{port,host}.
> 
> Do we need it for anything yet - whoever first needs it can add it,
> otherwise its just waste.

There is a new driver using it (to be posted later) and it makes libata API
more coherent for driver developers..

--
Bartlomiej Zolnierkiewicz
