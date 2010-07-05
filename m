From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Drives missing at boot
Date: Mon, 05 Jul 2010 17:59:59 -0600
Message-ID: <4C3271FF.9080308@gmail.com>
References: <AANLkTimVkG9TFgyOTTnrztBjqT4JoOzFaP268vWLAAm9@mail.gmail.com>	<4C2F5ECB.1040505@kernel.org>	<AANLkTinBn35687znO2_IxI3s1opkXrG2HpCRgsejNbMq@mail.gmail.com>	<4C2F87C1.8000701@hardwarefreak.com>	<AANLkTimVJEO-yF3GZ2ghX6DNPuAu-A-MNNO9x8Q1EpRc@mail.gmail.com>	<4C2F9292.708@hardwarefreak.com>	<AANLkTikPsRvvpSZirSygnZqyGKcS-Bz0eVeASZZqvZwH@mail.gmail.com>	<AANLkTintf2mwgBVuk_4GmfHTzyJebP2kyfcNGij_epy-@mail.gmail.com>	<4C31796C.8050209@kernel.org> <AANLkTinvNGha7SfaAWYIjUJwR9ZelCbHAWK0qvvllF9S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTinvNGha7SfaAWYIjUJwR9ZelCbHAWK0qvvllF9S@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Knecht <markknecht@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Stan Hoeppner <stan@hardwarefreak.com>, Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 07/05/2010 10:48 AM, Mark Knecht wrote:
> On Sun, Jul 4, 2010 at 11:19 PM, Tejun Heo<tj@kernel.org>  wrote:
>> Hello,
>>
>> On 07/04/2010 12:31 AM, Mark Knecht wrote:
>>> OK, I don't know if this is related but so far I cannot get the
>>> machine to boot if I set BIOS SATA configuration to AHCI. I believe
>>> that I have AHCI support as well as SATA support built into the kernel
>>> but when I set the BIOS to AHCI the machine just hangs saying it finds
>>> no medium. I assume that means no hard drive. I have to set SATA
>>> support to enhanced and then IDE to get the machine to boot at all.
>>
>> That's odd.  Can you please attach kernel boot log w/ ahci mode?
>> Booting a recent live CD and saving boot log from there should do the
>> trick.
>>
>> Thanks.
>>
>> --
>> tejun
>>
>
> Hi Tehun,
>     Thanks for the help.
>
>     I tried a Gentoo install CD from last march. It's a 2.6.31 type
> kernel. Problem is the buffer depths are not big enough to capture the
> complete dmesg contents and I don't know a command line option to make
> it larger on the fly. If you know of one that's got a larger buffer -
> or a command to increase it at boot time - then let me know and I'll
> try again.
>
>     I'm attaching what I was able to catch for both AHCI and IDE
> settings in BIOS for the storage configuration option.
>
>     It seems to me that even in AHCI mode the machine does see all the
> hard drives. Maybe there's something about my boot partition that's
> having problems in AHCI mode only? If it sees /dev/sda then why
> wouldn't it find grub and at least show a grub menu?

On some machines changing from IDE to AHCI messes up the boot order 
selection in the BIOS - you may have to switch to AHCI, save settings, 
reboot, go back into the BIOS and then make sure the disk boot order 
settings are correct (whatever drive grub is installed on needs to be 
first).
