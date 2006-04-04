From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata machine check on Alpha
Date: Tue, 04 Apr 2006 10:43:41 +0900
Message-ID: <4431CF4D.6000806@gmail.com>
References: <1br232p2g092l611qrqvmvpuus2bqp7bc2@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:43982 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751265AbWDDBnq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 21:43:46 -0400
Received: by zproxy.gmail.com with SMTP id o37so2055889nzf
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 18:43:45 -0700 (PDT)
In-Reply-To: <1br232p2g092l611qrqvmvpuus2bqp7bc2@4ax.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Blake Benson <airbatica@verizon.net>
Cc: linux-ide@vger.kernel.org

Jonathan Blake Benson wrote:
> I posted a couple of months ago regarding enabling libata.atapi on a
> Digital Alpha 164LX, equipped with a Silicon Image 3114 controller.  I
> decied to give kernel 2.6.16 (release, was previously using rc-1) a
> shot, and it no longer longer panics.  I still have a Lite-ON DVD ROM
> drive connected via a sil3611 bridge to port number 4, hoping that I
> can avoid using the onboard CMD646.
> 
> No panic this time, though it appears to throw a machine check.  The
> system continues all the way to multi-user, and the Maxtor drives are
> usable.  Hope the attached dmesg helps.  Let me know if I can be of
> any assitance.
> 

Can you build your kernel with ATA_DEBUG set and post dmesg?  Just 
change #undef ATA_DEBUG to #define ATA_DEBUG at the top of 
include/linux/libata.h

-- 
tejun
