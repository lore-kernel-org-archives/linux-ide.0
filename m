From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCHv3 0/4] add devm_of_phy_get_by_index and update platform
 drivers
Date: Thu, 23 Apr 2015 10:31:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504231031170.1529-100000@iolanthe.rowland.org>
References: <1429743853-10254-1-git-send-email-arun.ramamurthy@broadcom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429743853-10254-1-git-send-email-arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Laurent
List-Id: linux-ide@vger.kernel.org

On Wed, 22 Apr 2015, Arun Ramamurthy wrote:

> This patch set adds a new API to get phy by index when multiple 
> phys are present. This patch is based on discussion with Arnd Bergmann
> about dt bindings for multiple phys.
> 
> History:
> v1:
>     - Removed null pointers on Dmitry's suggestion
>     - Improved documentation in commit messages
>     - Exported new phy api
> v2:
>     - EHCI and OHCI platform Kconfigs select Generic Phy
>       to fix build errors in certain configs.
> v3:
>     - Made GENERIC_PHY an invisible option so 
>     that other configs can select it
>     - Added stubs for devm_of_phy_get_by_index
>     - Reformated code
> 
> Arun Ramamurthy (4):
>   phy: phy-core: Make GENERIC_PHY an invisible option
>   phy: core: Add devm_of_phy_get_by_index to phy-core
>   usb: ehci-platform: Use devm_of_phy_get_by_index
>   usb: ohci-platform: Use devm_of_phy_get_by_index

For patches 3 and 4:

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
