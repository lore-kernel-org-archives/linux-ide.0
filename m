From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] amd74xx: don't configure udma mode higher than BIOS did
Date: Mon, 05 Feb 2007 18:32:11 +0300
Message-ID: <45C74DFB.5030703@ru.mvista.com>
References: <20070205075836.GG1625@htj.dyndns.org>	<20070205112410.5a3c3182@localhost.localdomain>	<45C72012.7050605@gmail.com> <20070205132247.6f611e3c@localhost.localdomain> <45C73A3E.6080700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15665 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932965AbXBEPcS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 10:32:18 -0500
In-Reply-To: <45C73A3E.6080700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:

> CK804 IDE, at least mine, reports 80c in a lot of cases where it
> shouldn't.  I dunno the reason but it also makes drives confused about
> cable type.  Maybe it has the wrong capacitor attached or something.
> This is A8N-E from ASUS, probably one of the popular ones using nf4.

> When that happens, libata EH does its job and slows the interface to
> udma33 after quite a few error messages.  On IDE, if this happens, the
> drive is put into PIO mode making the machine painful to use.

    Why? The old IDE core should just be downgrading UDMA to a speed where it 
starts working (i.e. 44 or 33 MB/s usually).

MBR, Sergei
