From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: Re: [PATCH 2/3] Add GD-Rom support to the SEGA Dreamcast
Date: Mon, 17 Dec 2007 00:06:23 +0000
Message-ID: <1197849983.1626.12.camel@localhost.localdomain>
References: <8b67d60712151621j2101c411p19d75125c6d1c2f9@mail.gmail.com>
	 <20071216095019.GA12184@linux-sh.org>
	 <1197826371.6254.14.camel@localhost.localdomain>
	 <20071216215929.GA14278@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20071216215929.GA14278@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Adrian McMenamin <lkmladrian@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org, axboe@kernel.dk
List-Id: linux-ide@vger.kernel.org


On Mon, 2007-12-17 at 06:59 +0900, Paul Mundt wrote:

> 
> While I realize that this is all undocumented and based entirely on
> reverse engineering, you should at least verify that that's precisely
> what is going on, and that this is not just a precaution for flushing
> posted writes. You can test that by removing the loop and doing a dummy
> read after your write (to the same register, rather than the entire ROM
> space). If it's a posting issue, then you will have to do your own
> read/write_reg routines that handle the flush.


I've looked at this some more and, from the various things on the web,
it seems SEGA introduced some sort of crude checksum security feature
which ctrl_outl(0x1fffff, GDROM_RESET_REG) appears to start. Unless it
is used then the GD Rom remains disabled.

After that, the hardware executes a checksum of the ROM to ensure that
you are actually booting from a Dreamcast.

Well, that is my interpretation of
http://www.ludd.ltu.se/~jlo/dc/bootROM.c and similar. Certainly any
other sort of read seems to keep the gdrom disabled.


