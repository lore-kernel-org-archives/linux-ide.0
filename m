From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI and add_disk_randomness()
Date: Mon, 20 Nov 2006 11:35:24 +0900
Message-ID: <4561146C.9030203@gmail.com>
References: <1124564609.20061115220130@marki-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:40939 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933871AbWKTCfe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Nov 2006 21:35:34 -0500
Received: by nf-out-0910.google.com with SMTP id k27so2158588nfc
        for <linux-ide@vger.kernel.org>; Sun, 19 Nov 2006 18:35:32 -0800 (PST)
In-Reply-To: <1124564609.20061115220130@marki-online.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Podmaka <marki@marki-online.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Marek Podmaka wrote:
> Hello,
> 
>   I have server with Intel 5000V motherboard with integrated AHCI SATA
>   controller. It works well with kernel 2.6.18.2. But I have problem
>   with little entropy available and I'm not sure if one of the reasons
>   is that AHCI driver does not use add_disk_randomness() to contribute
>   to the kernel entropy pool.
> 
>   I'm not very skilled on kernel "hacking"... I tried finding where
>   this is called (it's defined in drivers/char/random.c and used for
>   example in Comapaq SmartArray driver in drivers/block/cciss.c). For
>   the SCSI part, I found it in scsi_lib.c, but I was not able to
>   determine if this is actually used by ahci/libata drivers.
> 
>   If not, would it be possible to implement it? I tried to figure out
>   where to call it by looking at cciss.c, but it seems that this is
>   totally different case, at least for me. I don't know where to add
>   it, because its parameter is struct gendisk *disk and didn't find it
>   used anywhere in ahci or libata.

libata currently attaches as a SCSI device and SCSI midlayer invokes 
add_disk_randomness() in scsi_enq_request().  So, ahci is already 
contributing to entropy pool.  cciss needs explicit call to the function 
because it's a separate block driver and has no one above to handle it 
automatically.  You probably need to look for another source if you need 
more.

-- 
tejun
