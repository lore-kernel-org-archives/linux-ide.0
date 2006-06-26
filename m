From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCHSET] [PATCHSET] new Power Management for libata, take 2
Date: Mon, 26 Jun 2006 16:09:06 +0800
Message-ID: <1151309347.7132.194.camel@forrest26.sh.intel.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
	 <1151304179.7132.169.camel@forrest26.sh.intel.com>
	 <449F8597.7090605@gmail.com>
	 <1151304561.7132.173.camel@forrest26.sh.intel.com>
	 <449F88A9.30109@gmail.com> <449F8AB1.70804@pobox.com>
	 <449F97A6.3080103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31559 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964869AbWFZIYV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 04:24:21 -0400
In-Reply-To: <449F97A6.3080103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Mon, 2006-06-26 at 17:15 +0900, Tejun Heo wrote:
> Jeff Garzik wrote:
> > Tejun Heo wrote:
> >> I don't know much about ACPI but don't we need to do it regardless of 
> >> LLDs?
> > 
> > Yes.  Though generally ACPI only ever has knowledge of the drives 
> > directly attached to the motherboard.
> 
> I've tried to read ACPI spec through several times but, man, it was 
> boring.  Also, I've just printed out EFI spec and it is massive.  Are 
> there any better/more humanly readings regarding these topics?  I don't 
> mind reading specs but these two are monsters.
> 

For SATA-ACPI, you only need to read section 9.9 of ACPI spec 3.0. It's
a short section. For basic concepts of ACPI, I don't know which document
is more humanly reading. I asked my colleagues when I was confused about
basic ACPI concepts.

Thanks,
Forrest
