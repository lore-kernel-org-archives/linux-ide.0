From: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: sunxi: Add an ahci-platform
 compatible AHCI driver for the Allwinner SUNXi series of SoCs
Date: Wed, 04 Dec 2013 14:16:49 +0100
Message-ID: <529F2B41.8090009@schinagl.nl>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl> <1386159055-10264-3-git-send-email-oliver@schinagl.nl> <20131204123708.GD3158@htj.dyndns.org> <529F2677.3070208@schinagl.nl> <20131204131402.GG3158@htj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDDZ7YMYRMGBBG6X7SKAKGQEBMLLO7A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131204131402.GG3158-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 04-12-13 14:14, Tejun Heo wrote:
> Hello,
>
> On Wed, Dec 04, 2013 at 01:56:23PM +0100, Oliver Schinagl wrote:
>> I took the imx driver as example, as I wasn't sure on where to
>> start. But I don't think it's possible yet without improving
>> ahci_platform as I suggested in the cover letter. So if
>> ahci_platform needs to be improved, I guess a separate patch series
>> would be more appropriate?
>>
>> So would it be acceptable to have this as the 2nd (and last?)
>> ahci_platform driver and go from there? Or do you want to block new
>> ahci_XXX drivers until ahci_platform has been improved?
>
> I don't want to block new drivers unconditionally but at least I want
> to know which direction we're headed in the longer term.  Right now it
> feels like we could be at the beginning of an uncoordinated explosion
> of these drivers which will take a hell lot mpore effort to clean up
> after the fact.  I could be wrong and these could actually be
> different enough to justify separate drivers and there isn't gonna be
> an avalanche of these but again I at least want to know the general
> direction things are headed before making any decisions.
I'd be happy to pour it in any form that's needed. I even do the 
modification/rewrite of ahci_platform if I get enough help as it might 
be a little over my head initially ;)

That said, I don't think it's much different at all and I do think it 
could be much simpler. In my mind, the sunxi_ahci driver wouldn't need 
to be much bigger then a few lines that are specific to the SoC 
(hardware init) and registerd to the ahci_platform framework via 
platform_ahci_register() instead of platform_device_register().

But again, point me (for dummies ;) in the right direction and I'll work 
on it with some help.

Oliver
>
> Thanks.
>
