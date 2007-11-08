From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 13/15] ide: remove hwif->intrproc
Date: Wed, 07 Nov 2007 19:51:44 -0500
Message-ID: <47325DA0.4070905@rtr.ca>
References: <200710310055.13329.bzolnier@gmail.com> <4728F05A.5000502@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4696 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbXKHAvq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Nov 2007 19:51:46 -0500
In-Reply-To: <4728F05A.5000502@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Albert Lee <albertcc@tw.ibm.com>

> Bartlomiej Zolnierkiewicz wrote:
> 
>> * hpt366.c::hpt3xx_intrproc() is the only user of hwif->intrproc
..

Speaking of which..

I believe I have a small PCI card here with an HPT366 chip on it.
Does anyone there want it before I throw it away?

-ml
