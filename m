From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [BUG 2.6.38.8] Bisected to commit 5fb46ae7b8c51b05a12c6a66108e8d398c20ee09
Date: Thu, 07 Jul 2011 06:23:56 +0200
Message-ID: <4E1534DC.3020306@t-online.de>
References: <4E11BAE0.5020208@t-online.de> <20110707003338.GA25302@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout01.t-online.de ([194.25.134.80]:34657 "EHLO
	mailout01.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab1GGEXx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2011 00:23:53 -0400
In-Reply-To: <20110707003338.GA25302@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: axboe@kernel.dk, kay.sievers@vrfy.org, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Am 07.07.2011 02:33, schrieb Greg KH:
> On Mon, Jul 04, 2011 at 03:06:40PM +0200, Knut Petersen wrote:
>> Hi everybody!
>>
>> An openSuse 11.2 system reliably refused to boot properly with kernel 2.6.38.8
>> although the prior 2.6.38.y kernels worked fine.  After a few seconds booting
>> stopped. Several <ctrl-c> did help, but a lot of services were not started properly,
>> only the root partition was available. Nothing unusual could be found in the
>> kernel messages.
>>
>> I bisected the problem to commit 5fb46ae7b8c51b05a12c6a66108e8d398c20ee09.
>>
>> That gave me the idea to disconnect the Plextor PX-755A dvd drive  and to
>> try 2.6.38.8 again. It booted without problem.
> Does the 2.6.39.2 kernel work properly for you?
>
Yes.  Kernel 2.6.38[,1,2,3,4,5,6,7] 2.6.39[1,2] 3.0-git are ok, only 2.6.38.8 is broken in the
way described above.

cu,
 knut
