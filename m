From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY
Date: Mon, 07 May 2007 13:32:19 +0200
Message-ID: <463F0E43.5090608@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com> <20070507121845.5d7cd1f8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:33056 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933223AbXEGLcb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 07:32:31 -0400
Received: by py-out-1112.google.com with SMTP id a29so1154410pyi
        for <linux-ide@vger.kernel.org>; Mon, 07 May 2007 04:32:31 -0700 (PDT)
In-Reply-To: <20070507121845.5d7cd1f8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
>> Yeap, this is how IDE deals with polling commands but I'm not sure how
>> it's supposed to work with PCI IRQ sharing.  Bartlomiej, can you
>> enlighten me here?
> 
> Simple answer: Badly. If you've got the IRQ shared it mucks up the
> behaviour of the other device especially when its doing PIO.

OIC, I've been thinking I must be missing something but it's just
supposed to work that way.  Doesn't sound too attractive.  :-(

Thanks.

-- 
tejun
