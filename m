From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE udma_status = 0x76 and 2.5.30...
Date: 05 Aug 2002 22:42:20 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1028583740.18130.82.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.10.10208051249520.11932-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10208051249520.11932-100000@master.linux-ide.org>
List-Id: linux-ide@vger.kernel.org
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, 2002-08-05 at 21:08, Andre Hedrick wrote:
> If we examine Table 2-3 of the Retired SFF-8038i rev 1.0 the only document
> to describe the behaviors of Bus Master IDE Status Register.
> It is a R/W field.

Andre - you are assuming the drive vendor follows 8038i and didnt just
leave the reserved bits random. At that point 0x76 makes reasonable
sense since its two DMA capable devices + a reserved bit and interrupt
with bus master error. 

Which simply means the code is still broken rather than anything truely
insane is happening. 

Alan

