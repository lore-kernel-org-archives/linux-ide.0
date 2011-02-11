From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Fri, 11 Feb 2011 13:18:50 -0500
Message-ID: <4D557D8A.6050607@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com>	<20110209085935.GE6558@htj.dyndns.org>	<4D52B0B3.40900@cfl.rr.com>	<20110209153714.558133d7@lxorguk.ukuu.org.uk>	<4D52ECB6.4010408@cfl.rr.com>	<20110209214118.GA7196@atj.dyndns.org>	<4D5332D2.5090701@cfl.rr.com>	<4D534378.3050304@gmail.com>	<20110210091325.GK3770@htj.dyndns.org>	<4D54387F.3030809@cfl.rr.com> <20110210193124.321b7ad6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.123]:41003 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757470Ab1BKSSw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2011 13:18:52 -0500
In-Reply-To: <20110210193124.321b7ad6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/10/2011 2:31 PM, Alan Cox wrote:
> If you start the smart stuff then it also sometimes locks when it
> shouldn't with devastating results for non technical users. I'd say

When?  Is there any specific case you can think of?

>>> Hotplugging and being able to move hard drives between different
>>> machines, and in general behaving consistently across different
>>> hardware configurations have way higher priority than trying to avoid
>>
>> Your auto unlock change seems to address that issue just fine.
> 
> No - because the drive may not even have a partition table on the other
> OS.

Huh?  Either the drive has a partition table or it doesn't.  It does not
matter which machine you plug it into or what another OS is doing.
