From: Tejun Heo <tj@kernel.org>
Subject: Re: Problems with SIL3132 and PMP / Is this driver/kernel related?
Date: Sun, 12 Sep 2010 13:17:42 +0200
Message-ID: <4C8CB6D6.1020000@kernel.org>
References: <4C8A0850.2060203@scaleup.it> <4C8A1F7B.6020302@kernel.org> <4C8A5E5A.4010307@scaleup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53623 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab0ILLRv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Sep 2010 07:17:51 -0400
In-Reply-To: <4C8A5E5A.4010307@scaleup.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "christoph@scaleup.it" <christoph@scaleup.it>
Cc: linux-ide@vger.kernel.org

Hello,

On 09/10/2010 06:35 PM, christoph@scaleup.it wrote:
>> Hmmm... interesting setup.
>>   
> It's according to the backblaze setup. See here:
> http://blog.backblaze.com/2009/09/01/petabytes-on-a-budget-how-to-build-cheap-cloud-storage/

Ooh, that's a nice setup.

> We have changed the design a bit by using a different Mainboard
> (Supermicro with Intel 3420 chipset) and an Intel Xeon CPU. Also we
> are using five PCI-Express SATA controllers instead of three and one
> PCI-X in the original design from backblaze. This was due to not
> finding a motherboard suiting our needs.

I see.  I don't think different motherboards would be a contributing
factor here.

>> Timeout on FLUSH_CACHE_EXT is often indicative of power issues.  How
>> are the drives powered?
>>   
>
> I have two 626W PSUs from Enermax, which should give the whole box
> enough power. We are also utilizing the Low Power 2 TB Seagate
> drives.

High wattage doesn't necessarily mean that there is no power problem.
Powera problem often happens if you're running a lot of drives in the
same array.  When the filesystem decides cache flushing is necessary,
_ALL_ drives in an array will get FLUSH_CACHE at the exact same time.
Drives often shows power consumption spike on FLUSH_CACHE and many
power supplies fail to maintain the voltage during such sudden
consumption spikes.  Please note that low power drives may actually
show higher fluctuation due to aggressive power save meaures (drives
even lower the platter RPM to reduce power consumption then spin it
back up on commands like FLUSH_CACHE).

I would recommend testing the setup with, say, 1/4 number of drives
and then start increasing the number of drives and see whether there's
any pattern.  Another way to try it is to power up extra PSUs and
distribute power load to different power supplies and see whether
anything changes.  Powering up ATX PSU w/o motherboard isn't too
difficult.

  http://www.techpowerup.com/articles/other/22

>> This one is timeout on the port multiplier side.  Can be caused by
>> power issues or cables which are too long.  How are the PMPs connected
>> to the constrollers?
>>   
> I have 90cm (standard) SATA cables. One per PMP going to a
> controller card. There is five PCI Express controller cards with
> SIL3132 chipset. One controller only has one PMP attached to it, the
> four othes have two PMPs attached to it.

Yeah, if it's internal standard SATA cable, cable probably is not the
culprit.  Problems usually happen with long eSATA cables.

Thanks.

-- 
tejun
