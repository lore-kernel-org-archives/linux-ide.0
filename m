From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_nv frees DMA memory with different size (possibly a generic
  libata bug)
Date: Sat, 21 Feb 2009 13:02:53 -0600
Message-ID: <49A04FDD.4070101@gmail.com>
References: <20090219220901R.fujita.tomonori@lab.ntt.co.jp>	 <499E1C5B.1050207@gmail.com>	 <d676b7a80902200320n791d627bt7d9797265629920f@mail.gmail.com>	 <20090221155724W.fujita.tomonori@lab.ntt.co.jp> <d676b7a80902210157l47344e77yb5b36c67e3750ad7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:57013 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbZBUTC7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Feb 2009 14:02:59 -0500
Received: by an-out-0708.google.com with SMTP id c2so567708anc.1
        for <linux-ide@vger.kernel.org>; Sat, 21 Feb 2009 11:02:56 -0800 (PST)
In-Reply-To: <d676b7a80902210157l47344e77yb5b36c67e3750ad7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wes Shull <wes.shull@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, cebbert@redhat.com, linux-ide@vger.kernel.org

Wes Shull wrote:
>>>>> I think that the following patch could fix this:
>>>>>
>>>>> http://marc.info/?l=linux-ide&m=123484533504307&w=2
>>>> The patch looks reasonable to me. I'm CCing the reporter of the bug. Wes,
>>>> would you be able to test out Fujita's patch linked above?
>>> I grabbed the srpm for the fedoraized 2.6.29-0.137.rc5.git4 from koji,
>>> applied the patch, and tested--no joy, I'm still getting the warning.
>>> Would there be any value to me trying this with a vanilla+dma-debug
>>> kernel build?
>>>
>>> Tomorrow I'm going to bump up the show_num_errors (currently at 1) in
>>> the dma debug patch to see if maybe that produces anything else
>>> interesting;
>> I think that probably it's not interesting much. Once you get a
>> dma-debug error, the later errors are not reliable.
>>
>> For example, dma-debug finds a dma-debug error about a NIC, you could
>> get false dma-debug errors about even good device drivers.
>>
>>
>>> I've already got another bug that races with nv_sata to
>>> get that first warning (in forcedeth, so you probably don't care, but
>>> if so see https://bugzilla.redhat.com/show_bug.cgi?id=484494 ).
>> As I explained above, you can't have other dma-debug error source. Can
>> you test only nv_sata with my patch again?
> 
> Ok, I blocked forcedeth from loading, rebooted (still running the
> kernel I built with your patch--despite these warning messages, it's
> 100% stable in all my testing), verified that forcedeth hadn't
> loaded...  but I still got the nv_sata warning.  So that's not it
> either :(

I suppose it makes sense it wouldn't fix this particular problem, though 
I think the patch is still correct (and Fujita should likely push it for 
-next). In this case it's complaining about a mismatch of one of the 
element sizes, not the number of elements which is what it was fixing

Fujita, do you know if there is some other kind of merging that the GART 
IOMMU code could be doing that would be tripping up this debug code?
