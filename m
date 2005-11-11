From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: hpt366 driver oops or panic with HighPoint RocketRAID 1520	SATA
 (HPT372N)
Date: Sat, 12 Nov 2005 00:08:33 +0300
Message-ID: <43750851.1080306@ru.mvista.com>
References: <436FB350.6020309@inap.se> <1131467876.25192.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:41391 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751134AbVKKVGm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Nov 2005 16:06:42 -0500
In-Reply-To: <1131467876.25192.51.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

> I've got the correct timing tables and PLL tune information for the 302N
> now which appears to be very similar if not identical for these needs so
> if someone wants to hack the old drivers/ide/pci driver a bit I can
> provide reasonably accurate chip id and chip pll base information to
> enable a fix.

    I'm currently working on the old driver to bring in the HPT371N support 
and fix HPT371 clock setup (and make the other chip's clock setups correct 
along the way). Unfortunately I can test only on 371N and 370A, the board with 
371 soldered in has PCI contreoller fried.

WBR, Sergei
