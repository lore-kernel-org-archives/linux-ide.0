From: Hernan Gustavo Solari <solari@df.uba.ar>
Subject: Re: Serial ATA does not find partitions (Hitachi HD, new? ATI controller)
 where old SATA works
Date: Mon, 01 Oct 2007 16:15:12 -0300
Message-ID: <47014740.5080002@df.uba.ar>
References: <46FC4384.7080607@df.uba.ar> <46FCCD57.2020507@gmail.com>
Reply-To: hgsolari@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from woody.df.uba.ar ([157.92.11.66]:45850 "EHLO woody.df.uba.ar"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbXJAT6F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Oct 2007 15:58:05 -0400
In-Reply-To: <46FCCD57.2020507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

Tejun

    netconsole, pritty nice debunging system... but (yes, there is 
always a but) it does not get to run.
    the method was well implemented, adding the acpi=off it sends the 
information to the receiving machine (I can even see passing a 
netconsole probing message in the machine under testing), but without 
turning off acpi it does not reach the point of loading and, 
consequently, it does not send a byte to the receiving machine.

Hence, result: empty output.

Hernan


-- 
Hernan G. Solari (solari@df.uba.ar http://www.df.uba.ar/~solari)
