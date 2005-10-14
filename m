From: Mark Lord <liml@rtr.ca>
Subject: Re: SATA150TX4 atat1:command timeout
Date: Fri, 14 Oct 2005 09:07:05 -0400
Message-ID: <434FAD79.2030800@rtr.ca>
References: <VA.00001a58.00a9337c@foxhill.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:58808 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1750736AbVJNNHF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Oct 2005 09:07:05 -0400
Received: from [10.0.0.14] (silvy.localnet [10.0.0.14])
	by mail.rtr.ca (Postfix) with ESMTP id D4191830245
	for <linux-ide@vger.kernel.org>; Fri, 14 Oct 2005 09:07:04 -0400 (EDT)
In-Reply-To: <VA.00001a58.00a9337c@foxhill.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Ian Oliver wrote:
> In article <434ECBC3.3020802@rtr.ca>, Mark Lord wrote:
> 
>>The Ubuntu-5.04 kernels have the libata EH bug, whereby the entire
>>machine locks up at random once in a blue-moon when EH is running.
>
> What about 5.10?

Breezy (5.10) should be fine.
