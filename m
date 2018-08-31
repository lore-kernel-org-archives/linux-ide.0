From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
Date: Fri, 31 Aug 2018 08:35:23 -0600
Message-ID: <39f89b9d-f5bf-7c4a-8e68-252bfc0b91a4@kernel.dk>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
 <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
 <8fa866c5-6800-505f-53bc-5c1b27582ca6@kernel.dk>
 <20180831074024.w7yicj5y4imy57e2@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831074024.w7yicj5y4imy57e2@flea>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, LABBE Corentin <clabbe.montjoie@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Kishon Vijay Abraham I <kishon@ti.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>
List-Id: linux-ide@vger.kernel.org

On 8/31/18 1:40 AM, Maxime Ripard wrote:
> Hi Jens,
> 
> On Thu, Aug 30, 2018 at 08:52:52PM -0600, Jens Axboe wrote:
>> On 8/30/18 8:32 PM, Chen-Yu Tsai wrote:
>>> Hi,
>>>
>>> On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 8/30/18 1:01 PM, Corentin Labbe wrote:
>>>>> Hello
>>>>>
>>>>> This patchset add support for allwinner R40 AHCI controller.
>>>>>
>>>>> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
>>>>> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
>>>>> by this serie, so no regression should come with it.
>>>>>
>>>>> The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
>>>>> but will be resent for inclustion when all patchs will have hit linus
>>>>> tree.
>>>>
>>>> Applied 1-12 with Hans's blessing, thanks Corentin.
>>>
>>> Please don't merge device tree ("dts") patches, i.e. patches 9-12. We will
>>> merge them through the sunxi / armsoc tree. Having them in separate trees
>>> introduces conflicts when we have other stuff going through our tree.
>>
>> OK, fair enough, I can drop those.
> 
> And the DT bits actually have some issues that would need to change
> the code significantly.
> 
> Can you drop all of them please?

OK, can do. Corentin, please resend when everybody is happy with it.

-- 
Jens Axboe
