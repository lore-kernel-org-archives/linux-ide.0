From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v8] SATA: OCTEON: support SATA on OCTEON platform
Date: Wed, 10 Feb 2016 10:12:52 -0800
Message-ID: <56BB7DA4.9010207@caviumnetworks.com>
References: <1455019469-5765-1-git-send-email-Zubair.Kakakhel@imgtec.com> <20160210160234.GH3741@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160210160234.GH3741@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, hdegoede@redhat.com, david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 02/10/2016 08:02 AM, Tejun Heo wrote:
> On Tue, Feb 09, 2016 at 12:04:29PM +0000, Zubair Lutfullah Kakakhel wrote:
> ...
>>   .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
>>   .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  42 +++++++++
>>   arch/mips/include/asm/octeon/cvmx.h                |   9 ++
>>   drivers/ata/Kconfig                                |   9 ++
>>   drivers/ata/Makefile                               |   1 +
>>   drivers/ata/ahci_platform.c                        |   1 +
>>   drivers/ata/sata_octeon.c                          | 105 +++++++++++++++++++++
>
> Don't we usually name these ahci variants ahci_xxx?
>

Just to be clear, are you suggesting renaming sata_octeon.c to 
ahci_octeon.c?

Or is it something else?

Thanks,
David Daney
