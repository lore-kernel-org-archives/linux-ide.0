From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: ata: add DT bindings for ahci-dm816 SATA controller
Date: Tue, 14 Mar 2017 11:43:47 +0100
Message-ID: <CAMpxmJXjy54jPaTTvCw4n2grvcJZvpUMf-acadr9OhUq=7T_Jg@mail.gmail.com>
References: <1489422982-3461-1-git-send-email-bgolaszewski@baylibre.com>
 <1489422982-3461-2-git-send-email-bgolaszewski@baylibre.com>
 <2d0ede95-86d6-4d52-6cf5-91de35a29145@cogentembedded.com> <CAMpxmJUO65yZDSKhL2k1V1fYRFn3psfCtwokbsZAm61UzcdjSg@mail.gmail.com>
 <61ee23f2-734b-f793-0054-364ce553ae5e@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <61ee23f2-734b-f793-0054-364ce553ae5e-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

2017-03-13 18:27 GMT+01:00 Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>:
> On 03/13/2017 08:08 PM, Bartosz Golaszewski wrote:
>
>>>> Add DT bindings for the onboard SATA controller present on the DM816x
>>>> SoCs.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/ata/ahci-dm816.txt | 20
>>>> ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-dm816.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/ata/ahci-dm816.txt
>>>> b/Documentation/devicetree/bindings/ata/ahci-dm816.txt
>>>> new file mode 100644
>>>> index 0000000..b87ed5a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/ata/ahci-dm816.txt
>>>> @@ -0,0 +1,20 @@
>>>> +Device tree binding for the TI DM816 AHCI SATA Controller
>>>> +---------------------------------------------------------
>>>> +
>>>> +Required properties:
>>>> +  - compatible: must be "ti,dm816-ahci"
>>>> +  - reg: physical base address and size of the register region used by
>>>> +         the controller (as defined by the AHCI 1.1 standard)
>>>> +  - interrupts: interrupt specifier (refer to the interrupt binding)
>>>> +  - clocks: clock specifiers (refer to the clock binding); two clocks
>>>
>>>
>>>
>>>    There should be a phandle preceding the clock specifier, all new such
>>> props are different to the old "interrupts" (which had phandle in a
>>> separate
>>> "interrupt-parent" prop).
>
>
>> I'm afraid I don't understand - could you point me to an example?
>
>
>    Have you read Documentation/devicetree/bindings/clock/clock-bindings.txt,
> on clock consumers?

Yes I have. It says:

 66 clocks:         List of phandle and clock specifier pairs, one pair
 67                 for each clock input to the device.  Note: if the
 68                 clock provider specifies '0' for #clock-cells, then
 69                 only the phandle portion of the pair will appear.

>    In fact, your own example below doesn't have clock specifiers, only
> phandles.
>

Since the SATA reference clock specifies 0 for #clock-cells I'll omit
the clock specifier. On the other hand: I'll rephrase the clocks
property description in the bindings for clarity.

Thanks,
Bartosz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
