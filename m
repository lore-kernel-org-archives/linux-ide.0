From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
Subject: Re: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
Date: Sun, 14 Feb 2016 19:36:18 -0800
Message-ID: <56C147B2.9010303@caviumnetworks.com>
References: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160214170152.GC3965@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160214170152.GC3965@htj.duckdns.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, stripathi@apm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org



On 02/14/2016 09:01 AM, Tejun Heo wrote:
> Hello,
>
> On Fri, Feb 12, 2016 at 03:20:30PM -0800, tchalamarla@caviumnetworks.com wrote:
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 546a369..76e310e 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -1560,6 +1560,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>   	if (ahci_broken_devslp(pdev))
>>   		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
>>
>> +	if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
>> +		ahci_thunderx_init(&pdev->dev, hpriv);
>
> So, this would make ahci fail to build if thunderx is not configured.
> Maybe we should add an additional callback to update hpriv.
>
>>   	/* save initial config */
>>   	ahci_pci_save_initial_config(pdev, hpriv);
>>
>> diff --git a/drivers/ata/ahci_thunderx.c b/drivers/ata/ahci_thunderx.c
>
> This driver isn't upstream yet, right?  Maybe just fold this change
> together?
>
There is no need for special Driver, AHCI is sufficient for ThunderX, 
the file only contains this interrupt handler,
is it preferable if this interrupt handler in libahci.c with others, 
instead of separate file?

Thanks,
Tirumalesh.

> Thanks.
>
