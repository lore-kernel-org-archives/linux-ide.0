From: Tejun Heo <htejun@gmail.com>
Subject: Re: Pls help for LibATA caused kernel temporary hung.
Date: Tue, 29 Jun 2010 09:20:16 +0200
Message-ID: <4C299EB0.6070102@gmail.com>
References: <AANLkTinbQHdo40Drqc5Ydur5lCrAktHHDig45HDrC6s1@mail.gmail.com> <4C2777D3.1050208@gmail.com> <AANLkTim-sAoDmNDqlM4k8WKeQJ0mTcxcm1VyO968BQZC@mail.gmail.com> <4C28653E.4080908@garzik.org> <AANLkTikwbBANkzepCW1XwbfSi3vvuq8iJNtG0WAZByDV@mail.gmail.com> <4C298077.6070102@gmail.com> <AANLkTimnoyjEVTmorcPD_Ph9TDjNo33jz7qcwEE0z6-2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36069 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab0F2HUV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jun 2010 03:20:21 -0400
Received: by bwz1 with SMTP id 1so549685bwz.19
        for <linux-ide@vger.kernel.org>; Tue, 29 Jun 2010 00:20:19 -0700 (PDT)
In-Reply-To: <AANLkTimnoyjEVTmorcPD_Ph9TDjNo33jz7qcwEE0z6-2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Li <simon.jiyou@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello, Simon.

On 06/29/2010 09:10 AM, Simon Li wrote:
> We observed that all the processes on the blade are totally stuck,
> though only one process is actually accessing the disks, other
> processes are mostly CPU-consuming applications.

Can you please turn on printk timestamp and attach the dmesg output
_after_ such failure?  I think there are two possibilities.  The
kernel could be generating too many messages to slow serial console,
or the it might as well be that all processes got stuck on IO.  It's
really difficult to figure out what's going on without more specific
information.  What does "stuck" mean?  Does it mean all of them are in
iowait or is the kernel just stuck inside kernel?

Thanks.

-- 
tejun
