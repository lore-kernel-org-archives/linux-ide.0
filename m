From: Tejun Heo <htejun@gmail.com>
Subject: Re: cached PCS
Date: Wed, 09 Aug 2006 19:11:08 +0900
Message-ID: <44D9B4BC.5050707@gmail.com>
References: <44D97F07.9000301@garzik.org> <44D9AF83.80507@gmail.com> <44D9B43A.9010807@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:36624 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030633AbWHIKLM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 06:11:12 -0400
Received: by py-out-1112.google.com with SMTP id z74so301530pyg
        for <linux-ide@vger.kernel.org>; Wed, 09 Aug 2006 03:11:12 -0700 (PDT)
In-Reply-To: <44D9B43A.9010807@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> can you resurrect your cached PCS patch?
>>>
>>> 2.6.18-rc didn't fix the ghost device and long boot delay problems 
>>> for everybody.
>>
>> The cached PCS patch was to fix device detection failure on some ICH5s 
>> where PCS is cleared while probing the first port.  Remaining ghost 
>> device and long boot delay are fixed by honor-PCS patch.  Do you want 
>> me to resurrect both?
> 
> hrm.  Maybe just honor-PCS?

Yeap, we need to verify whether the less-jealous-PCS-update patch cured 
the ICH5 problem.

-- 
tejun
