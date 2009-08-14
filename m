From: Chris K <kayex@rogers.com>
Subject: Re: Ubuntu 9.04 (2.6.28-14) and eSATA Port Multiplier (PMP) Not
	working
Date: Fri, 14 Aug 2009 17:22:02 -0400
Message-ID: <e3fccfde0908141422r373a702dq9354367611f72a30@mail.gmail.com>
References: <e3fccfde0908101354y4e98a985nc119d8941e8b1665@mail.gmail.com>
	 <4A8242C5.3060605@gmail.com>
	 <e3fccfde0908121530j4f7abe0as34b0f7e3813f8e53@mail.gmail.com>
	 <4A852924.3050000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:50590 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766AbZHNVWC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Aug 2009 17:22:02 -0400
Received: by bwz22 with SMTP id 22so1364579bwz.18
        for <linux-ide@vger.kernel.org>; Fri, 14 Aug 2009 14:22:02 -0700 (PDT)
In-Reply-To: <4A852924.3050000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

The libata.force=1.5Gbps kernel parameter did not make any difference for me.

Chris.

On Fri, Aug 14, 2009 at 5:06 AM, Tejun Heo <htejun@gmail.com> wrote:
>
> Hello,
>
> Chris K wrote:
> > I gave the 2.6.30-2 kernel a try and I received the same error message
> > as quoted below - it just happened a bit later on in the boot process.
> > (not at the "starting.." screen)
>
> Does libata.force=1.5Gbps kernel parameter make any difference?
>
> Thanks.
>
> --
> tejun
