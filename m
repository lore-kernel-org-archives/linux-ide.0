From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: add host_set->next for legacy two host_sets case,
 take #3
Date: Wed, 28 Jun 2006 18:53:52 +0800
Message-ID: <44A25FC0.4090002@tw.ibm.com>
References: <20060612051727.GD9166@htj.dyndns.org> <448D0FF9.1080605@pobox.com> <20060612101419.GB5751@htj.dyndns.org> <448D6DBF.9010604@pobox.com> <20060612140538.GA3892@htj.dyndns.org> <44A25979.3020709@tw.ibm.com> <44A25D09.4060705@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:61097 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030374AbWF1Kx6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 06:53:58 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5SArwKq006002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 06:53:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5SAsESW186490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 04:54:14 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5SArufc003686
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 04:53:57 -0600
In-Reply-To: <44A25D09.4060705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian King <brking@us.ibm.com>, Doug Maxey <dwm@bebe.enoyolf.org>, Unicorn Chang <uchang@tw.ibm.com>

Tejun Heo wrote:
> Albert Lee wrote:
> 
>> Hmm, the current patch looks more like a temporary solution. The
>> legacy mode
>> ATA_HOST_SIMPLEX host_set->flags could be assigned to both legacy ports.
>> In the long term, have one host_set for both legacy ports
>> instead of two host_sets for both legacy ports can fix the problem.
>>
>> A patch was submitted by Unicorn, but it looks not good/elegant
>> enough. :(
>> It will be nice if you have plan for furthur legacy two host_sets case
>> fixes...
> 
> 
> Hello, Albert.
> 
> Yeap, this host_set->next thing is a temporary solution and we need to
> handle legacy ports in one host_set.  I've seen Unicorn's patches.  I
> agree that those are in the right direction but we seem to need more
> clean up in driver initialization code.  I'll look into it once the next
> iteration of PMP patches are finished.

Great to hear that. Looking forward to it. :)
--
albert

