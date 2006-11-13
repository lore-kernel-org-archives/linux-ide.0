From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [RFT PATCH] libata: implement ATA_FLAG_SETXFER_POLLING and use
 it in pata_via
Date: Mon, 13 Nov 2006 21:29:16 +0100
Message-ID: <4558D59C.6030307@free.fr>
References: <20060928111151.GN25800@htj.dyndns.org> <452BEA3D.4020204@free.fr> <452BEAB7.9010901@free.fr> <452C1A19.6010607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:30186 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1755274AbWKMU3c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Nov 2006 15:29:32 -0500
In-Reply-To: <452C1A19.6010607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, jeff@garzik.org, linux-ide@vger.kernel.org, akpm@osdl.org

Hi,

Tejun Heo wrote:
> matthieu castet wrote:
> 
> 
> Yes, you probably need to.  Both features must have kicked in.
> 
I am a bit late. Yes it worked.

Will this be included in 2.6.19 or I should wait 2.6.20 to have a 
working via pata ?


Matthieu
