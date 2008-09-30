From: Tejun Heo <htejun@gmail.com>
Subject: Re: bug report
Date: Tue, 30 Sep 2008 20:47:35 +0900
Message-ID: <48E211D7.8090304@gmail.com>
References: <48DA0B39.5050401@saturnosoft.biz>	 <1222274317.14959.4.camel@odie.local>  <48DA7F1E.5030508@saturnosoft.biz> <1222280712.14959.14.camel@odie.local> <48E0311F.2030907@gmail.com> <48E09223.4000807@saturnosoft.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:2267 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbYI3LtB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Sep 2008 07:49:01 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1154691tic.23
        for <linux-ide@vger.kernel.org>; Tue, 30 Sep 2008 04:48:58 -0700 (PDT)
In-Reply-To: <48E09223.4000807@saturnosoft.biz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Todor Gyumyushev <todor@saturnosoft.biz>
Cc: =?UTF-8?B?U2ltb24gSG9sbSBUaMO4Z2Vyc2Vu?= <odie@cs.aau.dk>, Jens Axboe <jens.axboe@oracle.com>, Albert Lee <albertcc@tw.ibm.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Todor Gyumyushev wrote:
>> Hmm... This shouldn't happen.  Can you please attach full kernel log
>> including the boot messages?
>>
>> Thanks.
>>
>>   
> Hi, here is attached the full kernel log.
> It seems something is happening with ath5k module ?

Does the problem occur w/o ath5k?  I don't really see how ata_piix can
trigger the WARN_ON().

Thanks.

-- 
tejun
