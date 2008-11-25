From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
Date: Tue, 25 Nov 2008 18:47:44 +0000
Message-ID: <20081125184744.7c012be5@lxorguk.ukuu.org.uk>
References: <492B56B0.9030409@caviumnetworks.com>
	<1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>
	<492C2F23.8050105@garzik.org>
	<20081125171224.297931b2@lxorguk.ukuu.org.uk>
	<492C46E2.90904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <492C46E2.90904@ru.mvista.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-ide@vger.kernel.org

> > Its close but I think Sergei is right about columns with all the same
> > value - they can be constants and just computed into the final timing
> > data in terms of clocks.
> 
>     The problem is that there's no exported libata API to compute just one 
> arbitrary timing.

To be clear: I agree entirely about adding those fields to the returned
timing structure. I just don't think adding a field that says 5 in each
entry of the internal table in the helper function is also useful.

Alan
