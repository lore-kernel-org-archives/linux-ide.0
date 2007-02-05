From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: Nvidia cable detection problems (was [PATCH] amd74xx: don't configure udma mode higher than BIOS did)
Date: Mon, 5 Feb 2007 22:27:59 +0100
Message-ID: <58cb370e0702051327p7b253dafs439c937093ca837d@mail.gmail.com>
References: <20070205075836.GG1625@htj.dyndns.org>
	 <20070205132247.6f611e3c@localhost.localdomain>
	 <45C73A3E.6080700@gmail.com>
	 <20070205143439.6962c076@localhost.localdomain>
	 <45C7444F.4070500@gmail.com>
	 <58cb370e0702050709w1b7682dr5dff9e7ce69465a@mail.gmail.com>
	 <DBFABB80F7FD3143A911F9E6CFD477B01EC0DD7D@hqemmail02.nvidia.com>
	 <20070205181224.3319d6c3@localhost.localdomain>
	 <45C77921.4020808@gmail.com>
	 <58cb370e0702051055w3c7dcff3wd3e3b4935b910b41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:23121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933466AbXBEV2C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 16:28:02 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1422144uga
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 13:27:59 -0800 (PST)
In-Reply-To: <58cb370e0702051055w3c7dcff3wd3e3b4935b910b41@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Allen Martin <AMartin@nvidia.com>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On 2/5/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > Well we can certainly do some of that if ACPI is present and active. In
> > > particular since _GTM will give us current modes allowing for hotplug and
> > > post BIOS boot kexec etc it ought to be safe to do Tejun's hack that way.
> > > We could even probe UDMA3+ capable devices by doing _STM to a high mode
> > > and _GTM to determine the cable type 8)
>
> agreed

New look at the issue:

Since we are already using UDMA mode set by BIOS to determine if 80c cable
is present so why not also use it to determine if the 40c cable is present?

I mean just ignoring AMD_CABLE_DETECT register for NVIDIA devices.

2-lines change and we wouldn't have to deal with ACPI at ell.

What do you think?

Bart
