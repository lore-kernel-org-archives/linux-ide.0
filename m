From: Ocean HY1 He <hehy1@lenovo.com>
Subject: Re: [PATCH] Let AHCI dirver skip Lenovo SWRAID controller
Date: Tue, 26 Jan 2016 12:42:43 +0000
Message-ID: <56A76999.8050206@lenovo.com>
References: <1453691440-42035-1-git-send-email-hehy1@lenovo.com>
 <20160125131850.64c5c22a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160125131850.64c5c22a@lxorguk.ukuu.org.uk>
Content-Language: en-US
Content-ID: <C2ABC81E01C34940AB3B62059E7CB211@lenovo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Alan,

Thanks for your comments!

Lenovo SWRAID driver is a closed source driver at this time, I am afraid 
it's not possible to submit it to kernel.

This patch is very important and critical for Lenovo next generation 
Servers. I have tried to make sure this patch only impacts Lenovo 
dedicated hardware and add a on/off boot option to end user who may 
still wants using open source SWRAID(such as MDRAID).

I am a newbie to submit patch to kernel, so I am not so clear about what
my patch breaks. Could you kindly explain that and is there a workaround 
or solution to avoid the break?

Thanks a lot!

Ocean.

On 01/25/2016 09:18 PM, One Thousand Gnomes wrote:
> On Mon, 25 Jan 2016 03:11:40 +0000
> Ocean HY1 He <hehy1@lenovo.com> wrote:
> 
>> Lenovo SWRAID solution is based on Intel Non-RSTE RAID controller which
>> is called Lenovo SWRAID controller by set Lenovo dedicated PCI
>> SVID:SDID.
>>
>> Because AHCI driver now take control this Lenovo SWRAID controller for
>> MDRAID, Lenovo SWRAID driver fails to load later. It's not proper to
>> disable AHCI driver, because system has SATA contoller used for SATA
>> DVD, M.2 etc. There is no chance to load Lenovo SWRAID first, because
>> almost all Linux distros load AHCI driver first during installation.
>>
>> As default, when Lenovo SWRAID controller is detected, let AHCI driver
>> skip it thus MDRAID is disabled. Use the boot option 'ahci.lenovo_swraid=0'
>> could disable Lenovo SWRAID.
> 
> You need to submit the Lenovo SWRAID driver to the kernel first.
> Otherwise this breaks things.
> 
> Alan
> 
