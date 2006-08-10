From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Merging libata PATA support into the base kernel
Date: Thu, 10 Aug 2006 15:14:52 +0100
Message-ID: <1155219292.22922.13.camel@localhost.localdomain>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <p733bc5nm5g.fsf@verdi.suse.de>
	 <1155213464.22922.6.camel@localhost.localdomain>
	 <20060810122056.GP11829@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:33762 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1161277AbWHJNzE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 09:55:04 -0400
In-Reply-To: <20060810122056.GP11829@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Iau, 2006-08-10 am 14:20 +0200, ysgrifennodd Jens Axboe:
> You make it sound much worse than it is. Apart for HPA, I'm not aware of
> any setups that require extra treatment. And the amount of reported bugs
> against it are pretty close to zero :-)

There are several variants where you get
	- hangs on resume
	- HPA mishandling
	- CRC errors and usually eventually a hang

HPA thankfully appears to bite only IBM thinkpad users

