From: Tejun Heo <htejun@gmail.com>
Subject: Re: State of Port Multiplier Support in libata?
Date: Mon, 09 Jul 2007 10:42:56 +0900
Message-ID: <469192A0.6090005@gmail.com>
References: <4684D54A.8030307@enhance-it.dk> <4688A74B.7000604@gmail.com> <4688AB51.8080801@enhance-it.dk> <4688AE9D.7060008@gmail.com> <4688C3AF.2060100@enhance-it.dk> <4688C700.6070901@gmail.com> <4688FC96.7040604@enhance-it.dk> <4689149E.5030704@gmail.com> <46896824.2030507@enhance-it.dk> <4689BD18.6030202@gmail.com> <469133A3.6080805@enhance-it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:27904 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344AbXGIBnB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 21:43:01 -0400
Received: by nz-out-0506.google.com with SMTP id s18so528626nze
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 18:43:01 -0700 (PDT)
In-Reply-To: <469133A3.6080805@enhance-it.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Skotte <sfs@enhance-it.dk>
Cc: linux-ide@vger.kernel.org

Hello,

Stefan Skotte wrote:
> On the 1.5Gbps vs. 3.0Gbps issue I had, the problem was just that I
> hadn't paid attention to the factory default jumpers... They were set to
> 1.5Gbps ( I guess they do that for legacy purposes) :)

Okay.

> Do you want me to perform any other tests?

Not at the moment.

> PS: Are you going to convert the patches for ipr.c & ipr.h so you can
> apply the libata-tj patches without removing them ?

Yeah, now that 2.6.23-rc1 is open.  I'll update those and resubmit the
patch.

Thanks.

-- 
tejun
