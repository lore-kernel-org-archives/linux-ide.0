From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] ata: ahci: add support for non-standard port
 offset/length
Date: Mon, 2 May 2016 12:38:50 -0400
Message-ID: <20160502163850.GX7822@mtj.duckdns.org>
References: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1461335561-18363-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160422175936.GU7822@mtj.duckdns.org>
 <20160427142250.12764279@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160427142250.12764279-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hanna Hawa <hannah-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hello, Thomas.

On Wed, Apr 27, 2016 at 02:22:50PM +0200, Thomas Petazzoni wrote:
> I see a few possibilities:
> 
>  1/ Adjust all the drivers allocating manually an ahci_host_priv
>     structure, and make sure they initialize the fields to their default
>     values.
> 
>  2/ Add a new helper function that allows to allocate the
>     ahci_host_priv structure and initialize it with sane default values,
>     and use this helper in all drivers.
> 
>  3/ Add a flag in ahci_host_priv that tells whether non-standard port
>     offset/length are to be used. This is the most minimal solution,
>     but also maybe not the nicest one.

1 or 2 seems better to me.

> > If this needs to be configurable, wouldn't it be better to just let it
> > be specified per port?
> 
> How could it be per-port? The base for a port is calculated as:
> 
> 	base + <port_offset> + (port_no * <port_length>)
> 
> So, port_offset is clearly not per-port, there's only one of them. And
> if we were to make <port_length> a per-port property, then the formula
> would become a lot more complicated: we would have to iterate over each
> port, and see what is the length of the register area for each of them,
> to calculate the base address of the registers for the n-th port. This
> is clearly a complexity that is not needed for my use case: all ports
> have the same register area length, it's just that this length is
> non-standard.

Can't we just have hpriv->port_base?

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
