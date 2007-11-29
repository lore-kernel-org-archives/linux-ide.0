From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/14] libata: improve ATAPI draining
Date: Thu, 29 Nov 2007 18:19:18 +0000
Message-ID: <20071129181918.050ae34a@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468192463-git-send-email-htejun@gmail.com>
	<20071129155956.4004ca89@the-village.bc.nu>
	<474EEC06.70304@gmail.com>
	<20071129174027.7597bd4a@the-village.bc.nu>
	<474F00C4.3010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39359 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932865AbXK2SX7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 13:23:59 -0500
In-Reply-To: <474F00C4.3010406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Albert Lee <albertcc@tw.ibm.com>

> So, I thought 16k was a good trade off.  Not as comfortable as 64k tho,
> I agree.  Would it be worth to add more complexity for this?

Fair point .. I don't know. Perhaps we should wait and see.
