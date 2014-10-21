From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: blkdiscard vs hdparm for erasing a SSD?
Date: Tue, 21 Oct 2014 18:06:07 +0100
Message-ID: <20141021180607.6f2ee53d@alan.etchedpixels.co.uk>
References: <2523736.cvg5kvG8qa@al>
	<543E82DE.8070405@seoss.co.uk>
	<1471878.ajvL24Q1JG@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471878.ajvL24Q1JG@al>
Sender: util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
Cc: Tim Small <tim-v0yPK6tSSg/10XsdtD+oqA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, util-linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

> The names suggest that TRIM is for marking sectors for garbage collection while
> SECURITY ERASE tries a bit harder. From the runtime performance point of view, I
> would expect that S.E. is at least as fast as TRIM as no more garbage needs to
> be collected at a later point. From a durability PoV, not so sure, it could be
> that S.E. overwrites all blocks (or not).
> 
> Anyway, I have not read into the details and unless the standards (and
> manufacturers) can guarantee certain behavior, it will likely vary between
> device models.

On a decent SSD security erase is almost immediate and does not need to
overwrite anything.

Alan
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
