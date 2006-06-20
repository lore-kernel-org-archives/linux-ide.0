From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: convert several bmdma-style controllers to new
 EH, take #3
Date: Tue, 20 Jun 2006 05:13:50 -0400
Message-ID: <4497BC4E.1070509@pobox.com>
References: <20060613115131.GA17964@htj.dyndns.org> <20060613214313.GA10142@htj.dyndns.org> <448F5BD2.6060905@pobox.com> <20060616060018.GC10142@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51656 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965086AbWFTJNx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2006 05:13:53 -0400
In-Reply-To: <20060616060018.GC10142@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert sata_sis, svw, uli and vsc drivers to new EH.  All the drivers
> used to specify ATA_FLAG_SATA_RESET to tell libata to use SATA
> hardreset instead of SRST.  This patch makes all the converted drivers
> use the standard bmdma error handler which uses both SRST and SATA
> hardreset.
> 
> All the controllers should be able to perform SRST but still needs
> verification.  If some of the controllers can't do SRST, it will be
> very easy to spot as it will show up during boot probing.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Applied, let's see how testing works out...

I can test sata_svw easily, and sata_vsc with some effort.  I might have 
ULi or SiS motherboards around too, unsure.

	Jeff



