From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] irq-pio: use PageHighMem() to optimize the kmap_atomic()
 usage
Date: Sun, 09 Oct 2005 09:49:07 -0400
Message-ID: <43491FD3.1000502@pobox.com>
References: <43438258.9080706@pobox.com> <4344FDED.1080402@tw.ibm.com> <4345089A.9020006@pobox.com> <434613CB.6010600@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:21148 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750705AbVJINtN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Oct 2005 09:49:13 -0400
In-Reply-To: <434613CB.6010600@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

applied patches 1-3, after updating the irq-pio branch to the latest 
upstream branch.

