From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 0/9] AHCI and SATA PHY support for BCM63138
Date: Sat, 29 Sep 2018 21:22:19 -0700
Message-ID: <CB3DCBF1-3ABB-41F1-8D5B-7444093BA927@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com> <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com> <fa91f7eb-3405-4607-9391-f043b73e7af6@ti.com> <3d4b406b-4fa4-9248-a0ab-d4eeea808034@gmail.com> <58d4992a-a06e-60e7-1856-5cd87741a771@gmail.com> <20180929085622.GD270328@devbig004.ftw2.facebook.com> <31fa33d5-afc2-b388-95f7-103451e9df3e@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <31fa33d5-afc2-b388-95f7-103451e9df3e@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Al Cooper <alcooperx@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org



On September 29, 2018 7:35:14 PM PDT, Jens Axboe <axboe@kernel=2Edk> wrote=
:
>On 9/29/18 2:56 AM, Tejun Heo wrote:
>> On Fri, Sep 28, 2018 at 03:41:23PM -0700, Florian Fainelli wrote:
>>> On 09/25/2018 09:12 AM, Florian Fainelli wrote:
>>>> On 09/24/2018 11:19 PM, Kishon Vijay Abraham I wrote:
>>>>> On Friday 21 September 2018 12:49 AM, Florian Fainelli wrote:
>>>>>> On 09/20/2018 12:16 PM, Florian Fainelli wrote:
>>>>>>> Hi Kishon, Tejun,
>>>>>>>
>>>>>>> This patch series adds support for the SATA AHCI and PHY found
>on the
>>>>>>> ARM-basd BCM63138 DSL SoCs=2E
>>>>>>>
>>>>>>> It would probably make sense for patches 1-3 to go through
>Kishon's
>>>>>>> tree, patches 4-7 through Tejun's tree, and I would be merging
>the last
>>>>>>> two patches through the Broadcom ARM-SoC tree=2E
>>>>>>>
>>>>>>> Let me know if this is not a workable plan, thank you very much!
>>>>>>
>>>>>> Looks like I had left patches with the incorrect subject, please
>>>>>> disregard the following patches:
>>>>>>
>>>>>> [PATCH 2/9] phy: broadcom: allow PHY_BRCM_SATA driver to be built
>for
>>>>>> DSL SoCs
>>>>>> [PATCH 5/9] ata: sata_brcmstb: Allow optional reset controller to
>be used
>>>>>> [PATCH 6/9] ata: ahci_brcmstb: Match 63138 compatible strings
>>>>>>
>>>>>> since they have incorrect/inconsistent titles, the other patches
>are
>>>>>> fine though=2E Sorry about that=2E
>>>>>
>>>>> merged the first 3 patches to linux-phy tree=2E
>>>>
>>>> Thanks a lot Kishon!
>>>
>>> Tejun, are you good with picking up patches 4-7 and I take the last
>two?
>>> Can you make sure you pick up the ones that contain "ahci_brcm" in
>their
>>> subject, I had incorrectly formatted them initially, sorry again
>about that=2E
>>=20
>> Jens is running the libata tree now=2E  Jens?
>
>I looked over them, but the series seems somewhat messed up=2E Can you
>resend 4-7?

Certainly, I accidentally sent duplicates that I had left in the directory=
=2E

--=20
Florian
