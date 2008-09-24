From: Tejun Heo <htejun@gmail.com>
Subject: Re: What's the SB600 64-bit DMA problem?
Date: Wed, 24 Sep 2008 18:46:51 +0900
Message-ID: <48DA0C8B.3000406@gmail.com>
References: <20080920151712.10515.qmail@science.horizon.com>	 <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com>	 <20080921001529.23400.qmail@science.horizon.com> <65a6ef750809231730h52f6bf47g23b33db1d2f4ca08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:5977 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbYIXJsU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 05:48:20 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1302311tic.23
        for <linux-ide@vger.kernel.org>; Wed, 24 Sep 2008 02:48:18 -0700 (PDT)
In-Reply-To: <65a6ef750809231730h52f6bf47g23b33db1d2f4ca08@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: George Spelvin <linux@horizon.com>, grundler@google.com, linux-ide@vger.kernel.org, shane.huang@amd.com, jgarzik@redhat.com

Mark Nelson wrote:
> On Sun, Sep 21, 2008 at 10:15 AM, George Spelvin <linux@horizon.com> wrote:
>> "Grant Grundler" <grundler@google.com> wrote:
>>> On Sat, Sep 20, 2008 at 8:17 AM, George Spelvin <linux@horizon.com> wrote:
>>>> I just got a couple of MSI KA92 (AMD 790FX-based) motherboards with
>>>> 8 GiB of RAM each.  I noticed on boot that the SB600 AHCI implementation
>>>> had a 32-bit DMA limitation, and looking in the archives, it
>>>> appears that folks from AMD think it doesn't need to be there.
>>> URL?
>>> Just want to be sure I'm looking at the same thread.
>> "About forcing 32bit DMA patch for AMD690G(SB600)"
>> http://marc.info/?t=120107450600001
> 
> It looks like the results from people testing it further never arrived...
> 
>>From git commit a878539ef994787c447a98c2e3ba0fe3dad984ec ("ahci:
> work around ATI SB600 h/w quirk"), it looks like the initial
> idea was to limit each command to a maximum of 255 sectors (but
> to still allow 64bit DMA), but according to a later commit
> (4cde32fc4b32e96a99063af3183acdfd54c563f0; "ahci: SB600
> workaround is suspect... play it safe for now") this did not
> solve the lockups. But there are references in the thread above
> to broken MSI on the SB600 possibly being the cause of the problem,
> and now that commit 22b5e7a74280deae560c20ee1a9b502b35181327
> ("ahci: SB600 ahci can't do MSI, blacklist that capability") has gone in
> maybe this is why you're able to get 64bit DMA working? (although
> we do need more hints on how to conclusively test this)

Hmm... I doubt MSI has anything to do with 64bit DMA but then again
anything is possible.  Shane, anything came out of the testing?

Thanks.

-- 
tejun
