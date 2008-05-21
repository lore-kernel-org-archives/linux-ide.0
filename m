From: "Brian & Chamaigne Scamman" <scammanbc@earthlink.net>
Subject: RE: [PATCHSET #upstream-fixes] git tree available
Date: Wed, 21 May 2008 07:14:48 -0400
Message-ID: <00a901c8bb33$e2228b20$6917a8c0@parents>
References: <12111273141039-git-send-email-htejun@gmail.com> <48305961.2050509@gmail.com> <006501c8ba19$c1f53340$6917a8c0@parents> <48323E4F.3050806@rtr.ca> <4832535B.1080505@gmail.com> <483256FF.1010200@gmail.com> <00a501c8bae2$7815f7e0$6917a8c0@parents> <4833AC14.5090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:58561 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754195AbYEULOv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 May 2008 07:14:51 -0400
In-Reply-To: <4833AC14.5090207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: 'Mark Lord' <liml@rtr.ca>, jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
>Brian & Chamaigne Scamman wrote:
>> One remaining issue is the "failed to IDENTIFY (I/O error, err
mask=0xll)"
>> message. If the PMP, bridges and drives are powered up before I insert
the
>> eSATA cable in to the controller, I don't receive the message. The
message
>> appears when only when I have the eSATA cable attached to the controller
and
>> then simultaneously power on the PMP and drives. In the attached dmesg
log,
>> the drive is eventually recognized; however there have been a couple of
>> times when the drives aren't recognized. An eSATA cable remove/re-insert
>> fixes the problem.
>
>Hmm... can you please post the failing log?

In my previous post, there are two cases where the drive wasn't initially
recognized, but did respond after a PMP link reset (ata3.00 and ata3.03).
I'll post a log today were one of the drives is never recognized (doesn't
happen that often)

-Brian

