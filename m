From: arno@natisbad.org (Arnaud Ebalard)
Subject: Re: [BUG,REGRESSION] SATA regression on 12.0-rc4 kernel
Date: Wed, 09 Oct 2013 10:40:26 +0200
Message-ID: <8761t6bzwl.fsf@natisbad.org>
References: <87vc1ahyft.fsf@natisbad.org>
	<20131007125943.GA1332@titan.lakedaemon.net>
	<87bo303nfe.fsf@natisbad.org> <52537015.6040200@gmail.com>
	<87y564waw0.fsf@natisbad.org>
	<CADLC3L3EYU0VSfLMYjo013jSTWm4yZw24y+4HdvOOoEkOc6uhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mic92-1-81-57-185-249.fbx.proxad.net ([81.57.185.249]:35359
	"EHLO smtp.natisbad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab3JIIk7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Oct 2013 04:40:59 -0400
In-Reply-To: <CADLC3L3EYU0VSfLMYjo013jSTWm4yZw24y+4HdvOOoEkOc6uhQ@mail.gmail.com>
	(Robert Hancock's message of "Tue, 8 Oct 2013 23:50:33 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Marc Carino <marc.ceeeee@gmail.com>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, willy tarreau <w@1wt.eu>, Jason Cooper <jason@lakedaemon.net>


Robert Hancock <hancockrwd@gmail.com> writes:

>> With two different disks (same model though, i.e. 250GB 3.5" WD blue), it
>> consistently works on a 3.11.4 and consistently fails on 3.12-rc3 and
>> 3.12-rc4 (not tested others 3.12-rc). The problem is easy to reproduce,
>> i.e. I just need to perform some disk operations. With the two commits
>> reverted from 3.12-rc4, I can consistently do a "find / -exec sha256sum
>> '{}' \;" w/o anything happening.
>>
>> What I do not understand is why the log report failed FPDMA commands if
>> the feature is supposed to be SSD-related (looking only at commit
>> messages: 87fb6c31b9 seems SSD-related, ed36911c74 does not). Is it
>> possible that the feature detection is what is causing the issue? Or
>> that the hardware report support w/o having? I can test with a different
>> disk if you think it would help.
>
> The commands that are failing are WRITE FPDMA QUEUED which is a
> regular NCQ write command. The ones that these commits add support for
> are FPDMA_SEND and FPDMA_RECV which are used for NCQ trim commands.
>
> It's possible that the feature detection for this is picking up
> support for FPDMA SEND/RECV on this drive when it shouldn't be. Can
> you post the output of "hdparm --Istdout /dev/sdX" for one of these
> drives (where X matches the drive in question)?

Will do that tonight and post the output.

a+
