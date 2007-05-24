From: Florian Effenberger <florian@effenberger.org>
Subject: Re: libata interface fatal error
Date: Thu, 24 May 2007 16:47:36 +0200
Message-ID: <4655A588.40500@effenberger.org>
References: <4655923E.5000409@effenberger.org> <46559713.9070201@gmail.com> <46559C62.2040509@effenberger.org> <46559F5B.4090700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:50504 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbXEXOrj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 10:47:39 -0400
In-Reply-To: <46559F5B.4090700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,

> Data integrity wise there should be no problem but your error rate is
> pretty high and eventually will make libata turn off NCQ and/or speed
> down PHY speed.

switching ports is not easy. Both on-board SATA controllers are being 
used, and the error seems to occur on all ports.

> Yeap, your data is safe.  With timeouts, data transfer speed can be much
> lower tho.  It definitely seems something is wrong with your hardware setup.

I will try to use another test disk. Right now we use different models 
of Western Digital "RAID edition".

Any other debug information I could gather?

Florian
