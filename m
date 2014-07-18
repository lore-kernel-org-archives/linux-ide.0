From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v5 7/8] ata: Add support for the Tegra124 SATA controller
Date: Fri, 18 Jul 2014 13:49:54 +0300
Message-ID: <53C8FBD2.9@nvidia.com>
References: <1405500863-19696-8-git-send-email-mperttunen@nvidia.com> <1405667550-7707-1-git-send-email-mperttunen@nvidia.com> <53C8F65C.2020800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53C8F65C.2020800@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "tj@kernel.org" <tj@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Thanks!

- Mikko

On 18/07/14 13:26, Hans de Goede wrote:
> Hi,
>
> On 07/18/2014 09:12 AM, Mikko Perttunen wrote:
>> This adds support for the integrated AHCI-compliant Serial ATA
>> controller present on the NVIDIA Tegra124 system-on-chip.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>> v5: let ahci_platform handle sata clock and also handle it ourselves.
>>    this allows use of ahci_platform while having a special sequence
>>    for the clock.
>
> Thanks, I like this one, much better then what we had before.
>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans
>
>
>
 >> ...
