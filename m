From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 1/2] ata: mediatek: add support for MediaTek SATA
 controller
Date: Mon, 14 Aug 2017 13:41:13 +0200
Message-ID: <b02142f2-c4be-73b2-3165-288ac10b0db3@gmail.com>
References: <cover.1502501342.git.ryder.lee@mediatek.com>
 <cf04d6bf9cf27911023b962ccd8639f063d32739.1502501342.git.ryder.lee@mediatek.com>
 <20170813183854.GA1438922@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170813183854.GA1438922@devbig577.frc2.facebook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Cc: devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Long Cheng <long.cheng@mediatek.com>
List-Id: linux-ide@vger.kernel.org



On 08/13/2017 08:38 PM, Tejun Heo wrote:
> On Sat, Aug 12, 2017 at 09:31:03AM +0800, Ryder Lee wrote:
>> This adds support the AHCI-compliant Serial ATA controller present
>> on MediaTek SoCs.
>>
>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> Looks good to me.
> 
>   Acked-by: Tejun Heo <tj@kernel.org>
> 
> If others are okay with it, please let me know how the patches should
> be routed.  I can push both through libata, both can be routed through
> dt tree, or we can handle them separately.
> 

Please take the device tree bindings through your tree as well.
You might want to wait for a Ack from a device tree maintainer though.

Thanks,
Matthias
