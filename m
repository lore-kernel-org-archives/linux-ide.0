From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [BUG] 2.6.21.1: ide-pci is not finding ide controller.
Date: Thu, 24 May 2007 00:27:52 +0400
Message-ID: <4654A3C8.9010908@ru.mvista.com>
References: <20070523201118.GZ5921@austin.ibm.com> <20070523212425.68897280@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:61038 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757447AbXEWU0V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 16:26:21 -0400
In-Reply-To: <20070523212425.68897280@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linas Vepstas <linas@austin.ibm.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

>>I've got a rather old x86 box that I'm booting 2.6.21.1 on;
>>this kernel is not finding an ide controller on it. 

> HPT366 fixes were posted here earlier. It doesn't in fact have reliable
> enable bits.

   HPT36x either didn't have them yet or they were located in different place. 
Who knows -- I've never seen the specs...

MBR, Sergei
