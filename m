From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 05/14] libata: make ->data_xfer return the number of consumed
 bytes
Date: Tue, 04 Dec 2007 20:05:00 -0500
Message-ID: <4755F93C.1050101@garzik.org>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468181417-git-send-email-htejun@gmail.com> <4755AAE1.5060000@garzik.org> <4755F58E.3020703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55089 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbXLEBFI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 20:05:08 -0500
In-Reply-To: <4755F58E.3020703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> Jeff Garzik wrote:
>> IMO s/buflen/len/ causes needless patch noise, and makes this harder review
> 
> Separating out s/buflen/len/ to a separate patch seemed silly yet I
> wanted to renamed it.  :-P
> 
> If you want to kill it, I'll kill the renaming.  If you want it in a
> separate patch, I'll separate it out.

IMO just kill the renaming.

But if you really really really want to rename, put it in a separate 
patch.  :)


