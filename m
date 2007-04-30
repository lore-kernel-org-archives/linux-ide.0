From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sun, 29 Apr 2007 23:42:30 -0400
Message-ID: <463565A6.3040506@rtr.ca>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <4634163D.1040408@gmail.com> <463487F0.4040701@rtr.ca> <46349695.7080706@rtr.ca> <46349A03.9090300@rtr.ca> <4634CAEC.4010700@gmail.com> <4634CC18.4080208@rtr.ca> <4634E8B3.4050301@rtr.ca> <4634ED0D.1090709@rtr.ca> <46353E63.7070000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2788 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422910AbXD3Dmd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Apr 2007 23:42:33 -0400
In-Reply-To: <46353E63.7070000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
>
> Hmmm... that's very weird.  I've never seen such problems.  The report
> messages are printed in ata_eh_report() and both the cmd and res lines
> are printed by single invocation to printk().  Is the log captured using
> serial console?  I think it could be transmission error or buffer
> overflow on serial link.

Naw, just "dmesg > file", so it should be a pretty reliable capture.
Just odd.  Something weird.

Cheers

