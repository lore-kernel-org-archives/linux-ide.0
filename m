From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/14] libata: improve ATAPI draining
Date: Thu, 29 Nov 2007 17:40:27 +0000
Message-ID: <20071129174027.7597bd4a@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468192463-git-send-email-htejun@gmail.com>
	<20071129155956.4004ca89@the-village.bc.nu>
	<474EEC06.70304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41719 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932630AbXK2Ru0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 12:50:26 -0500
In-Reply-To: <474EEC06.70304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Albert Lee <albertcc@tw.ibm.com>

On Fri, 30 Nov 2007 01:42:46 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Alan Cox wrote:
> >> * Limit the amount of draining to ATAPI_MAX_DRAIN (16k currently).
> > 
> > Why 16 not 64K ?
> 
> Oops, forgot to answer here.  That would result in 16 sg entries for
> draining which felt a bit too much. 

16 sg entries but only one page of memory so its not a bit bump ?
