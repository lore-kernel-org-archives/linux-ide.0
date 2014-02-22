From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [RFC 0/3] ahci_platform: drop support for a bunch
 of obsolete platform device types
Date: Sat, 22 Feb 2014 23:04:11 +0100
Message-ID: <201402222304.11652.marex@denx.de>
References: <1393086175-6383-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: Text/Plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDIOBYPK6QDRBX55USMAKGQEE6YUVGA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1393086175-6383-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Saturday, February 22, 2014 at 05:22:52 PM, Hans de Goede wrote:
> Hi Tejun, Marek,
> 
> This series, which is to be applied on top of my ahci_platform
> restructering series,  mostly speaks for itself.
> 
> I've some doubts about the 2nd patch, which removes the imx53-ahci platform
> device support from ahci_platform.c. I'm pretty sure this is obsolete and
> replaced by Marek's ahci_imx.c work, but not 100%, which is why this series
> is marked as RFC. Marek can you confirm that the code the 2nd patch removes
> is inded dead code?

I can confirm that with your sunxi 15-patch patchset + these three patches , the 
SATA port still works on i.MX53 DENX M53EVK board. The behavior from the user's 
point of view is unchanged.

> Tejun, if Marek confirms this is indeed dead code feel free to apply this
> despite the RFC marking.
> 
> Thanks & Regards,
> 
> Hans

Best regards,
Marek Vasut
