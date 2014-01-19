From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 11/13] ahci-imx: Don't create a nested
 platform device from probe
Date: Sun, 19 Jan 2014 20:08:54 +0100
Message-ID: <52DC22C6.6040806@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-12-git-send-email-hdegoede@redhat.com> <20140119122540.GN15937@n2100.arm.linux.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBTWF6CLAKGQETBGBXFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140119122540.GN15937-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 01/19/2014 01:25 PM, Russell King - ARM Linux wrote:
> On Sun, Jan 19, 2014 at 12:48:53AM +0100, Hans de Goede wrote:
>> Instead only provide platform_data through of_device_id, like the ahci-sunxi
>> driver does.
>
> It looks like the whole of ahci_imx.c (apart from the inclues) is
> enclosed in a big ifdef.  You can avoid that by using this in the
> Makefile:
>
>> @@ -10,9 +10,8 @@ obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
>>   obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
>>   obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
>>   obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
>> -obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o
>>
>> -ahci_plat-objs := ahci_platform.o ahci_sunxi.o
>> +ahci_plat-objs := ahci_platform.o ahci_imx.o ahci_sunxi.o
>
> ahci_plat-y := ahci_platform.o ahci_sunxi.o
> ahci_plat-$(CONFIG_AHCI_IMX) += ahci_imx.o
>

Ah, good idea, the same goes for the sunxi bits. I'll fix this in the next
revision of the patch-set.

Regards,

Hans
