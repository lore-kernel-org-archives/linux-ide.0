From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 48/86] pata_legacy: add pointers to QDI65x0 documentation
Date: Wed, 25 Nov 2009 18:44:59 +0100
Message-ID: <200911251844.59772.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125170802.5446.46013.sendpatchset@localhost> <20091125173852.71fcdf9d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:20577 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933017AbZKYRrE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:47:04 -0500
In-Reply-To: <20091125173852.71fcdf9d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 25 November 2009 06:38:52 pm Alan Cox wrote:
> > + *	QDI65x0 probe code based on drivers/ide/legacy/qd65xx.c
> > + *	Rewritten from the work of Colten Edwards <pje120@cs.usask.ca> by
> > + *	Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> It's not drivers/ide/legacy/qd65xx.c - because you moved it back in the
> old IDE code.

It was the correct path/driver when the aforementioned code was added.

--
Bartlomiej Zolnierkiewicz
