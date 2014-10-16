From: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
Subject: Re: blkdiscard vs hdparm for erasing a SSD?
Date: Thu, 16 Oct 2014 12:17:38 +0200
Message-ID: <1471878.ajvL24Q1JG@al>
References: <2523736.cvg5kvG8qa@al> <543E82DE.8070405@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <543E82DE.8070405-v0yPK6tSSg/10XsdtD+oqA@public.gmane.org>
Sender: util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Small <tim-v0yPK6tSSg/10XsdtD+oqA@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, util-linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 15 October 2014 15:21:18 Tim Small wrote:
> On 15/10/14 14:12, Peter Wu wrote:
> > [ blkdiscard vs hdparm --security-erase] How does this compare. The goal is
> > to erase the contents of an previously used SSD to improve performance.
> >
> 
> When you use blkdiscard, the SSD (assuming a SATA SSD) will receive an
> ATA TRIM command, whereas hdparm --security-erase will issue an ATA
> SECURITY ERASE UNIT command.
> 
> What the drive then actually does is dependant on the implementation
> details of that particular SSD's firmware.
> 
> In general, I would expect the performance gain from TRIMing the entire
> drive to be either the same-as, or possibly less-than the gain from
> SECURITY ERASE.  For a sane firmware implementation I'd expect them to
> have the same effect on performance.  Firmware implementations are not
> always sane.

The names suggest that TRIM is for marking sectors for garbage collection while
SECURITY ERASE tries a bit harder. From the runtime performance point of view, I
would expect that S.E. is at least as fast as TRIM as no more garbage needs to
be collected at a later point. From a durability PoV, not so sure, it could be
that S.E. overwrites all blocks (or not).

Anyway, I have not read into the details and unless the standards (and
manufacturers) can guarantee certain behavior, it will likely vary between
device models.

Thank you for your reply!
-- 
Kind regards,
Peter
https://lekensteyn.nl

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
