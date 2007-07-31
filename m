From: Brad Campbell <brad@wasp.net.au>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Tue, 31 Jul 2007 19:35:32 +0400
Message-ID: <46AF56C4.60803@wasp.net.au>
References: <1185880124.3483.25.camel@localhost> <46AF3939.8020805@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:55799 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbXGaPfl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jul 2007 11:35:41 -0400
In-Reply-To: <46AF3939.8020805@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bob Ham <rah@bash.sh>, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:

>> I'm wondering if there are or will be libata drivers, or any drivers for
>> that matter, for hpt374-based SATA cards?
> 
>    As HPT374 is not a SATA chip, it needs SATA bridges to work with SATA 
> drives, hence no the only HPT374 libata driver that's going to ever be 
> is pata_hpt37x.

I've 2 of these cards lying around and when I last tested one of them ~2.6.20 thereabouts it worked 
as well as a pair of sil3112 cards provided you don't want hotplug. I have a test box here I'll fire 
up next week when I get some more sata drives to play with.


Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
