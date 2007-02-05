From: Tejun Heo <htejun@gmail.com>
Subject: Re: Nvidia cable detection problems (was [PATCH] amd74xx: don't configure
 udma mode higher than BIOS did)
Date: Tue, 06 Feb 2007 03:36:17 +0900
Message-ID: <45C77921.4020808@gmail.com>
References: <20070205075836.GG1625@htj.dyndns.org>	<20070205112410.5a3c3182@localhost.localdomain>	<45C72012.7050605@gmail.com>	<20070205132247.6f611e3c@localhost.localdomain>	<45C73A3E.6080700@gmail.com>	<20070205143439.6962c076@localhost.localdomain>	<45C7444F.4070500@gmail.com>	<58cb370e0702050709w1b7682dr5dff9e7ce69465a@mail.gmail.com>	<DBFABB80F7FD3143A911F9E6CFD477B01EC0DD7D@hqemmail02.nvidia.com> <20070205181224.3319d6c3@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:43065 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933021AbXBESgX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 13:36:23 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1682025nze
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 10:36:23 -0800 (PST)
In-Reply-To: <20070205181224.3319d6c3@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Allen Martin <AMartin@nvidia.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Alan wrote:
>> The *real* solution is to use the BIOS ACPI _GTM _STM methods for this.
>> Then you can remove all chipset specific knowledge from the IDE driver.
>> This is what the MS driver does on Windows, so you know it's received a
>> lot of testing from NVIDIA and board vendors.
> 
> Well we can certainly do some of that if ACPI is present and active. In
> particular since _GTM will give us current modes allowing for hotplug and
> post BIOS boot kexec etc it ought to be safe to do Tejun's hack that way.
> We could even probe UDMA3+ capable devices by doing _STM to a high mode
> and _GTM to determine the cable type 8)

Glad to see the problem getting solved.  Now that we know the solution,
any volunteers?  :-)

-- 
tejun
