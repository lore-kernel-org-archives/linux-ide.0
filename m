From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 05/13] ahci-platform: Pass ahci_host_priv
 ptr to ahci_platform_data init method
Date: Sun, 19 Jan 2014 20:56:09 +0100
Message-ID: <52DC2DD9.7070403@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-6-git-send-email-hdegoede@redhat.com> <20140119113051.GD11123@htj.dyndns.org> <52DC1EC4.3090807@redhat.com> <20140119191706.GC32165@mtj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBYG36CLAKGQEFCR7GPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140119191706.GC32165-9pTldWuhBndy/B6EtB590w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 01/19/2014 08:17 PM, Tejun Heo wrote:
> On Sun, Jan 19, 2014 at 07:51:48PM +0100, Hans de Goede wrote:
>> Yes, but they are part of arch/arm/mach-foo, so moving them is non trivial, and
>> I don't want to go make these kinda changes without hardware to test. Please keep
>> in mind that I'm partially cleaning up other peoples mess here (the imx bits
>> specifically). I'm willing to do that to some extend (*). But buying an imx6q board
>> and fixing that is about as far as I'm willing to go.
>
> If they can't be moved, the right thing to do is moving the header out
> to include/linux so that they can be included from those directories.
> Let's please not contort the API to fit the organizational issues.

Ok, asking the obvious here I guess, but you would accept a patch moving drivers/ata/ahci.h
to include/linux as part of this patch-set ?

Regards,

Hans
