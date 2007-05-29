From: "Gregor Jasny" <gjasny@googlemail.com>
Subject: Re: Linux v2.6.22-rc3
Date: Tue, 29 May 2007 17:19:32 +0200
Message-ID: <9d2cd630705290819m1e52059cwc749c18e284dffbe@mail.gmail.com>
References: <alpine.LFD.0.98.0705252008210.26602@woody.linux-foundation.org>
	 <9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com>
	 <46599E6B.1000209@pobox.com>
	 <9d2cd630705270907y4722653cpf79f073fa8f12f08@mail.gmail.com>
	 <alpine.LFD.0.98.0705270922030.26602@woody.linux-foundation.org>
	 <9d2cd630705271315x7030c91ew2f175c921c022880@mail.gmail.com>
	 <465AA536.6080608@gmail.com>
	 <9d2cd630705280707h4921900fxc93a07a87f0bdf66@mail.gmail.com>
	 <465BF244.5080200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:40307 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbXE2PTe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 May 2007 11:19:34 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1884851ugf
        for <linux-ide@vger.kernel.org>; Tue, 29 May 2007 08:19:32 -0700 (PDT)
In-Reply-To: <465BF244.5080200@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

2007/5/29, Tejun Heo <htejun@gmail.com>:
> Aieee, so the drive doesn't like the new SRST sequence.  Indan pointed
> me to your original posting and before the reset sequence update your
> drive was reset successfully but only after 30sec delay, right?  If you
> change the first entry in ata_eh_reset_timeouts[] table at the top of
> libata-eh.c to 35 * HZ, does it work?

No, it even times out after 35 seconds. I've raised the first timeout
to 60 seconds but still no success.
