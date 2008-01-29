From: "Thomas Evans" <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Mon, 28 Jan 2008 23:00:35 -0500
Message-ID: <864c1e490801282000h408fda32r8ca1fe805e33f6f6@mail.gmail.com>
References: <4794459C.3090200@gmail.com> <4798CCDF.9070305@gmail.com>
	 <4798CE10.2050005@gmail.com> <4798D4A2.7030303@gmail.com>
	 <47991AD9.6050804@gmail.com> <47993686.5040405@gmail.com>
	 <479939E3.4020307@gmail.com> <479D0AB5.6070203@gmail.com>
	 <479D256C.1090507@gmail.com>
	 <864c1e490801272251j300f8010if7bdfc967bee3293@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:6551 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbYA2EAh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 23:00:37 -0500
Received: by py-out-1112.google.com with SMTP id u52so2782660pyb.10
        for <linux-ide@vger.kernel.org>; Mon, 28 Jan 2008 20:00:36 -0800 (PST)
In-Reply-To: <864c1e490801272251j300f8010if7bdfc967bee3293@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

No like with only a drive attached and no PMP.  The driver is still
unable to IDENTIFY the connected disk:

failed to IDENTIFY (I/O error, err_mask=0x20)


On Jan 28, 2008 1:51 AM, Thomas Evans <evans02472@gmail.com> wrote:
> On 1/27/08, Tejun Heo <htejun@gmail.com> wrote:
> > Hmmm... That's strange.  If PERR makes a difference, it means PCI bus
> > side is contributing to the problem but only when PMP is attached while
> > directly attached drive works just fine?
>
> I need to get a esata to sata cable - i returned all my duplicate equipment,
> so i haven't a 3124 with internal sata ports.  I will try soon.
>
