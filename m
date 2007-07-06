From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 0/10] libata: irq_on/off restructuring
Date: Fri, 06 Jul 2007 17:23:25 +0800
Message-ID: <468E0A0D.3030303@tw.ibm.com>
References: <468B5C97.1000803@tw.ibm.com> <468CCC82.6050008@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:60047 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763347AbXGFJXg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jul 2007 05:23:36 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l669Na2l006125
	for <linux-ide@vger.kernel.org>; Fri, 6 Jul 2007 05:23:36 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l669Nat4205234
	for <linux-ide@vger.kernel.org>; Fri, 6 Jul 2007 03:23:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l669NZDF025523
	for <linux-ide@vger.kernel.org>; Fri, 6 Jul 2007 03:23:36 -0600
In-Reply-To: <468CCC82.6050008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>

Tejun Heo wrote:
 > 
> I like the whole series.  Just a few nits.
> 
> * 9 and 10 need to be oen patch.  As it currently stands, compile will
> fail after 9.
> 
> * Please don't include "Patch n/10" in message body.
> 
> * Add freeze/thaw to all, merge, kill freeze/thaw from all sequence is a
> bit odd.  It would be better if we can do things more directly but I
> haven't thought about how that can be done too hard, so if it's too
> difficult, it's probably not worth it.
> 
> Alan, Jeff, I think we'll need to do what IDE has been doing for IRQ
> masking to get acceptable PIO behavior after all and that will also make
> us more resistant against deadly IRQ storms on controllers which don't
> have pending IRQ bits (most SFF ones), and this change will ease our way
> toward that direction.  What do you guys think?
> 

Thanks for the review/advice. Revised patches to follow.
--
albert

