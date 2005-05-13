From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [rfc/patch] libata -- port configurable delays
Date: Fri, 13 May 2005 15:13:50 -0400
Message-ID: <4284FC6E.7060300@pobox.com>
References: <20050513185850.GA5777@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262500AbVEMTow@vger.kernel.org>
In-Reply-To: <20050513185850.GA5777@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

Benjamin LaHaise wrote:
> Hello Jeff et al,
> 
> The patch below makes the delays in ata_pause() and ata_busy_wait() 
> configurable on a per-port basis, and enables the no delay flag on 
> the one chipset I've tested on.  Getting rid of the delays is worth 
> quite a bit: doing sequential 512 byte O_DIRECT AIO reads results in 
> a drop from 35.743s to 29.205s using simple-aio-min_nr 20480 10 (a copy 
> is available at http://www.kvack.org/~bcrl/simple-aio-min_nr.c).  
> Before this patch __delay() is the number one entry in oprofile 
> results for this workload.  Does this look like a reasonable approach 
> for chipsets that aren't completely braindead?  Cheers,

Well, there are several things going on here.

> @@ -469,7 +470,8 @@ static inline u8 ata_chk_status(struct a
>  static inline void ata_pause(struct ata_port *ap)
>  {
>  	ata_altstatus(ap);
> -	ndelay(400);
> +	if (!(ap->flags & ATA_FLAG_NO_UDELAY))
> +		ndelay(400);

This delay is required per spec.  So, this specific change is vetoed.


> @@ -478,7 +480,8 @@ static inline u8 ata_busy_wait(struct at
>  	u8 status;
>  
>  	do {
> -		udelay(10);
> +		if (!(ap->flags & ATA_FLAG_NO_UDELAY))
> +			udelay(10);
>  		status = ata_chk_status(ap);
>  		max--;
>  	} while ((status & bits) && (max > 0));

This delay is based on field experience, rather than spec.  I'm open to 
making this optional, as you have done.  Some issues related to this 
delay, to consider:

1) Nothing in life is free.  This delay is useful on some platforms, 
because banging away at the Status register for extended periods of time 
can cause an insane amount of PCI IO traffic.  Removing the delay just 
moves the punishment from one area to another.

2) In a few controllers, the SATA<->FIS emulation can go kerflooey if 
you bang the Status register 'too hard'.

3) IIRC some rare PATA devices don't like having their Status register 
banged "too hard".  No data, just a vague memory.

4) It may be worthwhile to rewrite the loop to check the Status register 
_first_, then delay.

Finally, simply disabling the delay is IMO _far_ too dangerous on such a 
popular driver (ata_piix).

I would be conservative, and create a module option for libata (not 
ata_piix) which allows a user to globally disable the delay.  And make 
sure that option defaults to 'delay', the current behavior.

Creative suggestions welcomed...

	Jeff
