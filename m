From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_nv failure on 2.4.18 (Fedora Core 6)
Date: Wed, 25 Oct 2006 14:51:13 +0900
Message-ID: <453EFB51.5080709@gmail.com>
References: <Pine.LNX.4.64.0610242257410.21847@gate.crashing.org>	 <20061025042811.GJ13677@htj.dyndns.org> <1161753976.22582.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:62893 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423031AbWJYFvW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Oct 2006 01:51:22 -0400
Received: by nf-out-0910.google.com with SMTP id c2so477835nfe
        for <linux-ide@vger.kernel.org>; Tue, 24 Oct 2006 22:51:21 -0700 (PDT)
In-Reply-To: <1161753976.22582.46.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mark Hatle <fray@gate.crashing.org>, linux-ide@vger.kernel.org, hancockr@shaw.ca

Benjamin Herrenschmidt wrote:
>> Does the problem occur on 2.6.18 but not on earlier version?  If it
>> doesn't happen on 2.6.17, we can rule out h/w problem.
> 
> Difficult to say... this is a fresh install of FC6 and it's a production
> box (heh, it handles my email !) so we can't easily test plenty
> different kernels on it unfortunately... If 2.6.17 can be booted and
> works fine on FC6, might be worth giving it a go but I wouldnt' expect
> too many tests of that sort.
> 
>> * If 2.6.17 shows the same problem : could be a faulty drive or
>>   problem in the controller.  NV SATA controllers supply two
>>   interfaces - legacy TF/BMDMA and ADMA.  The former tends to react
>>   badly when error condition occurs.  Driver for ADMA interface is
>>   under development.  It could be that the controller cannot cope with
>>   transient transmission errors.  If this is the case, ADMA driver
>>   should be able to fix it.
> 
> Do we have any contact at nVidia that could rule on that issue ? The
> drives both appear to work fine on the SIL controller... 

Robert Hancock is working on nv adma suppport.

   http://article.gmane.org/gmane.linux.ide/13608

W/ the above patch, sata_nv should be able to recover much better from 
error conditions, but we still have to find out why such errors are 
occurring in the first place.

Thanks.

-- 
tejun
