From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 10/13] ahci_imx: Adjust for ahci_platform
 managing the clocks
Date: Sun, 19 Jan 2014 20:30:37 +0100
Message-ID: <52DC27DD.5030309@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-11-git-send-email-hdegoede@redhat.com> <20140119124134.GQ15937@n2100.arm.linux.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB2OP6CLAKGQE4V4DF2I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140119124134.GQ15937-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
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

On 01/19/2014 01:41 PM, Russell King - ARM Linux wrote:
> On Sun, Jan 19, 2014 at 12:48:52AM +0100, Hans de Goede wrote:
>> +enum {
>> +	CLK_SATA,
>> +	CLK_SATA_REF,
>> +	CLK_AHB
>> +};
>
> Err, so we now rely on the order that these clocks are specified in DT
> rather than their name properties to provide the correct clock... that
> sounds particularly fragile to me.

Both in the ohci- / ehci-platform case, where the idea of purely addressing
clocks by index comes from, as well as in the ahci-platform case, people
have been asking me to make things more generic, so as to avoid having
a gazillion almost but not quite the same ehci-foo platform drivers.

This has already happened with ohci-foo.c drivers, and the hope is that
with the new generalized ohci-plaform.c many of the existing ohci-foo
drivers can go away over time.

The downside of this generalized approach is that we cannot use clock-names
since those tend to be implementation specific.

In the specific case of the ahci-imx driver this means that certain clocks
must be at a specific index, since it needs to know which one is the AHB
clock, as documented in the bindings documentation. I don't see how mandating
certain indices is different and/or more fragile then mandating certain names
in the bindings document. I agree that is is slightly less clear to someone
reading the dts, but that is the price we have to pay for this desire for
things to be generic.

Regards,

Hans
