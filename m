From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6 1/2] ata_dev_identify() check status fix
Date: Sun, 15 May 2005 19:13:03 -0400
Message-ID: <4287D77F.4030306@pobox.com>
References: <424CE03C.7020903@tw.ibm.com> <424EC07A.10505@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:7577 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261157AbVEOXNN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2005 19:13:13 -0400
In-Reply-To: <424EC07A.10505@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>, bruss@alum.wpi.edu

Could we not pass the Status value via struct ata_taskfile ?

	Jeff



