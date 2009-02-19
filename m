From: Sagar Borikar <sagar.borikar@gmail.com>
Subject: Re: Synopsis SATA AHCI support
Date: Thu, 19 Feb 2009 20:05:26 +0530
Message-ID: <3fb94e50902190635g5f47e244w2631c9a3103fa6a@mail.gmail.com>
References: <3fb94e50902182156y62da0f6dhfb5d99ad5de9d0fd@mail.gmail.com>
	 <499D1EEB.3000200@kernel.org>
	 <3fb94e50902190318p4e423594o4be96bf0ee70007f@mail.gmail.com>
	 <499D6201.9040705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:15871 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbZBSOf1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Feb 2009 09:35:27 -0500
Received: by wa-out-1112.google.com with SMTP id v33so226177wah.21
        for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2009 06:35:26 -0800 (PST)
In-Reply-To: <499D6201.9040705@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi Tejun

Its not PCI interface but AHB. This SATA IP is intergated and
connected to AXI through AHB bridge. And as the ARM core based board
is in development stage, I haven't added all SATA functionalities. I
am debugging based on the serial output

Thanks
Sagar

On Thu, Feb 19, 2009 at 7:13 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> Sagar Borikar wrote:
>> Tejun,
>> Synospsis device is a standard one. What I am unable to understand is
>> the SATA driver soruces for that. Or may be I am missing something. I
>> have enabled ahci in my platform but it's not getting detected
>
> Please keep linux-ide cc'd.  Hmmm... if you have ahci enabled, it
> should work if the device is advertising standard ahci interface via
> its pci class code.  Can you post the output of "lspci -nn" and the
> boot log?
>
> Thanks.
>
> --
> tejun
>
