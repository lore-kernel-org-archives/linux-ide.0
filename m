From: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Tue, 27 Mar 2007 01:42:37 -0300
Message-ID: <4608A0BD.2010209@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:38663 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933971AbXC0Emn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 00:42:43 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2362703wxd
        for <linux-ide@vger.kernel.org>; Mon, 26 Mar 2007 21:42:42 -0700 (PDT)
In-Reply-To: <460899D4.6070708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

CORRECTION:

I tried with the irqpoll parameter (used in the right way) and the sata 
disk is detected but lots of "unexpected IRQ trap at vector a0" are 
displayed. When the pci=nomsi flag is set, no warning/error is shown and 
the SATA disk is detected properly.


This is for kernel version 2.6.17, I must be falling asleep.

Matias
