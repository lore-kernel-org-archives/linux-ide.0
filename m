From: Tejun Heo <htejun@gmail.com>
Subject: Re: Still having problems with sata_promise on all late kernels -
 shutdown too - BISECTED
Date: Thu, 16 Aug 2007 20:10:26 +0900
Message-ID: <46C430A2.7040001@gmail.com>
References: <46C11BBE.6010802@wasp.net.au> <46C1316F.4010906@wasp.net.au> <46C1DB92.7080806@wasp.net.au> <46C2B046.7060708@gmail.com> <46C3273F.1070306@wasp.net.au> <46C3E3F7.2010803@gmail.com> <46C402AE.6010605@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:36561 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbXHPLKn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 07:10:43 -0400
Received: by rv-out-0910.google.com with SMTP id k20so179529rvb
        for <linux-ide@vger.kernel.org>; Thu, 16 Aug 2007 04:10:43 -0700 (PDT)
In-Reply-To: <46C402AE.6010605@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org

Brad Campbell wrote:
> Tejun Heo wrote:
>> Brad Campbell wrote:
>>> Tejun Heo wrote:
>>>> Brad Campbell wrote:
>>>>> Brad Campbell wrote:
>>>>>
>>>>>> http://www.fnarfbargle.com/CIMG1029.JPG (I have posted this screen
>>>>>> shot previously. It's still doing exactly the same thing on both
>>>>>> boxes).
>>>>>>
>>>>> git-bisect shows up this commit as the guilty party. I can't just
>>>>> revert
>>>>> it on a recent tree though.
>>>>> Will investigate further.
>>>> Weird.  Does 'hdparm -y /dev/sdX' work?
>>> Very interesting indeed..
>>>
>>> for i in /dev/sd* ; do echo $i ; hdparm -y $i ; done
>>>
>>> sda-sdh worked fine.. sdi locked the box.
>>>
>>> So it's dying on the 3rd or 4th controller.
>>
>> That's weird.  You seem to have the same controllers and drives.  What
>> happens if you spin down from hdi upwards?
>>
> 
> Any attempt to spin down sdi-sdo in any order locks hard. Any attempt to
> spin down sda-sdh works in any combination/permutation.

Hmmm... I'm out of ideas.  It definitely sounds like some sort of
hardware problem to me.  I think the best way to diagnose the problem is
playing the tedious but often rewarding add-remove-swap game with the
hardware and see to which piece or combination of pieces the problem is
attached.

Thanks.

-- 
tejun
