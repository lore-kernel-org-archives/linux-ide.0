From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Is the SIL 3112 capable of PMP support?
Date: Mon, 13 Nov 2006 08:38:16 -0500
Message-ID: <45587548.7020808@garzik.org>
References: <455810BC.6090304@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:901 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754624AbWKMNiT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Nov 2006 08:38:19 -0500
In-Reply-To: <455810BC.6090304@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org

Brad Campbell wrote:
> I've been planning on doing some testing with PMP's and noticed that 
> sata_sil does not support PMP. Is that a hardware limitation or just 
> that nobody has implemented it in the driver yet ?

Well, it doesn't support hardware context switching.  It probably 
supports PMP "the slow way" (one PMP-attached device at a time)

	Jeff



