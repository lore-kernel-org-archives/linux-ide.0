From: "Yasha Okshtein" <flyashi@gmail.com>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Wed, 18 Jul 2007 09:49:46 -0700
Message-ID: <6b01c6170707180949v297dda23nefb8fc9fb74b22f5@mail.gmail.com>
References: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com>
	 <6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>
	 <20070718014534.6a0adffe@the-village.bc.nu>
	 <6b01c6170707171800t39f2aac5x80a6d33b892fbda8@mail.gmail.com>
	 <20070718135435.42e4b3f8@the-village.bc.nu>
Reply-To: flyashi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:19843 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760601AbXGRQts (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 12:49:48 -0400
Received: by ug-out-1314.google.com with SMTP id j3so287564ugf
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 09:49:47 -0700 (PDT)
In-Reply-To: <20070718135435.42e4b3f8@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On 7/18/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> The neccessary parts get called from libata-eh based upon the flags set
> by the error code to indicate how to recover.

I see... now let me see if I have this straight:
- ata_scsi_pass_thru checks and sees that it's a (soft,hard)reset
- sets up eh_info.action with either ATA_EH_HARDRESET or ATA_EH_SOFTRESET
- calls ata_port_schedule_eh(ap);

>From there, I think the error handler gets queued, but the user
process returns. The other option for the last step would be to call
the driver's error_handler directly.

This method seems to me like a better solution.

 - Yasha
