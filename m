From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: sunxi: Add an ahci-platform
 compatible AHCI driver for the Allwinner SUNXi series of SoCs
Date: Wed, 04 Dec 2013 13:56:23 +0100
Message-ID: <529F2677.3070208@schinagl.nl>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl> <1386159055-10264-3-git-send-email-oliver@schinagl.nl> <20131204123708.GD3158@htj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDC2JNWXZAJBBT6N7SKAKGQEWPNPRMQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131204123708.GD3158-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
List-Id: linux-ide@vger.kernel.org


On 04-12-13 13:37, Tejun Heo wrote:
> On Wed, Dec 04, 2013 at 01:10:54PM +0100, oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org wrote:
>> From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
>>
>> This patch adds support for the sunxi series of SoC's by allwinner. It
>> plugs into the ahci-platform framework.
>>
>> Note: Currently it uses a somewhat hackish approach that probably needs
>> a lot more work, but does the same as the IMX SoC's.
>>
>> Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
>> ---
>>   .../devicetree/bindings/ata/ahci-sunxi.txt         |  24 ++
>>   drivers/ata/Kconfig                                |   9 +
>>   drivers/ata/Makefile                               |   1 +
>>   drivers/ata/ahci_platform.c                        |  12 +
>>   drivers/ata/ahci_sunxi.c                           | 305 +++++++++++++++++++++
> I'm not really liking the way things are going.  Do we really need
> separate drivers for each platform ahci implementation.  Are they
> really that different?  Would it be impossible to make ahci_platform
> generic enough so that we don't eventually end up with a gazillion
> ahci_XXX drivers?
I took the imx driver as example, as I wasn't sure on where to start. 
But I don't think it's possible yet without improving ahci_platform as I 
suggested in the cover letter. So if ahci_platform needs to be improved, 
I guess a separate patch series would be more appropriate?

So would it be acceptable to have this as the 2nd (and last?) 
ahci_platform driver and go from there? Or do you want to block new 
ahci_XXX drivers until ahci_platform has been improved?

Oliver
>
