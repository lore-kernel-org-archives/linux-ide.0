From: Carolin Latze <carolin.latze@gmail.com>
Subject: Re: kernel crash with lite-on sata controller Dell XPS 13 9343
Date: Thu, 25 Feb 2016 22:53:18 +0100
Message-ID: <56CF77CE.2040204@gmail.com>
References: <56CF75E6.5070803@gmail.com>
 <20160225215130.GK6092@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38383 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbcBYVxU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Feb 2016 16:53:20 -0500
Received: by mail-wm0-f53.google.com with SMTP id a4so46402378wme.1
        for <linux-ide@vger.kernel.org>; Thu, 25 Feb 2016 13:53:20 -0800 (PST)
In-Reply-To: <20160225215130.GK6092@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: hdegoede@redhat.com, linux-ide@vger.kernel.org

Hi Tejun

I actually boot with "libata.force=noncq,1.5G". Sorry, forgot to mention 
that. Same behavior.

best regards
Carolin

On 25.02.2016 22:51, Tejun Heo wrote:
> Hello, Carolin.
>
> On Thu, Feb 25, 2016 at 10:45:10PM +0100, Carolin Latze wrote:
> ...
>> Since the beginning (started with 3.19.x kernels on this notebook) I had
>> problems with this sata controller:
>>
>> 03:00.0 SATA controller: Lite-On Technology Corporation Device 0224 (rev 10)
>>
>> Very often during boot, the boot just failed with error messages like
>>
>> ata1.00: exception... (I was only able to capture them by taking a picture:
>> https://launchpadlibrarian.net/227876135/IMG_20151128_230313.jpg)
>>
>> Then I keep trying, sometimes I boot into Windows inbetween, and eventually,
>> the kernel comes up.
>>
>> Then, when running and putting a lot of load on the disk (e.g. running dump
>> or a simple update via apt-get upgrade), the system looses its disk and I
>> have to hard reset.
>>
>> The machine runs perfectly fine under Windows, so I don't believe it is a
>> hardware issue.
>>
>> I hope there is a solution to this issue.
> Can you please boot with libata.force=noncq and if that fails post the
> kernel messages of the failure?
>
> Thanks.
>

