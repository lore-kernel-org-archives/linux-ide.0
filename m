From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SATA: OCTEON: support SATA on OCTEON platform
Date: Thu, 22 Jan 2015 08:19:55 -0600
Message-ID: <CAL_Jsq+Vtp=G6PJZvgksfLSXHBkoTC4TxLymP0ONk9MjaMtMPQ@mail.gmail.com>
References: <1421681040-3392-1-git-send-email-aleksey.makarov@auriga.com>
 <20150119154357.GH21553@leverpostej> <54BD580C.6030701@gmail.com>
 <20150121165427.GA8722@leverpostej> <54BFDF2B.80708@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54BFDF2B.80708-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Vinita Gupta <vgupta-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Jan 21, 2015 at 11:17 AM, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org> wrote:
> On 01/21/2015 08:54 AM, Mark Rutland wrote:
>>
>> On Mon, Jan 19, 2015 at 07:16:28PM +0000, David Daney wrote:
>
> [...]
>>>>>
>>>>> @@ -67,6 +76,7 @@ static const struct of_device_id ahci_of_match[] = {
>>>>>         { .compatible = "ibm,476gtr-ahci", },
>>>>>         { .compatible = "snps,dwc-ahci", },
>>>>>         { .compatible = "hisilicon,hisi-ahci", },
>>>>> +       { .compatible = "cavium,octeon-7130-ahci", },
>>>>>         {},
>>>>
>>>>
>>>> I was under the impression that the strings other than "generic-ahci"
>>>> were only for compatibility with existing DTBs. Why do we need to add
>>>> new platform-specific strings here?
>>>
>>>
>>> Because it is an "existing DTB", The device tree doesn't contain the
>>> compatible property of "generic-ahci", only "cavium,octeon-7130-ahci".
>>
>>
>> While the DTB may already exist, the string "cavium,octeon-7130-ahci"
>> isn't in mainline, and as far as I can see has never been supported.
>
>
> There seems to be a disconnect here.  The DTB comes from the hardware boot
> environment.  The hardware is in some cases already deployed.  It is for all
> practical purposes, impossible to change the DTB.
>
> The idea that the kernel source code controls the content of the device tree
> doesn't apply here.

I have to agree that adding the compatible string here is okay.
Allowing/using generic names is the exception, not the rule. We're
usually pushing the other way. People often complain about having to
add a compatible string when they don't need it (yet).

However, the argument that the privately developed DTB has to be
accepted as is is complete crap. Maybe you have done a good job and
have all straightforward bindings, so having them accepted won't be a
big deal. We should be reasonable and not bikeshed things which are
already in use and only affect a single device. Many of the bindings
in vendor trees I have seen are a complete mess, but I expect better
from you.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
