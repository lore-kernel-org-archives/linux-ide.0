From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Wed, 04 Jul 2007 10:48:40 +0900
Message-ID: <468AFC78.6090604@gmail.com>
References: <courier.4689EFD9.0000589A@blargh.com>            <468A0E24.7020000@gmail.com> <courier.468AFAA8.00000F2D@blargh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:15766 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbXGDBsq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 21:48:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3073503wah
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 18:48:46 -0700 (PDT)
In-Reply-To: <courier.468AFAA8.00000F2D@blargh.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7091@blargh.com
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

7091@blargh.com wrote:
> That indeed seems to have fixed the problem - I've been pulling my hair
> out forever about this!
> Is this something I'll need to leave in forever, is it supposed to get
> fixed, etc.?
> I'm going to continue doing testing and really try to thrash it tonight
> (I just did the 'copy an ISO 5 times' test that always failed before -
> it succeeds now).
> Thanks for the help.

I think fix is included during 2.6.22 devel cycle which basically is
turning off IOMMU by default on the affected chipset but I haven't
really followed after that.

-- 
tejun
