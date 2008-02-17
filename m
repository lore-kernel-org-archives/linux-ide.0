From: Mark Lord <liml@rtr.ca>
Subject: Re: ST31000340NS (1000G) Capacity equal 33MB issue.
Date: Sun, 17 Feb 2008 14:18:25 -0500
Message-ID: <47B88881.40003@rtr.ca>
References: <d0d565260802141013q61cb5e7fh7dcf04d7729213f7@mail.gmail.com>	 <d0d565260802141018y63a988bbpc6aecf771baacb84@mail.gmail.com>	 <47B499F2.1010306@rtr.ca> <47B5CC39.7020302@rtr.ca>	 <47B70571.4060303@rtr.ca> <d0d565260802170721r34ad933blabb3745691a6a3e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2144 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbYBQTS1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 17 Feb 2008 14:18:27 -0500
In-Reply-To: <d0d565260802170721r34ad933blabb3745691a6a3e9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Liu <richliu.tw@gmail.com>
Cc: linux-ide@vger.kernel.org

Richard Liu wrote:
> Dear Mark:
> 
> 2008/2/16, Mark Lord <liml@rtr.ca>:
>> Mark Lord wrote:
>>> Richard Liu wrote:
>>>
>>> Thanks.  By running the above data through hdparm --Istdin,
>>> I see that the drive is indeed identifying itself as a 33MB drive.
>>>
>>> Probably because it has been told to do so by either the factory defaults,
>>> or the BIOS, having enabled these features (which can cause it to report
>>> fake values for various things):
>>>
>>>           *    Host Protected Area feature set
>>>           *    Device Configuration Overlay feature set
>>>
>>> So that's why the 1TB drive appears as a 33MB drive.
>>>
>>> In the near future, I will be enhancing hdparm to query more
>>> detailed data from underneath those artificial features.
>>>
>>> But you'll have to enable the entire 1TB capacity if you want Linux to
>>> use it.
>>> It is currently disabled in the drive, and Linux respects that.
>> ..
>>
>> Okay, hdparm-8.1 is now available from sourceforge.net.
>> Download it, build it ("make"), and see what you get from "hdparm -N /dev/sdc"
>>
>> Thanks
>>
>   I downloaded hdparm-8.1
> and here is output information.
> 
> # ./hdparm -N /dev/sdc
> 
> /dev/sdc:
>  max sectors   = 65134/1953525168, HPA is enabled
..

Yes, pretty much as expected there.

You can safely now try this:

    ./hdparm -N1953525168 /dev/sdc

If that works, it will have temporarily restored access to the entire drive.
Then you can try to make it permanent by doing this:

   ./hdparm -Np1953525168 /dev/sdc

If *that* also works, then reboot and things should be fine,
unless your machine BIOS changes it back again on boot.. :/

If either of those *fails*, then it is because your BIOS 
(or possibly the system startup scripts) have "frozen" the configuration
to prevent changes.  Dunno why they would do that, but it's possible.

In which case, you could move the drive to another machine temporarily,
and then issue that same command there.

Cheers
