From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 stability and performance
Date: Tue, 18 Mar 2008 13:09:20 +0900
Message-ID: <47DF4070.3040507@gmail.com>
References: <20080304002215.GA13317@denix.org> <47CCC1C6.5010600@gmail.com> <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com> <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com> <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com> <20080315214347.GA1511@denix.org> <47DDE0ED.6040304@rtr.ca> <20080318001513.GA2389@denix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:57167 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbYCREJ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Mar 2008 00:09:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so6719497wah.23
        for <linux-ide@vger.kernel.org>; Mon, 17 Mar 2008 21:09:26 -0700 (PDT)
In-Reply-To: <20080318001513.GA2389@denix.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>
Cc: Mark Lord <liml@rtr.ca>, Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>

Denys Dmytriyenko wrote:
> Meanwhile my system was quite stable lately, except for a few times when it 
> threw some exceptions below. Can you please help me interpret them and also 
> point out to how I can do it myself in the future. Thanks in advance.
> 
> Mar  8 02:09:49 [kernel] ata8: illegal qc_active transition (00000019->00000038)

Hmmm... This is first.  Which driver is it?  It means that controller is
reporting that NCQ command tags which are not issued (or already
completed) are in-flight.  Due to the way hdd reports NCQ command
completion, it's not possible for the drive to cause this.  This gotta
be a bug on the host side (be it controller chip or more likely the
driver).  The command tag in question is 5.  Only 0, 3 and 4 were in flight.

> Mar  8 03:19:33 [kernel] ata8: illegal qc_active transition (000000ff->000001f7)

The same but problematic tag is 8.

> Mar 14 23:51:43 [kernel] ata3: illegal qc_active transition (0000001b->0000002b)

Ditto but with tag 5.

> Mar 14 23:51:55 [kernel] ata3: failed to read log page 10h (errno=-2)
> Mar 14 23:51:55 [kernel] ata3.00: exception Emask 0x1 SAct 0x3f SErr 0x0 action 0x0
> Mar 14 23:51:55 [kernel] ata3.00: irq_stat 0x00020002, device error via SDB FIS

This one is different.  The drive reported device error but the driver
couldn't get more information about the error (log page 10h contains
it).  What does smartctl -a on the drive say?

-- 
tejun
