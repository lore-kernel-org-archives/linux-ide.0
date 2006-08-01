From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata question
Date: Wed, 02 Aug 2006 04:06:00 +0900
Message-ID: <44CFA618.2090204@gmail.com>
References: <1154445491.18593.111.camel@acme>  <44CF7447.300@gmail.com>	 <1154457583.4665.5.camel@shark.pacific>  <44CFA15C.8080109@gmail.com> <1154458981.4665.9.camel@shark.pacific>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:2089 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751800AbWHATGF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 15:06:05 -0400
Received: by py-out-1112.google.com with SMTP id t32so1303261pyc
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 12:06:05 -0700 (PDT)
In-Reply-To: <1154458981.4665.9.camel@shark.pacific>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: roger@opq.se
Cc: linux-ide@vger.kernel.org

Roger Oberholtzer wrote:
> On Wed, 2006-08-02 at 03:45 +0900, Tejun Heo wrote:
>> Roger Oberholtzer wrote:
>>> On Wed, 2006-08-02 at 00:33 +0900, Tejun Heo wrote:
>>>> Roger Oberholtzer wrote:
>>>>> Should hotplug work with Intel Corporation 82801GB/GR/GH (ICH7
>>>>> Family) chipset? I am trying kernel 2.6.17.7
>> Ah.. I should have spotted this earlier.  2.6.17.7 doesn't contain 
>> updated EH and doesn't support any of new features including 
>> hot/warmplug.  Please try 2.6.18-rc3.
> 
> OK. But I think there are issues with 2.6.18 generally. But I can try it
> to see if this makes this better.

If you're uncomfortable with -rcX, you can try libata-tj-stable patch. 
It contains most of new stuff.

http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060710.tar.bz2

>>> I bet the driver does the right thing. The trick is knowing what that is
>>> supposed to be. And how to use the various commands on files in /sys at
>>> the correct time and in the correct order.
>> Really, it's not that complicated.
> 
> Once you know what it is you need to do.

I tried hard to make things just work.  If you find things unnecessarily 
complicated, please let me know.

Good luck.

-- 
tejun
