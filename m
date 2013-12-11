From: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: sunxi: Add an ahci-platform compatible AHCI
 driver for the Allwinner SUNXi series of SoCs
Date: Wed, 11 Dec 2013 15:51:51 +0100
Message-ID: <52A87C07.1020102@schinagl.nl>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl> <1386159055-10264-3-git-send-email-oliver@schinagl.nl> <20131204123708.GD3158@htj.dyndns.org> <529F2677.3070208@schinagl.nl> <20131204131402.GG3158@htj.dyndns.org> <529F2B41.8090009@schinagl.nl> <20131204132312.GH3158@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131204132312.GH3158-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Richard Zhu <r65037-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hey all,

On 04-12-13 14:23, Tejun Heo wrote:
> Hello,
>
> (cc'ing Richard and Shawn, hi!)
>
> On Wed, Dec 04, 2013 at 02:16:49PM +0100, Olliver Schinagl wrote:
>> On 04-12-13 14:14, Tejun Heo wrote:
>>> Hello,
>>>
>>> On Wed, Dec 04, 2013 at 01:56:23PM +0100, Oliver Schinagl wrote:
>>>> I took the imx driver as example, as I wasn't sure on where to
>>>> start. But I don't think it's possible yet without improving
>>>> ahci_platform as I suggested in the cover letter. So if
>>>> ahci_platform needs to be improved, I guess a separate patch series
>>>> would be more appropriate?
>>>>
>>>> So would it be acceptable to have this as the 2nd (and last?)
>>>> ahci_platform driver and go from there? Or do you want to block new
>>>> ahci_XXX drivers until ahci_platform has been improved?
>>> I don't want to block new drivers unconditionally but at least I want
>>> to know which direction we're headed in the longer term.  Right now it
>>> feels like we could be at the beginning of an uncoordinated explosion
>>> of these drivers which will take a hell lot mpore effort to clean up
>>> after the fact.  I could be wrong and these could actually be
>>> different enough to justify separate drivers and there isn't gonna be
>>> an avalanche of these but again I at least want to know the general
>>> direction things are headed before making any decisions.
>> I'd be happy to pour it in any form that's needed. I even do the
>> modification/rewrite of ahci_platform if I get enough help as it
>> might be a little over my head initially ;)
>>
>> That said, I don't think it's much different at all and I do think
>> it could be much simpler. In my mind, the sunxi_ahci driver wouldn't
>> need to be much bigger then a few lines that are specific to the SoC
>> (hardware init) and registerd to the ahci_platform framework via
>> platform_ahci_register() instead of platform_device_register().
>>
>> But again, point me (for dummies ;) in the right direction and I'll
>> work on it with some help.
> Richard and Shawn recently worked on ahci_imx.  Can you guys please
> talk with each other and figure out what can be done to share as much
> as possible among these new platform-specific drivers?  I'd really
> like to see the common things factored out as much as possible with
> only the actual hardware differences described for each device.
Working on this and studying the existing ahci_platform/shci_platform 
drivers the last few days and was figuring out why ahci_platform only 
supports 1 clock. IMX handles this by having 3 clocks defined in the DT, 
the first one gets enabled by default via ahci_platform, the other 2 get 
enabled in IMX's probe function.

Is it an idea to extend this to support all clocks that would be 
required (via a callback)? Or do we prefer having the clocks separated 
for other technical reasons? Or do we want to handle the clocks via the 
ahci_platform framework and extend hpriv->clk to an array of clocks?

Oliver

>
> Thanks a lot!
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
