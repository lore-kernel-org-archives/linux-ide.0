From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ahci_sunxi: Drop AHCI_HFLAG_NO_PMP flag
Date: Fri, 14 Nov 2014 08:08:23 -0500
Message-ID: <20141114130823.GA21209@htj.dyndns.org>
References: <1415874256-6580-1-git-send-email-hdegoede@redhat.com>
 <20141113222952.GI2598@htj.dyndns.org>
 <037f97ce-468b-4b91-9616-51a3301c5be6@googlegroups.com>
 <5465FA40.8000508@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDQ2FCEAWYLRBT75S6RQKGQE5AWGZ5Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <5465FA40.8000508-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
Content-Disposition: inline
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Hans de Goede <jwrdegoede-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Fri, Nov 14, 2014 at 01:49:04PM +0100, Hans de Goede wrote:
> > I just found out why Allwinner added that AHCI_HFLAG_NO_PMP flag, after 
> > putting the system I used to test the port multiplexer back together this 
> > morning, it seems that probing for a port multiplexer being present breaks 
> > the no-port-multiplexer (so direct attached disk) case :(  I guess I should 
> > have tested for that before sending the patch, but the thought of it 
> > breaking normal usage did not cross my mind.
> > 
> > So self NACK. If it is not too late, can you please drop this from your 
> > tree ?

I popped the commit from libata/for-3.18-fixes.

Thanks.

-- 
tejun
