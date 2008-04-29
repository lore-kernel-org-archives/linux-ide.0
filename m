From: "Oliver Pinter" <oliver.pntr@gmail.com>
Subject: Re: Re[2]: [BUG REPORT, 2.6.22] sata controler failure on nforce 2 chipset
Date: Tue, 29 Apr 2008 16:48:34 +0200
Message-ID: <6101e8c40804290748m62bd1cbew457e3932de88fb5c@mail.gmail.com>
References: <396712385.20080423011459@3d-io.com>
	 <20080425231108.03dfa7cb.akpm@linux-foundation.org>
	 <986072.20080429025543@3d-io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:44743 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYD2Osh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Apr 2008 10:48:37 -0400
Received: by fg-out-1718.google.com with SMTP id l27so26114fgb.17
        for <linux-ide@vger.kernel.org>; Tue, 29 Apr 2008 07:48:34 -0700 (PDT)
In-Reply-To: <986072.20080429025543@3d-io.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: speedy <speedy@3d-io.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

hi, the cooling of the southbridge is good?

or when you has spirit for testing or use newer 2.6.22.y, then:
http://repo.or.cz/w/linux-2.6.22.y-op.git
http://students.zipernowsky.hu/~oliverp/kernel-stable/

sorry for bad english

On 4/29/08, speedy <speedy@3d-io.com> wrote:
> Hello Andrew,
>
> Saturday, April 26, 2008, 8:11:08 AM, you wrote:
>
> >> On Wed, 23 Apr 2008 01:14:59 +0200 speedy <speedy@3d-io.com> wrote:
> >> Hello Linux kernel crew,
> >>
> >>        [Consider this more as a datapoint then a bug report, as after
> >>        one network and one sata/southbridge issues showing up
> >>        interminnently, the ASRock motherboard involved will be
> >>        scrapped for a different one]
> >>
> >>        The integrated NVidia sata controller and/or the hard-drive has
> failed
> >>        during operation with the following output:
>
> AM> 2.6.22 is rather old.  Can you please retest 2.6.25?
>
>     Unfortunately not, the motherboard has been changed for a
>     different one in that server, as I needed to deploy it. The
>     system is now behaving properly.
>
>     If someone of the kernel developers is interested in toying with
>     an NForce 2 motherboard which probably overheats the southbridge
>     and crashes approx. once a day under I/O load, I could ask the
>     management to donate it.
>
>     It reproduces:
>
>     * "RX unit hang detected" in i1000 drivers
>     * SATA soft-raid (infinite?) HDD resetting loop
>
>     ;)
>
>     Cheers!
>
>
> --
> Best regards,
>  speedy                            mailto:speedy@3d-io.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Thanks,
Oliver
