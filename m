From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Thu, 24 May 2007 16:59:52 +0200
Message-ID: <4655A868.3010707@gmail.com>
References: <4655923E.5000409@effenberger.org> <46559713.9070201@gmail.com>	 <46559C62.2040509@effenberger.org> <46559F5B.4090700@gmail.com>	 <4655A588.40500@effenberger.org> <87f94c370705240755t1040e5c8jaeb1882a2a393ac1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:65333 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbXEXPAG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 11:00:06 -0400
Received: by py-out-1112.google.com with SMTP id a73so902850pye
        for <linux-ide@vger.kernel.org>; Thu, 24 May 2007 08:00:05 -0700 (PDT)
In-Reply-To: <87f94c370705240755t1040e5c8jaeb1882a2a393ac1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Florian Effenberger <florian@effenberger.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Greg Freemyer wrote:
>> I will try to use another test disk. Right now we use different models
>> of Western Digital "RAID edition".
>>
> 
> iiuc, raid editions are designed to fail fast thus allowing an
> alternate drive to provide the data rather than having to wait thru
> multiple internal retries.
> 
> Could this just be a case of the drive functioning as designed?

If that's the case, the drive should be aborting commands with ICRC bit
set reporting unrecoverable media error (AC_ERR_DEV | AC_ERR_MEDIA in
libata terms) but the errors are fatal interface errors and timeouts,
both of which are indicative of transmission problems on ATA link.

-- 
tejun
