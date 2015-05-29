From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 1/4] phy: phy-core: Make GENERIC_PHY an invisible option
Date: Fri, 29 May 2015 09:09:39 -0400
Message-ID: <20150529130939.GG27479@htj.duckdns.org>
References: <1429743853-10254-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1429743853-10254-2-git-send-email-arun.ramamurthy@broadcom.com>
 <55685D7E.9000700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55685D7E.9000700-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gregory CLEMENT <gregory.clement@free-electrons>
List-Id: linux-ide@vger.kernel.org

On Fri, May 29, 2015 at 06:07:18PM +0530, Kishon Vijay Abraham I wrote:
> Tejun, Maxime, Sylwester, Kyungmin
> 
> On Thursday 23 April 2015 04:34 AM, Arun Ramamurthy wrote:
> >Most of the phy providers use "select" to enable GENERIC_PHY. Since select
> >is only recommended when the config is not visible, GENERIC_PHY is changed
> >an invisible option. To maintain consistency, all phy providers are changed
> >to "select" GENERIC_PHY and all non-phy drivers use "depends on" when the
> >phy framework is explicity required. USB_MUSB_OMAP2PLUS has a cyclic
> >dependency, so it is left as "select".
> >
> >Signed-off-by: Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> 
> Need your ACK for this patch.

For ATA part,

 Acked-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
