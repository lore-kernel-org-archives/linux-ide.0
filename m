From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Fri, 18 Dec 2015 01:38:01 +0000
Message-ID: <yw1xmvt8bkp2.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1x1tanffqg.fsf@unicorn.mansr.com>
	<1450364395.30729.136.camel@linux.intel.com>
	<yw1x60zxds5k.fsf@unicorn.mansr.com>
	<1450367702.30729.146.camel@linux.intel.com>
	<yw1xk2odcb87.fsf@unicorn.mansr.com>
	<1450371184.30729.175.camel@linux.intel.com>
	<5672F77F.4010306@candw.ms> <yw1xfuz1c5xy.fsf@unicorn.mansr.com>
	<567302E8.5050303@candw.ms> <yw1x7fkcdi2a.fsf@unicorn.mansr.com>
	<5673061A.4070700@candw.ms> <yw1x37v0df86.fsf@unicorn.mansr.com>
	<56732C04.9040100@candw.ms> <yw1xvb7wbowu.fsf@unicorn.mansr.com>
	<56735A69.1000006@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56735A69.1000006@candw.ms> (Julian Margetson's message of "Thu,
	17 Dec 2015 20:59:21 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Julian Margetson <runaway@candw.ms> writes:

> On 12/17/2015 8:06 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>> Julian Margetson <runaway@candw.ms> writes:
>>
>>> On 12/17/2015 3:53 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>
>>>>> On 12/17/2015 2:51 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>>
>>>>>>> On 12/17/2015 1:59 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>>>>
>>>>>>>>> I have been running my machine mostly configured for pciex1  =
thus with
>>>>>>>>> the sata_dwc disabled.
>>>>>>>>> The changes to sata_dwc-460ex do cause an oops.
>>>>>>>>> I will try to give more detailed info over this weekend .
>>>>>>>> The driver as is upstream would do that since it unconditional=
ly
>>>>>>>> dereferences a null pointer in the probe function.  My patch f=
ixes that
>>>>>>>> as a side-effect.
>>>>>>>>
>>>>>>> patching file drivers/ata/Kconfig
>>>>>>>
>>>>>>> Hunk #1 FAILED at 296.
>>>>>> [...]
>>>>>>
>>>>>>> root@julian-VirtualBox:/usr/src/linux-3.18.25#
>>>>>> The patch is against 4.4-rc5.
>>>>>>
>>>>>    CC      drivers/ata/sata_dwc_460ex.o
>>>>>
>>>>> drivers/ata/sata_dwc_460ex.c:198:15: error: variable =C3=A2=E2=82=
=AC=CB=9Csata_dwc_dma_dws=C3=A2=E2=82=AC=E2=84=A2 has initializer but i=
ncomplete type
>>>>>
>>>>>    static struct dw_dma_slave sata_dwc_dma_dws =3D {
>>>>>                  ^
>>>> It builds, albeit with an unrelated warning, using the attached co=
nfig.
>>>> Maybe there's a missing config dependency somewhere.
>>>>
>>> I am attempting to cross compile under Ubuntu 14.04 X86 in Virtualb=
ox
>>> with your .config.
>>> 4.4.0-rc5 builds ok with no patches applied .
>>> Once your patch is applied it fails to build .
>>>
>>> CC      drivers/ata/sata_dwc_460ex.o
>>> drivers/ata/sata_dwc_460ex.c:198:15: error: variable =E2=80=98sata_=
dwc_dma_dws=E2=80=99 has initializer but incomplete type
>>>   static struct dw_dma_slave sata_dwc_dma_dws =3D {
>>>                 ^
>> Bizarre.  This is what it looks like here:
>>
>> mru@unicorn:/tmp/linux-sata$ git status
>> On branch sata-dwc
>> nothing to commit, working directory clean
>> mru@unicorn:/tmp/linux-sata$ git describe
>> v4.4-rc5
>> mru@unicorn:/tmp/linux-sata$ sha1sum /tmp/0001-ata-sata_dwc_460ex-us=
e-dmas-DT-property-to-find-dma-.patch
>> e300971aa483390f82de2e9120dc16e460e74feb  /tmp/0001-ata-sata_dwc_460=
ex-use-dmas-DT-property-to-find-dma-.patch
>> mru@unicorn:/tmp/linux-sata$ git am /tmp/0001-ata-sata_dwc_460ex-use=
-dmas-DT-property-to-find-dma-.patch
>> Applying: ata: sata_dwc_460ex: use "dmas" DT property to find dma ch=
annel
>> mru@unicorn:/tmp/linux-sata$ sha1sum .config
>> 4e7615b8d2fa9a1c4b4ae9ffc363aefcaf3789ca  .config
>> mru@unicorn:/tmp/linux-sata$ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpow=
erpc64-none-linux-gnu- oldconfig
>>    HOSTCC  scripts/basic/fixdep
>>    HOSTCC  scripts/kconfig/conf.o
>>    SHIPPED scripts/kconfig/zconf.tab.c
>>    SHIPPED scripts/kconfig/zconf.lex.c
>>    SHIPPED scripts/kconfig/zconf.hash.c
>>    HOSTCC  scripts/kconfig/zconf.tab.o
>>    HOSTLD  scripts/kconfig/conf
>> scripts/kconfig/conf  --oldconfig Kconfig
>> #
>> # configuration written to .config
>> #
>> mru@unicorn:/tmp/linux-sata$ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpow=
erpc64-none-linux-gnu- drivers/ata/sata_dwc_460ex.o
>> scripts/kconfig/conf  --silentoldconfig Kconfig

[...]

>>    CC      drivers/ata/sata_dwc_460ex.o
>> drivers/ata/sata_dwc_460ex.c: In function 'dma_dwc_xfer_setup':
>> drivers/ata/sata_dwc_460ex.c:383:20: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
>>    dma_addr_t addr =3D (dma_addr_t)&hsdev->sata_dwc_regs->dmadr;
>>                      ^
>> mru@unicorn:/tmp/linux-sata$
>>
>> Patch file and .config attached.
>>
>> Looking into that warning, I doubt it works as is, but that's not ca=
used
>> by my patch.  I can try to come up with a fix, but again, I can't te=
st it.
>>
> I am using
>
> make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu-

Shouldn't matter since the compiler flags include -m32, and I only had =
a
powerpc64 toolchain built.  Anyhow, I built a 32-bit toolchain and it
still builds.

Just to make sure you applied the patch correctly:

mru@unicorn:/tmp/linux-sata$ sha1sum drivers/ata/sata_dwc_460ex.c=20
c8a7927840aade75ac62b04a2c9acc8335a34d6f  drivers/ata/sata_dwc_460ex.c

Digging deeper into that warning, it is clearly a bug which has always
been there.  The reason it ever worked appears to be that the 460EX has
a dedicated DMA unit hard-wired to the SATA controller ignoring that
address.  The situation is similar on my hardware.

--=20
M=C3=A5ns Rullg=C3=A5rd
