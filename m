From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Mon, 30 Apr 2007 09:59:10 +0900
Message-ID: <46353F5E.3030203@gmail.com>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com> <4634163D.1040408@gmail.com> <463487F0.4040701@rtr.ca> <46349695.7080706@rtr.ca> <46349A03.9090300@rtr.ca> <4634CAEC.4010700@gmail.com> <4634CC18.4080208@rtr.ca> <4634E8B3.4050301@rtr.ca> <4634EC83.1030109@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:4230 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422770AbXD3DAF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Apr 2007 23:00:05 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1792007nzf
        for <linux-ide@vger.kernel.org>; Sun, 29 Apr 2007 20:00:05 -0700 (PDT)
In-Reply-To: <4634EC83.1030109@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> .. And here is another test of un-hacked 2.6.21,
> this time for ata_piix with a pure PATA configuration.
> Again, it passes with flying colours.

Thanks a lot.  I'd also like to try but I'm on the road and not bored
enough (yet) to do that on my only working machine.  It's good to know
that SRST is a strong enough kick in the pants for actual ATA devices.
So, we only have to fix that stubborn ata_piix.  :-)

-- 
tejun

