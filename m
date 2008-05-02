From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI w/ATAPI device problems on Intel Tolapai
Date: Fri, 02 May 2008 09:33:19 +0900
Message-ID: <481A614F.5000900@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE070294E5FA@orsmsx420.amr.corp.intel.com> <480FFAD9.5040606@gmail.com> <39B20DF628532344BC7A2692CB6AEE0702A0D2F6@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:9077 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758229AbYEBAd0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 May 2008 20:33:26 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1338824waf.23
        for <linux-ide@vger.kernel.org>; Thu, 01 May 2008 17:33:25 -0700 (PDT)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0702A0D2F6@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Gaston, Jason D wrote:
>> Hmm.. these look like media presence polling commands from 
>> haldaemon.  I 
>> have no idea why it's failing on ahci tho.  All polling failures I've 
>> seen till now was device dependent, not controller.  You can disable 
>> media presence polling using hal-disable-polling /dev/sr0.  If you 
>> disabling polling, does the device work correctly?  ie. can 
>> you read and 
>> record using it?
>>
>> -- 
>> tejun
>>
> 
> How do I get the hal-disable-polling utility?  I get a command not
> found.

It should be in the hal package.  Which distro are you on?

-- 
tejun
