From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Any guides for adding new IDE chipset drivers?
Date: Tue, 17 Feb 2004 07:41:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040217074131.5061fc5f.rddunlap@osdl.org>
References: <1077028026.31892.153.camel@cambridge.braddahead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1077028026.31892.153.camel@cambridge.braddahead.com>
To: Alex Bennee <kernel-hacker@bennee.com>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 17 Feb 2004 14:27:06 +0000 Alex Bennee <kernel-hacker@bennee.com> wrote:

| On Monday 16 of Febuary 2004 09:40:21 PST, Bart wrote:
| >On Monday 16 of February 2004 18:04, Alex Bennee wrote:
| >
| >> Is there a driver that can be held of as an example of good taste and
| >> the "right" way to implement a chipset driver?
| >
| >Yep.  Please take a look at drivers/ide/arm/icside.c.
| >It is well written, quite simple and has DMA support.
| 
| Thanks. I'll base my driver on this one as it does seem quite easy
| to follow. However I'm wondering what the point of the begin/end functions
| are. The dma_read/write functions just seem to call dma_count which starts the
| dma requests going.
| 
| Am I missing something here? Is all that required from the higher level a single
| call to dma_read/write or should I be expecting a series of calls to setup a transfer?
| 
| 
| >If you have any questions/issues feel free to ask
| >on linux-ide@vger.kernel.org mailing list.
| 
| Hmmm, vger seems to be ignoring my subscribe requests. 
| 
| Is the list archived anywhere? None are listed on VGER.

http://marc.theaimsgroup.com/?l=linux-ide



--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
