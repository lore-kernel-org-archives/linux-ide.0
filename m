From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 05/13] ahci-platform: Pass ahci_host_priv
 ptr to ahci_platform_data init method
Date: Sun, 19 Jan 2014 19:51:48 +0100
Message-ID: <52DC1EC4.3090807@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-6-git-send-email-hdegoede@redhat.com> <20140119113051.GD11123@htj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBTF56CLAKGQEXI7Z3ZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140119113051.GD11123-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
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

On 01/19/2014 12:30 PM, Tejun Heo wrote:
> On Sun, Jan 19, 2014 at 12:48:47AM +0100, Hans de Goede wrote:
>> Some ahci_platform_data->init methods need access to the ahci_host_priv data.
>>
>> Note:
>>
>> When calling ahci_platform_data->init the ata_host has not been allocated yet,
>> so access to ahci_host_priv through the dev argument is not possible.
>>
>> The hpriv->mmio argument may seem redundant, but it is useful for drivers
>> which live outside of drivers/ata and thus don't know the contents of the
>> ahci_platform_data data type.
>
> Wouldn't the right thing to do be moving them under drivers/ata?

Yes, but they are part of arch/arm/mach-foo, so moving them is non trivial, and
I don't want to go make these kinda changes without hardware to test. Please keep
in mind that I'm partially cleaning up other peoples mess here (the imx bits
specifically). I'm willing to do that to some extend (*). But buying an imx6q board
and fixing that is about as far as I'm willing to go.

Regards,

Hans


*) Keep in mind that this is a hobby project done in my spare time, with all
hardware bought from personal budget.
