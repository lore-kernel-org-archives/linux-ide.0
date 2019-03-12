From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: pata_oldpiix: Add missing device ID for
 INTEL_82371AB
Date: Tue, 12 Mar 2019 13:44:20 +0300
Message-ID: <1387821f-20d2-672f-5a7d-f7c2c4334dee@cogentembedded.com>
References: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
 <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
 <20190312104102.GA28302@Red>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312104102.GA28302@Red>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe@baylibre.com>
Cc: axboe@kernel.dk, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 03/12/2019 01:41 PM, LABBE Corentin wrote:

>>> When playing with a virtual SPARC machine with qemu, I found that the
>>> IDE emulated device was not probing with the ata/pata_oldpiix driver.
>>
>>    Correctly, it should probe with ata_piix,
>>
>>> But with the old ide/piix, it was probed.> 
>>> This is due to this PCI devid was not migrated from the old ide/piix.
>>
>>    It wasn't on purpose -- the IDE driver supports the original PIIX
>> incorrectly.
>>
> 
> Hello
> 
> What about removing this old driver totally if it dont work ?

   It supports the later Intrel controllers OK, just the original PIIX support
is buggy.

> Regards

MBR, Sergei
