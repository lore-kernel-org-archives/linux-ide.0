From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] ahci updates regarding vt8251 support, take #2
Date: Mon, 23 Oct 2006 11:29:06 +0900
Message-ID: <453C28F2.5070004@gmail.com>
References: <11609522031228-git-send-email-htejun@gmail.com> <453A73CE.60205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:12 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751182AbWJWC3P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Oct 2006 22:29:15 -0400
Received: by nf-out-0910.google.com with SMTP id c2so2234164nfe
        for <linux-ide@vger.kernel.org>; Sun, 22 Oct 2006 19:29:14 -0700 (PDT)
In-Reply-To: <453A73CE.60205@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, aalderd.boac@wanadoo.nl, linux-ide@vger.kernel.org

Hello, Jeff.

Jeff Garzik wrote:
> Patchset looks OK to me, with a few notes:
> 
> 1) might want to separate out this change and forward it to 
> #upstream-fixes:
> -    ahci_tf_read(ap, &tf);
> -    if (tf.command & (ATA_BUSY | ATA_DRQ)) {
> +    if (ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ)) {

Okay, will do that.

> 2) In general, it's a good idea to clear SError after twiddling with the 
> phy.  Not just on vt8521.

It's done in ->post_reset() after a successful soft/hard reset, so the 
issue occurs only when the controller needs follow-up SRST after 
hardreset and the softreset doesn't work unless SError isn't cleared. 
And, vt8251 is the only such controller at the moment (heh heh 
surprise!), so I think we can leave it there for the time being.

> 3) Any positive test results yet?

Aalderd confirmed the change.  He has reported a spurious IRQ problem 
but it's emitted when loading vmware modules and doesn't seem to be 
related to libata at all.  My vt8251 also does hotplug happily with the 
change, so we have two positive test results.

Thanks.

-- 
tejun
