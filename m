From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hpt366 driver oops or panic with HighPoint RocketRAID 1520	SATA
 (HPT372N)
Date: Thu, 04 May 2006 23:53:57 +0400
Message-ID: <445A5BD5.2050508@ru.mvista.com>
References: <436FB350.6020309@inap.se> <1131467876.25192.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:48826 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030313AbWEDTzI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 May 2006 15:55:08 -0400
In-Reply-To: <1131467876.25192.51.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Johan Palmqvist <johan.palmqvist@inap.se>
Cc: mlaks@verizon.net, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

>>When used with a HighPoint RocketRAID 1520 SATA (HPT372N) the hpt366 
>>driver, compiled as a module, oops'es on loading. If the driver is 
>>compiled into the kernel it causes a kernel panic on boot while 
>>detecting the card. Kernels tested: 2.6.13.2, 2.6.13.4 and 2.6.14. 
>>Please CC any answers to me since I'm not on the list.

    I think I've dealt with this oops now, see my recent patches to this
driver, particularly the one that reads the f_CNT value saved by BIOS...

WBR, Sergei

