From: Tejun Heo <tj@kernel.org>
Subject: Re: sata-sil drive detection issues.
Date: Fri, 18 Feb 2011 10:16:29 +0100
Message-ID: <20110218091629.GC21209@htj.dyndns.org>
References: <4D5C92F4.5000906@crc.id.au>
 <4D5CA2B1.8020905@crc.id.au>
 <20110217095815.GN19830@htj.dyndns.org>
 <a9eccac6fe224ef627fc71e819ba30ae@crc.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52125 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757930Ab1BRJQe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 04:16:34 -0500
Received: by fxm20 with SMTP id 20so3555354fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2011 01:16:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <a9eccac6fe224ef627fc71e819ba30ae@crc.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Haigh <netwiz@crc.id.au>
Cc: linux-ide@vger.kernel.org

Hello,

On Fri, Feb 18, 2011 at 10:20:43AM +1100, Steven Haigh wrote:
> With this patch applied, my rebuilt kernel based on 2.6.32.26 (due
> to Xen Dom0 requirements) gives the following:
> 
> ata9: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0xe frozen
> ata9: SError: { PHYRdyChg CommWake }
> ata9: hard resetting link
> ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata9.00: failed to IDENTIFY (I/O error, err_mask=0x202)
> ata9: hard resetting link
> ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata9.00: failed to IDENTIFY (I/O error, err_mask=0x202)
> ata9: hard resetting link
> ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata9.00: failed to IDENTIFY (I/O error, err_mask=0x202)
> ata9: hard resetting link
> ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata9: EH complete

So, retrying doesn't help at all.

> I would really like to eliminate the possibility of it being my
> esata enclosure or the sata -> esata cable by using another cable
> and/or array for testing. New cables will be a few days off as I
> don't have any of these cables hanging around. My gut feeling says
> its the cable - as the enclosure works fine via the USB port -
> however that isn't conlusive proof that the esata port is working as
> it should!

Yeah, it looks like something is wrong with the setup.  Please let us
know how the testing goes with the new cable (hopefully shorter).

Thanks.

-- 
tejun
