From: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Subject: Re: [PATCH] linux-next remove wmb() from ide-dma-sff.c and scc_pata.c
Date: Tue, 31 Mar 2009 18:33:56 +0900
Message-ID: <49D1E384.8080009@toshiba.co.jp>
References: <da824cf30903301739l688e8eb2r46086953245ebbe5@mail.gmail.com>
	<alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, IDE/ATA Devel <linux-ide@vger.kernel.org>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, Grant Grundler <grundler@google.com>, LKML <linux-kernel@google.com>
List-Id: linux-ide@vger.kernel.org

2009/03/31 16:51, Geert Uytterhoeven wrote:
> On Mon, 30 Mar 2009, Grant Grundler wrote:
>> Followup to "[PATCH 03/10] ide: destroy DMA mappings after ending DMA"
>> email on March 14th:
>>     http://lkml.org/lkml/2009/3/14/17
>>
>> No maintainer is listed for "Toshiba CELL Reference Set IDE" (BLK_DEV_CELLEB)
>> or tx4939ide.c in MAINTAINERS. I've CC'd "Ishizaki Kou" @Toshiba (Maintainer for
>> "Spidernet Network Driver for CELL") and linuxppc-dev list in the hope
>> someone else
>> would know or would be able to ACK this patch.
> 
> tx49xx is MIPS, for Nemoto-san.

The patch looks good for Toshiba Cell Reference Set.
I think the patch will be acked by IDE maintainer.

Thank you for informing me of the contribution.

Regards,

-- Yoshi
