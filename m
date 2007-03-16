From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 18:23:14 +0300
Message-ID: <45FAB662.2040901@ru.mvista.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	 <45F56800.3040104@rtr.ca> <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com> <45F5A523.1080500@rtr.ca> <45FA8D7A.3040504@rtr.ca> <45FAA35C.2090902@ru.mvista.com> <45FAA822.7050208@rtr.ca> <45FAAACE.6000503@ru.mvista.com> <45FAACD4.6000709@rtr.ca> <45FAAD11.9010905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33627 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753540AbXCPPX0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 11:23:26 -0400
In-Reply-To: <45FAAD11.9010905@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello.

Mark Lord wrote:

> But if we really want to be 100% compliant, we could consider dropping
> to PIO0 for the command.  Not worth it, though, as in practice this is
> not necessary, and it would mess up libata far more than is worthwhile
> for this effort.

    I think it only requires the *host* to drop to PIO0 timings.  In which 
case it should be achievable w/o libata modification -- if the driver has to 
"snoop" command and turn off prefetch, why not switch to PIO0 temporarily?

> Cheers

MBR, Sergei
