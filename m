From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Problems with Samsung SH-W163A SATA CD/DVDRW JMicron	20360/20363
 2.6.18.1
Date: Thu, 09 Nov 2006 07:26:40 -0500
Message-ID: <45531E80.7010908@tmr.com>
References: <f4527be0611081117x4f7610e1wc4aacbbfdcd6993a@mail.gmail.com> <1163017437.23956.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmr.com ([64.65.253.246]:42911 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S965369AbWKIMXv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Nov 2006 07:23:51 -0500
In-Reply-To: <1163017437.23956.73.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Lyon <andrew.lyon@gmail.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Alan Cox wrote:

>Several people are reporting problems with AHCI and CD burning - are all
>the people concerned seeing this with Jmicron controllers or with other
>cases too ?
>
Now that you say that, I did have problems in the May-June time frame 
with AHCI. The machine has since been redeployed, but I doubt that it 
was a Jmicron controller, it was whatever Dell was shipping when 
Pentium-II was still in use. I dropped in a new UHCI card and the 
problems went away.

Andrew, I don't know if using another interface is an option for you, 
but it might be useful information if you could try.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

