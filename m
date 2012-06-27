From: Mark Nelson <mdnelson8@gmail.com>
Subject: Re: [PATCH 1/1] ahci: Enable SB600 64bit DMA on MSI K9AGM2 (MS-7327)
Date: Wed, 27 Jun 2012 16:31:10 +1000
Message-ID: <4FEAA8AE.8040807@gmail.com>
References: <4FE92267.60106@gmail.com> <4FE9937B.7080503@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:51775 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab2F0GbV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jun 2012 02:31:21 -0400
Received: by yhnn12 with SMTP id n12so768271yhn.10
        for <linux-ide@vger.kernel.org>; Tue, 26 Jun 2012 23:31:20 -0700 (PDT)
In-Reply-To: <4FE9937B.7080503@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, tj@kernel.org

On 26/06/12 20:48, Sergei Shtylyov wrote:
> Hello.
>
> On 26-06-2012 6:45, Mark Nelson wrote:
>
>> Like e65cc194f7628ecaa02462f22f42fb09b50dcd49
>
> Please also specify that commit's summary in parens.

Very good point! Should I do a simple respin of this patch adding the 
commit summary, or just do it for future patches?

Thanks!
Mark

>
>> this patch enables 64bit DMA
>> for the AHCI SATA controller of a board that has the SB600
>> southbridge. In
>> this case though we're enabling 64bit DMA for another MSI motherboard,
>> the
>> K9AGM2 or MS-7327. It is new enough that all of the BIOS releases since
>> the initial release (1.0 from 2007-02-09) work correctly with 64bit
>> DMA enabled.
>
>> Signed-off-by: Mark Nelson <mdnelson8@gmail.com>
>
> MBR, Sergei
