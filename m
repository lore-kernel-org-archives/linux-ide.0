From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/5] libata: improve EH internal command timeout handling
Date: Tue, 20 May 2008 13:05:34 +0900
Message-ID: <48324E0E.2000306@gmail.com>
References: <12112174741373-git-send-email-htejun@gmail.com>	<12112174751449-git-send-email-htejun@gmail.com> <20080519193506.6811bdb3@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:32098 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbYETEFl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 May 2008 00:05:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1605751wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 21:05:40 -0700 (PDT)
In-Reply-To: <20080519193506.6811bdb3@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca

Alan Cox wrote:
>> IDENTIFYs use 5s - 10s - 30s timeout and all other commands use 5s -
>> 10s timeouts.
> 
> Cache flushes need more but they now come via the libata-scsi code right ?
> 
>> This patch significantly cuts down the needed time to handle failure
>> cases while still allowing libata to work with nut job devices through
>> retries.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Acked-by: Alan Cox <alan@redhat.com>

Yeah, these are only for EH commands and for currently used commands 5s 
should be more than enough.  If we ever need something which needs 
longer timeout, we can easily add it too.

Thanks.

-- 
tejun
