From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.19 2/3] sata_promise: new EH conversion
Date: Wed, 06 Dec 2006 18:40:59 +0900
Message-ID: <4576902B.3070006@gmail.com>
References: <200612060852.kB68q4i0024622@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:37880 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760388AbWLFJlG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2006 04:41:06 -0500
Received: by nz-out-0102.google.com with SMTP id s1so91642nze
        for <linux-ide@vger.kernel.org>; Wed, 06 Dec 2006 01:41:06 -0800 (PST)
In-Reply-To: <200612060852.kB68q4i0024622@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
>> 3. we don't have them in ahci nor sata_sil24.
> 
> But you do in sata_sil.c:sil_freeze().

Two versus one.  It's democracy.  :-)

>> But, having those flushes won't hurt either.
> 
> libata doesn't specify in its documentation that these driver
> operations may have delayed behaviour, so I have to assume that
> side-effects are to be completed when the operations return.
> In fact, the documentation for __ata_port_freeze explicitly
> requires the port to not perform any operations until thawed.
> If I didn't flush, the port could do just that.

I can't fully understand the above paragraph.  Please elaborate.

> Since the flushes clearly are safe I'd prefer to keep them, but
> of course I'll remove them if you or Jeff can guarantee that not
> flushing the PCI writes is OK.

I don't really know.  AFAICT, things should work without those flushes.
 ATA devices are often crappy and drivers are built to deal with those
kinds of spurious interrupts while frozen.  And, yes, having it never
hurts.  I'm just not quite sure what they guarantee.  IRQ signals are
asynchronous to IOs, so flushing IO doesn't guarantee immediate IRQ
quiescence.

If you leave those flushes, that makes it two versus two.  Universe will
be in balance.  :-)

-- 
tejun
