From: David Lechner <david@lechnology.com>
Subject: davinci common clock framework (was Re: [PATCH 03/10] devicetree:
 bindings: add bindings for ahci-da850)
Date: Tue, 17 Jan 2017 12:31:56 -0600
Message-ID: <ee95c747-4e24-4cad-80d2-b13f2e704122@lechnology.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-4-git-send-email-bgolaszewski@baylibre.com>
 <35ff358d-9b17-b2be-38d8-6a51cdddc1a1@lechnology.com>
 <CAMpxmJUau9BgAOhacPvcA=NwyE6-yEfDgPdcCZ_JCuNH-amJSA@mail.gmail.com>
 <d8406f53-b97d-ca9a-f7d1-94ce5b7064f7@ti.com>
 <CAMpxmJW9ns-aG=4zYHcV5-2b_TdmJ7q+Ap1jdyoxstZjWYRL2A@mail.gmail.com>
 <fb93275e-73ad-513b-6ac8-a39bbe43fd5c@lechnology.com>
 <37c826cc-9804-291e-a7b2-a512b59524fd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <37c826cc-9804-291e-a7b2-a512b59524fd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Kevin Hilman <khilman@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-ide@vger.kernel.org, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On 01/17/2017 06:00 AM, Sekhar Nori wrote:
> On Tuesday 17 January 2017 12:17 AM, David Lechner wrote:
>> On 01/16/2017 08:30 AM, Bartosz Golaszewski wrote:
>>> 2017-01-16 13:45 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>>>> On Monday 16 January 2017 03:43 PM, Bartosz Golaszewski wrote:
>>>
>>> It's true that once davinci gets ported (is this planned?) to using
>>> the common clock framework, we could just create a fixed-clock node in
>>> da850-lcdk for the SATA oscillator, so the new property is redundant.
>>>
>>
>> I have some commits[1] where I started on converting da850 to use the
>> common clock framework. But, I don't know anything about other davinci
>> family devices, so I don't think I could really take that to completion
>> without lots of help.
>
> I can help with testing, reviewing and filling in any missing
> information. But I wont have time to write the code itself.
>
>>
>> [1]: https://github.com/dlech/ev3dev-kernel/commits/wip-20160509
>
> I see that you have made a copy of the keystone PSC driver. I think you
> will need pretty strong reasons to not use the same driver with some
> customization for DaVinci.
>

It has been a while since I looked at this, but as I recall, the device 
tree bindings for keystone are horrible and make no sense. So, I made 
new bindings that make more sense. But since we can't break backwards 
compatibility in device tree, I made a new driver rather than having the 
mess of supporting two very different bindings in one driver. I don't 
know if that is a strong enough reason, but that is why I did it. :-)
