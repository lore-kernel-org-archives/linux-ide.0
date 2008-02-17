From: Mark Lord <liml@rtr.ca>
Subject: Re: ST31000340NS (1000G) Capacity equal 33MB issue.
Date: Sun, 17 Feb 2008 14:26:46 -0500
Message-ID: <47B88A76.7070601@rtr.ca>
References: <d0d565260802141013q61cb5e7fh7dcf04d7729213f7@mail.gmail.com>	 <d0d565260802141018y63a988bbpc6aecf771baacb84@mail.gmail.com>	 <47B499F2.1010306@rtr.ca> <47B5CC39.7020302@rtr.ca>	 <47B70571.4060303@rtr.ca> <d0d565260802170721r34ad933blabb3745691a6a3e9@mail.gmail.com> <47B88881.40003@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2564 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbYBQT0r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 17 Feb 2008 14:26:47 -0500
In-Reply-To: <47B88881.40003@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Liu <richliu.tw@gmail.com>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> Richard Liu wrote:
..
>>   I downloaded hdparm-8.1
>> and here is output information.
>>
>> # ./hdparm -N /dev/sdc
>>
>> /dev/sdc:
>>  max sectors   = 65134/1953525168, HPA is enabled
> ..
> 
> Yes, pretty much as expected there.
> 
> You can safely now try this:
> 
>    ./hdparm -N1953525168 /dev/sdc
> 
> If that works, it will have temporarily restored access to the entire 
> drive.
> Then you can try to make it permanent by doing this:
> 
>   ./hdparm -Np1953525168 /dev/sdc
> 
> If *that* also works, then reboot and things should be fine,
> unless your machine BIOS changes it back again on boot.. :/
> 
> If either of those *fails*, then it is because your BIOS (or possibly 
> the system startup scripts) have "frozen" the configuration
> to prevent changes.  Dunno why they would do that, but it's possible.
> 
> In which case, you could move the drive to another machine temporarily,
> and then issue that same command there.
..

Or just hot unplug/replug the drive and try it again.
That should also work, assuming the driver for your controller supports hotplug.

Cheers
