From: Tejun Heo <htejun@gmail.com>
Subject: Re: [SATA] max-sect and sii-m15w branches merged
Date: Thu, 10 Aug 2006 20:25:56 +0900
Message-ID: <44DB17C4.2070908@gmail.com>
References: <44DB106C.6090504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:53716 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161173AbWHJL0R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 07:26:17 -0400
Received: by nf-out-0910.google.com with SMTP id a4so502332nfc
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 04:26:04 -0700 (PDT)
In-Reply-To: <44DB106C.6090504@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> I just merged the max-sect and sii-m15w branches into the upstream branch.
> 
> This means that the following two changes are queued for 2.6.19:
> 
> * increase max sectors from 200 to 256 (for lba28)
> * better mod15write support for sata_sil

Are we ready for m15w-iterate-over-large-write patch?  It has been used 
by many people for quite some time and works great.  If you think we can 
merge that patch, I'll port it over #upstream.

Thanks.

-- 
tejun
