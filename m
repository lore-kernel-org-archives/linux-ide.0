From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Tue, 29 Jan 2008 13:24:14 +0900
Message-ID: <479EAA6E.9090102@gmail.com>
References: <4794459C.3090200@gmail.com> <4798CCDF.9070305@gmail.com>	 <4798CE10.2050005@gmail.com> <4798D4A2.7030303@gmail.com>	 <47991AD9.6050804@gmail.com> <47993686.5040405@gmail.com>	 <479939E3.4020307@gmail.com> <479D0AB5.6070203@gmail.com>	 <479D256C.1090507@gmail.com>	 <864c1e490801272251j300f8010if7bdfc967bee3293@mail.gmail.com> <864c1e490801282000h408fda32r8ca1fe805e33f6f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:23951 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbYA2EYX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 23:24:23 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1910453rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 28 Jan 2008 20:24:21 -0800 (PST)
In-Reply-To: <864c1e490801282000h408fda32r8ca1fe805e33f6f6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Evans <evans02472@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Thomas Evans wrote:
> No like with only a drive attached and no PMP.  The driver is still
> unable to IDENTIFY the connected disk:
> 
> failed to IDENTIFY (I/O error, err_mask=0x20)

So, the problem is not specific to PMP support.  That makes more sense.
 Does moving the controller to different slot make any difference?

-- 
tejun
