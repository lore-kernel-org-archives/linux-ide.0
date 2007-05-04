From: Komuro <komurojun-mbn@nifty.com>
Subject: [FW  ide-cs] Re: jvc cdrom drive
Date: Fri, 4 May 2007 23:32:38 +0900
Message-ID: <20070504233238.ca55c2d1.komurojun-mbn@nifty.com>
References: <1178202559.3767.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <1178202559.3767.21.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Richard Kennedy <richard@rsk.demon.co.uk>
Cc: linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, 03 May 2007 15:29:19 +0100
Richard Kennedy <richard@rsk.demon.co.uk> wrote:


IDE bugs should be posted to the linux-ide mailing list.


> Hi all, 
> I have a JVC MP-CDX1 cdrom drive that came with my laptop which used to
> work with ide-cs but stopped working with newer kernels.
> 
> I added its ident to ide-cs.c (see patch below) and the drive now is
> detected and gets mounted when plugged in and seems to work correctly.
> 
> But when I eject the card, pccardctl eject 0, the laptop locks up
> completely, there are no messages in the log, and the fan goes to full
> speed so I guess the cpu is running at 100%.
> Any ideas what's going wrong or how to debug it ? 
> Is there anything else I need to patch to get this working ?
> 
> Thanks
> Richard
> 
> card info :- 
> 
> PRODID_1="KME"
> PRODID_2="KXLC005"
> PRODID_3="00"
> PRODID_4=""
> MANFID=0032,2904
> FUNCID=8
> 
> log messages on insert :- 
> 
> May  3 11:22:52 mininote kernel: pccard: PCMCIA card inserted into slot 0
> May  3 11:22:52 mininote kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
> May  3 11:22:52 mininote kernel: pcmcia: registering new device pcmcia0.0
> May  3 11:22:53 mininote kernel: hdc: UJDB130, ATAPI CD/DVD-ROM drive
> May  3 11:22:53 mininote kernel: ide1 at 0x190-0x197,0x396 on irq 3
> May  3 11:22:53 mininote kernel: ide-cs: hdc: Vpp = 0.0
> May  3 11:22:54 mininote kernel: hdc: ATAPI 20X CD-ROM drive, 128kB Cache
> May  3 11:22:54 mininote kernel: Uniform CD-ROM driver Revision: 3.20
> May  3 11:23:04 mininote hald: mounted /dev/hdc on behalf of uid 500
> May  3 11:23:34 mininote hald: unmounted /dev/hdc from '/media/FC_4 i386 ftp #1' on behalf of uid 500
> May  3 11:24:17 mininote kernel: pccard: card ejected from slot 0
> << lockup happened here >>
> 
> patch
> --- linux-2.6.21.1/drivers/ide/legacy/ide-cs.c.orig	2007-05-02 12:09:57.000000000 +0100
> +++ linux-2.6.21.1/drivers/ide/legacy/ide-cs.c	2007-05-02 12:12:40.000000000 +0100
> @@ -362,6 +362,7 @@
>  	PCMCIA_DEVICE_MANF_CARD(0x000a, 0x0000),	/* I-O Data CFA */
>  	PCMCIA_DEVICE_MANF_CARD(0x001c, 0x0001),	/* Mitsubishi CFA */
>  	PCMCIA_DEVICE_MANF_CARD(0x0032, 0x0704),
> +	PCMCIA_DEVICE_MANF_CARD(0x0032, 0x2904),        /* KME KXLCOO5 JVC MP-CDX1 */
>  	PCMCIA_DEVICE_MANF_CARD(0x0045, 0x0401),	/* SanDisk CFA */
>  	PCMCIA_DEVICE_MANF_CARD(0x0098, 0x0000),	/* Toshiba */
>  	PCMCIA_DEVICE_MANF_CARD(0x00a4, 0x002d),
> 
>    
> 

Best Regards
Komuro
