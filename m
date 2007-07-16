From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2/7] sata_promise: pdc_freeze() semantic change
Date: Mon, 16 Jul 2007 17:19:34 +0800
Message-ID: <469B3826.7040209@tw.ibm.com>
References: <200707071908.l67J8D5W010862@harpo.it.uu.se> <4693AE87.6070304@gmail.com> <469740D0.4000104@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:57369 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbXGPJTk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:19:40 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6G9Jdci010478
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 05:19:39 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6G9JdnP216638
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 03:19:39 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6G9Jcs2018200
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 03:19:39 -0600
In-Reply-To: <469740D0.4000104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, albertl@mail.com, jeff@garzik.org, alan@lxorguk.ukuu.org.uk, dwm@enoyolf.org, linux-ide@vger.kernel.org, mlord@pobox.com

Tejun Heo wrote:
> Tejun Heo wrote:
> 
>>Mikael Pettersson wrote:
>>
>>>Albert's patch is OK as far as sata_promise is concerned, but
>>>I want to see an update of libata.tmpl and libata-eh.c to
>>>indicate the new, weakened, specification of freeze/thaw before
>>>I ACK this patch.
> 
> 
> Hmmm.... The docbook document is too stale at this point.  It needs
> major rewrite.  Also, I don't really think docbook is a good format for
> this type of documentation.  Can we switch to formatted plain text which
> can be converted to other formats?  Or use some form of inlined comment
> for callback documentation which can be gathered and formatted
> automatically?
> 
> Albert, do you mind updating the comment in libata-eh.c?
> 

No problem. Will fix the comments in the next revision.
--
albert


