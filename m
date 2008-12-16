From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 1/3] pata_hpt366: fix cable detection,
Date: Tue, 16 Dec 2008 20:15:32 +0900
Message-ID: <49478DD4.4080404@kernel.org>
References: <493E289F.1010000@kernel.org> <494785C0.4030106@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55665 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbYLPLPM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Dec 2008 06:15:12 -0500
In-Reply-To: <494785C0.4030106@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, rob.opensuse.linux@googlemail.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> pata_hpt366 is strange in that its two channels occupy two PCI
>> functions and both are primary channels and bit1 of PCI configuration
>> register 0x5A indicates cable for both channels.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
>> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>> ---
>>  drivers/ata/pata_hpt366.c |    8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> applied 1-2 of 3 (the last looked risky for -rc?)

I think it would be better to postpone it till the -rc1 window
opens.  As it has been broken for so long, I don't think many
people will complain much about one more broken release.  :-)

-- 
tejun
