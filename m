From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream-fixes] git tree available
Date: Wed, 21 May 2008 13:59:00 +0900
Message-ID: <4833AC14.5090207@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com> <48305961.2050509@gmail.com> <006501c8ba19$c1f53340$6917a8c0@parents> <48323E4F.3050806@rtr.ca> <4832535B.1080505@gmail.com> <483256FF.1010200@gmail.com> <00a501c8bae2$7815f7e0$6917a8c0@parents>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:60078 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbYEUE7H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 May 2008 00:59:07 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2051071wfd.4
        for <linux-ide@vger.kernel.org>; Tue, 20 May 2008 21:59:06 -0700 (PDT)
In-Reply-To: <00a501c8bae2$7815f7e0$6917a8c0@parents>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian & Chamaigne Scamman <scammanbc@earthlink.net>
Cc: 'Mark Lord' <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org

Brian & Chamaigne Scamman wrote:
> Tejun Heo wrote:
>> Can you please test whether the attached patch fixes the detection problem?
> 
> Tejun-
> The patch worked great; see dmesg log below...
> I didn't test the sslep(5) command since the patch worked; do you still need
> me to test it?

Nope.

> One remaining issue is the "failed to IDENTIFY (I/O error, err mask=0xll)"
> message. If the PMP, bridges and drives are powered up before I insert the
> eSATA cable in to the controller, I don't receive the message. The message
> appears when only when I have the eSATA cable attached to the controller and
> then simultaneously power on the PMP and drives. In the attached dmesg log,
> the drive is eventually recognized; however there have been a couple of
> times when the drives aren't recognized. An eSATA cable remove/re-insert
> fixes the problem.

Hmm... can you please post the failing log?

-- 
tejun
