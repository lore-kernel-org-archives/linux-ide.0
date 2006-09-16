From: Tejun Heo <htejun@gmail.com>
Subject: Re: How to make SATA hotplug path tight?
Date: Sat, 16 Sep 2006 10:52:09 +0900
Message-ID: <450B58C9.7010904@gmail.com>
References: <8202f4270609150812r654c1319r511b18aadf7e1f7@mail.gmail.com>	 <20060915180903.GC25800@htj.dyndns.org> <8202f4270609151248k236d6c24vab519b64902f102e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:37525 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751447AbWIPBwN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Sep 2006 21:52:13 -0400
Received: by py-out-1112.google.com with SMTP id n25so4314705pyg
        for <linux-ide@vger.kernel.org>; Fri, 15 Sep 2006 18:52:13 -0700 (PDT)
In-Reply-To: <8202f4270609151248k236d6c24vab519b64902f102e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org

Fajun Chen wrote:
>    Tejun, I use SATA Sil24.  Where should ATA_FLAG_HRST_TO_RESUME be
> flagged?  I made one attempt by making the following change in
> libata.h and it seems not working sometimes (see log at the end)? I'm
> a little puzzled by different flags such as ap->flags, ehc->flags...
> Is there any document about new eh?

Add the flag to SIL24_COMMON_FLAGS.  No, there is no doc yet.  On my 
to-do list though.

-- 
tejun
