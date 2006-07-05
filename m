From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA updates (rebased)
Date: Wed, 05 Jul 2006 17:15:32 +0100
Message-ID: <1152116132.3602.2.camel@localhost.localdomain>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk>
	 <20060705124429.GD16682@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33956 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964804AbWGEP7c
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Jul 2006 11:59:32 -0400
In-Reply-To: <20060705124429.GD16682@harddisk-recovery.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: jgarzik@pobox.com, akpm@osdl.org, linux-ide@vger.kernel.org

Ar Mer, 2006-07-05 am 14:44 +0200, ysgrifennodd Erik Mouw:
> On Tue, Jul 04, 2006 at 06:15:43PM +0000, alan@lxorguk.ukuu.org.uk wrote:
> > PATA updates rebased onto latest tree
> 
> Against which latest tree exactly?

libata-dev:#pata-drivers

I did look at shifting it to 2.6.17 but the pata driver changes suck in
the new eh which sucks in post 2.6.17 scsi bits

