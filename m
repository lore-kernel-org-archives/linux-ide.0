From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: Re: Kernel panic when loading the IDE controller driver
Date: Tue, 26 Feb 2019 12:51:49 +0100
Message-ID: <37311a64-63ac-3ef2-9cdf-c19248cf7d77@samsung.com>
References: <1550055691105-0.post@n7.nabble.com>
 <7c695098-8b2b-5af0-c961-f25457459f8e@c-s.fr>
 <1550060685213-0.post@n7.nabble.com>
 <558c15bc-75d0-d02a-8a78-8155838b8809@c-s.fr>
 <1550062386389-0.post@n7.nabble.com>
 <173559f3-7b2b-735b-acc7-66ccbdc7905d@c-s.fr>
 <40b6281d-3aed-bff1-79fc-09a293d37b7f@c-s.fr>
 <CGME20190226115150eucas1p2f759d8df50102507a0ee66c4ab36003f@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <40b6281d-3aed-bff1-79fc-09a293d37b7f@c-s.fr>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, sgosavi1 <Sachin.Gosavi@emerson.com>
Cc: linuxppc-dev@ozlabs.org, "David S. Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On 02/14/2019 06:54 PM, Christophe Leroy wrote:
> 
> 
> Le 13/02/2019 à 16:27, Christophe Leroy a écrit :
>>
>>
>> Le 13/02/2019 à 13:53, sgosavi1 a écrit :
>>>> Why using 4.15.13 which is obsolete instead of using one of the Long
>>>> Term Support versions which are still maintained, like 4.14 or 4.19 ?
>>>> (see the complete list at https://www.kernel.org/category/releases.html)
>>>
>>> Well, when I started this task 4.15.13 was probably the latest stable
>>> release and hence we decided to port this version. In the older kernel, we
>>> have the m8260_setup.c source file for our board where the function
>>> "io_block_mapping" was used to configure the non-standard IO port address
>>> starting at 0xe0000000 location. This address was passed as the base address
>>> followed by control address and IRQ number to the ide-core.ko module. In the
>>> new kernel we do not have an option to send these addresses and IRQ numbers
>>> as arguments to the driver. Instead the ide-generic.c source file in the new
>>> kernel uses the standard IO port values and IRQ values. I modified the code
>>> in the above file to used the addresses and IRQ number we used in the past.
>>> Also, added code in the "MMU_init" function call available under
>>> arch/PowerPC/init_32.c to setup the IO port address range by adding the
>>> "io_block_mapping" call and the required IO port address range.
>>>
>>> Is there anything else that needs to be added or how can we configure the
>>> desired IO address range in the new kernel?
>>>
>>
>> Maybe look around https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=9a0e77f28b50128df0c9e26ae489e44e29a7270a
>>
>> Also look at ide_platform.c. I imagine there must be some way to set it up in your device tree.

Please don't add new users to subsystem deprecated almost 10 years ago..

>> Maybe Bartlomiej Zolnierkiewicz can help ?
>>
>> Christophe
> 
> Le 14/02/2019 à 09:17, sgosavi1 a écrit :>> Maybe look around
>>
>> I have gone through this before and also tried the pata_platform driver but
>> no success yet. I haven't found any example that passes the IO ports and IRQ
>> information through the device tree to the driver code.

Please look at pata_of_platform.c driver from libata subsystem,
it should have all required functionality.

>> Thanks,
>> Sachin.
> 
> 
> Maybe someone from the IDE SUBSYSTEM would be able to help better ?
> 
> Entire thread at http://linuxppc.10917.n7.nabble.com/Kernel-panic-when-loading-the-IDE-controller-driver-td150020.html#none
> 
> Christophe

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
