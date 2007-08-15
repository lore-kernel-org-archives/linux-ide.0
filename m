From: Tejun Heo <htejun@gmail.com>
Subject: Re: regression problem with Maxtor disk
Date: Wed, 15 Aug 2007 16:53:33 +0900
Message-ID: <46C2B0FD.5030101@gmail.com>
References: <87tzr4zvpt.fsf@wyrd.be> <46C17AE0.5090601@gmail.com>	<46C23746.6030203@shaw.ca> <878x8dl07z.fsf@wyrd.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:24833 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbXHOHxv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 03:53:51 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1661756rvb
        for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 00:53:51 -0700 (PDT)
In-Reply-To: <878x8dl07z.fsf@wyrd.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lieven Marchand <mal@wyrd.be>
Cc: Robert Hancock <hancockr@shaw.ca>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Lieven Marchand wrote:
> Robert Hancock <hancockr@shaw.ca> writes:
> 
>> It looks like there are some lines missing from this log, there should
>> be a line before the "res" lines indicating what the failed command
>> was..
> 
> There isn't. I snipped some irrelevant stuff but nothing about a
> command. The full log is appended.

It seems klogd clipped some messages.  Can you please turn on printk
timestamp, enlarge printk log buffersize and post the result of 'dmesg'
after errors?

-- 
tejun
