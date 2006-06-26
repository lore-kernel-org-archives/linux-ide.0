From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] [PATCHSET] new Power Management for libata, take 2
Date: Mon, 26 Jun 2006 17:15:34 +0900
Message-ID: <449F97A6.3080103@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>	 <1151304179.7132.169.camel@forrest26.sh.intel.com>	 <449F8597.7090605@gmail.com> <1151304561.7132.173.camel@forrest26.sh.intel.com> <449F88A9.30109@gmail.com> <449F8AB1.70804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:25958 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964865AbWFZIPg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 04:15:36 -0400
Received: by py-out-1112.google.com with SMTP id t32so1373771pyc
        for <linux-ide@vger.kernel.org>; Mon, 26 Jun 2006 01:15:36 -0700 (PDT)
In-Reply-To: <449F8AB1.70804@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> I don't know much about ACPI but don't we need to do it regardless of 
>> LLDs?
> 
> Yes.  Though generally ACPI only ever has knowledge of the drives 
> directly attached to the motherboard.

I've tried to read ACPI spec through several times but, man, it was 
boring.  Also, I've just printed out EFI spec and it is massive.  Are 
there any better/more humanly readings regarding these topics?  I don't 
mind reading specs but these two are monsters.

-- 
tejun
