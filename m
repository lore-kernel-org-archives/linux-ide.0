From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil Mod15Write quirk workaround patch for vanilla kernel
 avaialble.
Date: Fri, 01 Apr 2005 07:51:28 +0900
Message-ID: <424C7EF0.5000206@gmail.com>
References: <424C10C3.9080102@gmail.com> <20050331111044.4a3672cd@homer.sarvega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.193]:13443 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262043AbVCaWvg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Mar 2005 17:51:36 -0500
Received: by rproxy.gmail.com with SMTP id j1so506076rnf
        for <linux-ide@vger.kernel.org>; Thu, 31 Mar 2005 14:51:34 -0800 (PST)
In-Reply-To: <20050331111044.4a3672cd@homer.sarvega.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Lash <jkl@sarvega.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, mage@adamant.ua

  Hello, John.

John Lash wrote:
> On Fri, 01 Apr 2005 00:01:23 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
> 
>> Hello, guys.
>>
>> I  generated m16w workaround patch for 2.6.11.6 (by just removing two
>>lines :-) and set up a page regarding m15w quirk and the workaournd.
>>I'm planning on updating m15w patch against the vanilla tree until it
>>gets into the mainline so that impatient users can try out and it gets
>>more testing.
>>
>> http://home-tj.org/m15w
>>
>> Thanks.
>>
>>-- 
>>tejun
>>
> 
> 
> Tejun,
> 
> I applied the patch to a clean 2.6.11.6 kernel and got an unresolved
> symbol error for "ATA_TFLAG_LBA". I tried changing that to "ATA_TFLAG_LBA48" and
> it compiles and runs.
> 
> So far, no problems. Thanks a lot for the patch.
> 
> --john

  I'm sorry.  I uploaded the original patch against libata-dev-2.6 tree. 
  The two BUG_ON() lines should just be removed.  I've uploaded fixed 
patch.  Thanks for pointing out.

-- 
tejun

