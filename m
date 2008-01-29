From: Thomas Evans <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Mon, 28 Jan 2008 23:31:10 -0500
Message-ID: <479EAC0E.6010008@gmail.com>
References: <4794459C.3090200@gmail.com> <4798CCDF.9070305@gmail.com>	 <4798CE10.2050005@gmail.com> <4798D4A2.7030303@gmail.com>	 <47991AD9.6050804@gmail.com> <47993686.5040405@gmail.com>	 <479939E3.4020307@gmail.com> <479D0AB5.6070203@gmail.com>	 <479D256C.1090507@gmail.com>	 <864c1e490801272251j300f8010if7bdfc967bee3293@mail.gmail.com> <864c1e490801282000h408fda32r8ca1fe805e33f6f6@mail.gmail.com> <479EAA6E.9090102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:28104 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbYA2EbP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 23:31:15 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1064141wra.1
        for <linux-ide@vger.kernel.org>; Mon, 28 Jan 2008 20:31:14 -0800 (PST)
In-Reply-To: <479EAA6E.9090102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

I've tried it in various slots on both PCI hoses  - no difference.

...tom

Tejun Heo wrote:
> Thomas Evans wrote:
>   
>> No like with only a drive attached and no PMP.  The driver is still
>> unable to IDENTIFY the connected disk:
>>
>> failed to IDENTIFY (I/O error, err_mask=0x20)
>>     
>
> So, the problem is not specific to PMP support.  That makes more sense.
>  Does moving the controller to different slot make any difference?
>
>   

