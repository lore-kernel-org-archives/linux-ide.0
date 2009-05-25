From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: add warning about possible HPA compatibility issue
Date: Tue, 26 May 2009 00:36:17 +0200
Message-ID: <200905260036.17718.bzolnier@gmail.com>
References: <200905252348.08970.bzolnier@gmail.com> <20090525232014.7b6dd7bd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:61570 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbZEYWbV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 May 2009 18:31:21 -0400
In-Reply-To: <20090525232014.7b6dd7bd@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jacob <fun2program8@yahoo.com>, Christopher Hogan <chris.c.hogan@gmail.com>, Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 26 May 2009 00:20:14 Alan Cox wrote:
> > +static inline void ata_hpa_warn(unsigned long long first_sector,
> > +				unsigned long long last_sector)
> > +{
> > +	printk(KERN_WARNING "*** possible compatibility issue:\n"
> > +		"*** sectors %llu-%llu may be inaccessible\n"
> > +		"*** if Host Protected Area is used for filesystem data\n"
> > +		"*** (please refer to \"ignore_hpa\" module parameter)\n",
> > +		first_sector, last_sector);
> > +}
> 
> NAK - this is extremely misleading and will just randomly terrify users,
> who may then set the paramater and corrupt things like BIOS save areas.

Please propose better description.
