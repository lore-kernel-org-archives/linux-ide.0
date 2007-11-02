From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata ATAPI transfer size cleanups
Date: Fri, 02 Nov 2007 01:16:29 -0400
Message-ID: <472AB2AD.3040709@garzik.org>
References: <20071101090733.GA9258@havoc.gtf.org> <64bb37e0711011251w255746c7x6947f85431d4f4fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41175 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbXKBFQb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Nov 2007 01:16:31 -0400
In-Reply-To: <64bb37e0711011251w255746c7x6947f85431d4f4fe@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Torsten Kaiser wrote:
> On 11/1/07, Jeff Garzik <jeff@garzik.org> wrote:
>> +       lo = tf->lbam;
>> +       hi = tf->lbam;
>> +       ibyte = (hi << 8) | lo;
>> +
>> +       lo = result_tf->lbam;
>> +       hi = result_tf->lbam;
> 
> That doesn't look right.
> I suspect this was intended:
> 
> lo = tf->lbam;
> hi = tf->lbah;

Agreed, will correct.

Thanks,

	Jeff



