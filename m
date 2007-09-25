From: Olaf Hering <olaf@aepfle.de>
Subject: Re: libata broken on Pegasos PPC platform (was: Re: IDE broken on Pegasos PPC platform)
Date: Tue, 25 Sep 2007 11:22:39 +0200
Message-ID: <20070925092239.GA7127@aepfle.de>
References: <46F80BB1.7050902@redhat.com> <200709242258.28497.bzolnier@gmail.com> <20070924221041.309b08e9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:43040 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbXIYJVf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Sep 2007 05:21:35 -0400
Content-Disposition: inline
In-Reply-To: <20070924221041.309b08e9@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Sep 24, Alan Cox wrote:

> hopefully that means the hack in the old VIA driver can also be killed
> off.

Not that I know. But I did not browse the IDE core long enough to figure
out how to assign both irqs in a generic way.
