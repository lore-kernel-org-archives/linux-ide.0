From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS A8V Deluxe, x86_64
Date: Wed, 17 May 2006 00:40:37 +0900
Message-ID: <4469F275.6070804@gmail.com>
References: <8E8F647D7835334B985D069AE964A4F7028FDC0C@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:34037 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751241AbWEPPkq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 11:40:46 -0400
Received: by py-out-1112.google.com with SMTP id b36so1268pyb
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 08:40:46 -0700 (PDT)
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7028FDC0C@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Cc: albertl@mail.com, Andi Kleen <ak@suse.de>, Marko Macek <Marko.Macek@gmx.net>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>

Fortier,Vincent [Montreal] wrote:
>> Fortier, can you please post full boot dmesg?
> 
> Sure.. Tonight when I`ll come back home.
> 
> BTW, you can use vincent instead :)
> 

Yeap, Vincent.  :-)

As bisecting patches is painful, let's postpone it until it can't be 
anymore.  If the boot log doesn't show much, I think I can insert codes 
disabling some of the new features such that full bisecting isn't necessary.

-- 
tejun
