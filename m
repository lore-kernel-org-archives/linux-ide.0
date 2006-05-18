From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS A8V Deluxe, x86_64
Date: Thu, 18 May 2006 12:29:50 +0900
Message-ID: <446BEA2E.3030100@gmail.com>
References: <8E8F647D7835334B985D069AE964A4F7028FDC15@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:47787 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751206AbWERDaA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 23:30:00 -0400
Received: by nf-out-0910.google.com with SMTP id d4so280426nfe
        for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 20:29:59 -0700 (PDT)
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7028FDC15@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Cc: albertl@mail.com, Andi Kleen <ak@suse.de>, Marko Macek <Marko.Macek@gmx.net>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>

Fortier,Vincent [Montreal] wrote:
> scsi0 : sata_via
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:001f
> ata2.00: ATAPI, max UDMA/66
> ata2.00: applying bridge limits
> ata2.00: configured for UDMA/66
[--snip--]
> sd 0:0:0:0: Attached scsi disk sda
>   Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.09
>   Type:   CD-ROM                             ANSI SCSI revision: 05

Above and the detailed log too indicate that everything went smooth the 
first time around.  Albert, do you have any ideas?  Could it be 
something related to irq-pio?

-- 
tejun
