From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH9 2 port SATA controller port map?
Date: Fri, 28 Sep 2007 22:16:21 -0700
Message-ID: <46FDDFA5.8040209@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE0701CC0C09@orsmsx420.amr.corp.intel.com> <46FB0273.60302@gmail.com> <39B20DF628532344BC7A2692CB6AEE0701CF2D29@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:4149 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbXI2FSG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Sep 2007 01:18:06 -0400
Received: by nz-out-0506.google.com with SMTP id s18so2172259nze
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 22:18:04 -0700 (PDT)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0701CF2D29@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org

Gaston, Jason D wrote:
>> -----Original Message-----
>> From: Tejun Heo [mailto:htejun@gmail.com]
>> Sent: Wednesday, September 26, 2007 6:08 PM
>> To: Gaston, Jason D
>> Cc: linux-ide@vger.kernel.org
>> Subject: Re: ICH9 2 port SATA controller port map?
>>
>> Gaston, Jason D wrote:
>>> Hello,
>>>
>>> ICH9 has DeviceID's for 2 port, IDE mode, SATA controllers.  The
> current
>>> port map in ata_piix is setup for the 4 port controllers.  This seems
> to
>>> work ok, but I wonder if a new port map should be defined for the 2
> port
>>> controllers, where the two ports are PM, SM?  You can refer to the
> ICH9
>>> Datasheet on intel.com for detail.
>> Yes, please go ahead and define new entry for the controllers.  Thanks.
>>
>> --
>> Tejun
> 
> What is the difference between NA and RV?  If the controller only has
> access to 2 ports, does it matter which I set the nonexistent port
> values to in the map?

NA is used for unimplemented ports of a valid configuration while RV is
used to mark invalid MAP value.  So, NA should be mixed with P[0-3]
while RV can't be mixed with any other values.

-- 
tejun
