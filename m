From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PATA drivers queued for 2.6.19
Date: Mon, 04 Sep 2006 22:25:26 -0400
Message-ID: <44FCE016.6080600@garzik.org>
References: <44FC0779.9030405@garzik.org> <edi5uq$o4i$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29078 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965091AbWIECZa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Sep 2006 22:25:30 -0400
In-Reply-To: <edi5uq$o4i$1@sea.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andras Mantia <amantia@kde.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Andras Mantia wrote:
> Jeff Garzik wrote:
> 
>> I just pulled the "pata-drivers" branch of libata-dev.git into the
>> "upstream" branch, which means that Alan's libata PATA driver collection
>> is now queued for 2.6.19.
>>
>> Testing-wise, these PATA drivers have been Andrew Morton's -mm tree for
>> many months.  Community-wise, no one posted objections to the PATA
>> driver merge plan, when Alan posted it on LKML and linux-ide.
> 
> Does this include the patch to support the PATA port on the promise
> controllers (described here
> https://bugzilla.novell.com/show_bug.cgi?id=176249 ) ?

Unfortunately not.  This patch still lives in -mm (and branch 
promise-sata-pata).

Hopefully this can be merged once the init code is cleaned up some more.

	Jeff



