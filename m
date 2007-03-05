From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: sata_sil problems with recent kernels
Date: Mon, 5 Mar 2007 13:24:16 +0000
Message-ID: <8d158e1f0703050524w6e376cd3hffda0b05da9c78af@mail.gmail.com>
References: <1172250027.15179.16.camel@dale.velocity.net>
	 <1172602444.5420.17.camel@dale.velocity.net>
	 <1172698758.30931.18.camel@dale.velocity.net>
	 <45EB98E4.9070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:63588 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933479AbXCENYS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Mar 2007 08:24:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1233482uga
        for <linux-ide@vger.kernel.org>; Mon, 05 Mar 2007 05:24:17 -0800 (PST)
In-Reply-To: <45EB98E4.9070307@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Dale Blount <linux-kernel@dale.us>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 3/5/07, Tejun Heo <htejun@gmail.com> wrote:
> Dale Blount wrote:

>
> This will probably included in the next -stable iteration.  Thanks.
>
> --
> tejun


I can confirm that sata_sil is working great under 2.6.21-rc1.
I have an onboard Silicon Image SATA RAID controller and a PCI Add-on
card, also with silicon image chipset.

2x500GB Samsung
1x400GB Samsung

I am getting maximum troughput and no errors of any kind.


Patrick
