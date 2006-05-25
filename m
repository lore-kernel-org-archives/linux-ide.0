From: Tejun Heo <htejun@gmail.com>
Subject: Re: SiI3124 + SiI3726 pm
Date: Thu, 25 May 2006 13:54:44 -0700
Message-ID: <44761994.2050303@gmail.com>
References: <89d273ba0605242046x3d19dd06h74885048f229d519@mail.gmail.com>	 <89d273ba0605242202l354ec106w22bccf649e5e1dfc@mail.gmail.com>	 <44753B78.4090802@gmail.com> <c70ff3ad0605251329m34af33bfj3ace5d5f9b32af38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:13996 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030413AbWEYUy6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 May 2006 16:54:58 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2343907ugf
        for <linux-ide@vger.kernel.org>; Thu, 25 May 2006 13:54:56 -0700 (PDT)
In-Reply-To: <c70ff3ad0605251329m34af33bfj3ace5d5f9b32af38@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: =?ISO-8859-1?Q?J=E9r=F4me_VUARAND?= <jerome.vuarand@gmail.com>, linux-ide@vger.kernel.org

saeed bishara wrote:
> Hi,
>       I think the 6th port is for the SEMB(Sata Enclosure Management
> Bridge) device, this device reportssignature with lbam=0x3c and lbah
> 0xc3, but the linux classifies it as a disk:
> 
>  if (((tf->lbam == 0) && (tf->lbah == 0)) ||
>  ((tf->lbam == 0x3c) && (tf->lbah == 0xc3))) {
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> DPRINTK("found ATA device by sig\n");
> return ATA_DEV_ATA;
> 
> Can you print the signature of the device on that port?
> Anyway, the 0x3C, 0xC3 signature should be classifies as a SEMB device
> and not a disk according to the SATA standard.

I haven't actually checked that signature but that's probably the same 
class code mix up described for PM in the classification function.  For 
the time being, libata is just ignoring the extra port.  It probably 
should be exported as a SCSI device without HLD attached (/dev/sgX 
only).  I'll try that once hotplug stuff settles.

Thanks.

-- 
tejun
