From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC v4 10/10] ahci_imx: Port to library-ised ahci_platform
Date: Wed, 22 Jan 2014 08:25:42 +0100
Message-ID: <52DF7276.5050705@redhat.com>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com> <1390236303-22538-11-git-send-email-hdegoede@redhat.com> <20140122065151.GC16215@pengutronix.de>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB7XE7WLAKGQEGND5IYI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140122065151.GC16215-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 01/22/2014 07:51 AM, Sascha Hauer wrote:
> Hi Hans,
>
> On Mon, Jan 20, 2014 at 05:45:03PM +0100, Hans de Goede wrote:
>> This avoids the ugliness of creating a nested platform device from probe.
>>
>> Note untested, I've ordered a wandboard to be able to test these changes.
>
> Looks much better now, thanks. I could test this patch aswell, no need
> to buy new hardware for this.

Thanks for the offer, but the wandboard arrived yesterday. Having a bit more
variety in the arm hardware I've to test with is good to have anyways.

Regards,

Hans
