From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Wed, 8 Mar 2017 20:30:58 +0530
Message-ID: <1fd840c5-b0bb-726b-6357-669977c4ae5f@ti.com>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161212135537epcas5p440bbb93d40f0c41b3754635733b09879@epcas5p4.samsung.com>
 <8ea5971a-338d-e8b9-6be8-8fe2658fc04d@ti.com> <1709119.SQyio4Ct6n@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1709119.SQyio4Ct6n@amdc3058>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 07 March 2017 11:21 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Monday, December 12, 2016 07:24:47 PM Sekhar Nori wrote:
>> Hi Bartlomiej,
>>
>> On Monday 12 December 2016 06:15 PM, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> Hi,
>>>
>>> On Monday, July 18, 2016 08:15:08 PM Sekhar Nori wrote:
>>>> On Friday 15 July 2016 08:45 PM, Kevin Hilman wrote:
>>>>> Arnd Bergmann <arnd@arndb.de> writes:
>>>>>
>>>>>> On Wednesday, July 13, 2016 12:59:23 PM CEST Bartlomiej Zolnierkiewicz wrote:
>>>>>>>
>>>>>>> On Friday, July 08, 2016 10:23:48 PM Arnd Bergmann wrote:
>>>>>>>> On Friday, July 8, 2016 5:24:41 PM CEST Bartlomiej Zolnierkiewicz wrote:
>>>>>>>>> This patch disables deprecated IDE subsystem in assabet_defconfig
>>>>>>>>> (no IDE host drivers are selected in this config so there is no
>>>>>>>>> valid reason to enable IDE subsystem itself).
>>>>>>>>>
>>>>>>>>> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>>>>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>>>>>>>
>>>>>>>> I think the series makes a lot of sense. I have checked your assertions
>>>>>>>> in the changelogs and found no flaws in your logic, so I think we should
>>>>>>>> take them all through arm-soc unless there are other concerns.
>>>>>>>
>>>>>>> Thank you.
>>>>>>>
>>>>>>> Should I resend everything or just patches that were not reposted yet
>>>>>>> (the ones that were marked as RFT initially and got no feedback)?
>>>>>>
>>>>>> I'd be fine with just getting a pull request with all the patches that
>>>>>> had no negative feedback and that were not already applied (if any).
>>>>>>
>>>>>>>> Do you have a list of ARM defconfigs that keep using CONFIG_IDE and
>>>>>>>> how you determined that they need it?
>>>>>>>
>>>>>>> The only such defconfig is davinci_all_defconfig which uses
>>>>>>> palm_bk3710 host driver (CONFIG_BLK_DEV_PALMCHIP_BK3710).
>>>>>>>
>>>>>>>> I know that ARCH_RPC/ARCH_ACORN has a couple of special drivers that
>>>>>>>> have no libata replacement, are there any others like that, or are
>>>>>>>> they all platforms that should in theory work with libata but need
>>>>>>>> testing?
>>>>>>>
>>>>>>> All platforms except ARCH_ACORN, ARCH_DAVINCI & ARCH_RPC should work
>>>>>>> with libata.
>>>>>>
>>>>>> Adding Sekhar and Kevin for DaVinci: At first sight, palm_bk3710 looks
>>>>>> fairly straightforward (meaning someone has to do a few day's work)
>>>>>> to convert into a libata driver.
>>>>>>
>>>>>> As this is on on-chip controller that is part of a dm644x and dm646x,
>>>>>> it should also not be hard to test (as long as someone can find
>>>>>> a hard drive to plug in).
>>>>>
>>>>> I have a hard drive, but don't have any dm64xx hardware anymore to test
>>>>> this.  My last working dm644x board died last year.
>>>>
>>>> I have a working DM6446 EVM. I was able to connect a hard drive to it
>>>> and do some basic tests with v4.6 kernel.
>>>>
>>>> I will look into converting the driver to libata. Might take some time
>>>> because this is unfamiliar territory for me.
>>>
>>> Do you need some help with it?
>>>
>>> I can provide you with draft driver patch if you want.
>>
>> A draft driver patch will really help. I can test/debug. Otherwise, not
>> sure when I will really be able to get to this.
> 
> It took a while to get to it but here is the draft driver patch
> against v4.11-rc1.  Please test.

I tested this on DM6446 EVM. I was able to mount existing partitions on 
the hard disk and see that the directory listing looks good[1]. I will do 
more tests (including comparing performance with old driver) tomorrow. I 
did not have to do much to get it work[2]. Great job! Thanks!

I did see a warning reported during the build[3].

Regards,
Sekhar

[1] http://pastebin.ubuntu.com/24139206/

[2] The only patch I had to apply is (similar change required in couple
of other places too):

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 023480b75244..60a1f23890cd 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -744,7 +744,7 @@ static int davinci_phy_fixup(struct phy_device *phydev)
 	return 0;
 }
 
-#define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
+#define HAS_ATA		IS_ENABLED(CONFIG_PATA_BK3710)
 
 #define HAS_NOR		IS_ENABLED(CONFIG_MTD_PHYSMAP)
 
[3]

drivers/ata/pata_bk3710.c: In function 'pata_bk3710_set_piomode':
drivers/ata/pata_bk3710.c:223:5: warning: 'cycle_time' may be used uninitialized in this function [-Wmaybe-uninitialized]
  if (!cycle_time)
     ^
