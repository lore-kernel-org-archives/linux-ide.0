From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Mon, 9 Apr 2007 18:42:37 -0400
Message-ID: <87f94c370704091542n4ae726b4x31cac3d186448ee0@mail.gmail.com>
References: <200704092133.l39LXtrM022972@harpo.it.uu.se>
	 <20070409220233.GA3088@ipom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:58486 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbXDIWmj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 18:42:39 -0400
Received: by wr-out-0506.google.com with SMTP id 71so1010913wri
        for <linux-ide@vger.kernel.org>; Mon, 09 Apr 2007 15:42:38 -0700 (PDT)
In-Reply-To: <20070409220233.GA3088@ipom.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Dibowitz <phil@ipom.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

On 4/9/07, Phil Dibowitz <phil@ipom.com> wrote:
> Mikael,
>
> Thanks for the quick response. I appreciate your help. I guess I'm buying a
> SATA PCI card!
>
> Looks like my choice of reasonably-priced known-brands is Highpoint and
> Promise (specifically a Highpoint ROCKETRAID1520 or a Promise SATA300 TX4) -
> are one of these brands better from a Linux compatibility or hardware-bug
> standpoint?
>

Quoting an old e-mail from Tejun Heo:

===
I primarily work on sil controllers and ICH7R piix/ahci because I have
access to the hardware and docs.  So, those tend to get new features
first and get a lot of testing.

If you're planning on using Port Multiplier, sil3124/32 would be the
best bet ATM.
===

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
