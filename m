From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Fix simplex adapters with libata
Date: Thu, 08 Mar 2007 10:05:32 -0500
Message-ID: <45F0263C.7030408@rtr.ca>
References: <20070308091211.GA7257@vana.vc.cvut.cz> <20070308130250.5647ce5c@lxorguk.ukuu.org.uk> <45F0227D.5010905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2656 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbXCHPFe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Mar 2007 10:05:34 -0500
In-Reply-To: <45F0227D.5010905@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Petr Vandrovec <petr@vandrovec.name>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Mark Lord wrote:
>..
> A different version of this fix just went upstream for 2.6.21 via Jeff.
> Which of the two is correct?
> 
> I believe the other one looks like this:
> 
>>> -    if ((host->flags & ATA_HOST_SIMPLEX) && host->simplex_claimed != ap) {
>>> -    if ((host->flags & ATA_HOST_SIMPLEX) && host->simplex_claimed == ap) {

Mmm.. or was the upstream patch the other way 'round ?  (lost the posting here)
