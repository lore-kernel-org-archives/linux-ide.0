From: Mogens Valentin <mogensv@vip.cybercity.dk>
Subject: Re: Issues with AHCI and SATAII using JMD360
Date: Sun, 07 May 2006 14:17:15 +0200
Message-ID: <445DE54B.4000609@vip.cybercity.dk>
References: <20060507043702.052e3f56.moritz-heiber@arcor.de>	<445D6298.7090003@gmail.com> <20060507140443.7ae89a68.moe@lunar-linux.org>
Reply-To: mogensv@vip.cybercity.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cicero0.cybercity.dk ([212.242.40.52]:28132 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S932135AbWEGMPg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 May 2006 08:15:36 -0400
In-Reply-To: <20060507140443.7ae89a68.moe@lunar-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Moritz Heiber <moe@lunar-linux.org>, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Moritz Heiber wrote:
> On Sun, 07 May 2006 11:59:36 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>>More info can be obtained by printing SCR_CONTROL, just print the
>>result of scr_read(ap, SCR_CONTROL) from
>>libata.c::sata_print_link_status(), which prints the SStatus value.
> 
> 
> I'm going to try to follow that lead. There doesn't seem to be any sort
> of tool or application that runs the exact same test yet, is there?
> hdparm fails on me.

You might want to take a look at Douglas Gilbert's sdparm.

-- 
Kind regards,
Mogens Valentin

