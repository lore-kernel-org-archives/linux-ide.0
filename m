From: Jeff Garzik <jeff@garzik.org>
Subject: Re: cached PCS
Date: Wed, 09 Aug 2006 06:08:58 -0400
Message-ID: <44D9B43A.9010807@garzik.org>
References: <44D97F07.9000301@garzik.org> <44D9AF83.80507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29098 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030582AbWHIKJB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 06:09:01 -0400
In-Reply-To: <44D9AF83.80507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> can you resurrect your cached PCS patch?
>>
>> 2.6.18-rc didn't fix the ghost device and long boot delay problems for 
>> everybody.
> 
> The cached PCS patch was to fix device detection failure on some ICH5s 
> where PCS is cleared while probing the first port.  Remaining ghost 
> device and long boot delay are fixed by honor-PCS patch.  Do you want me 
> to resurrect both?

hrm.  Maybe just honor-PCS?

	Jeff


