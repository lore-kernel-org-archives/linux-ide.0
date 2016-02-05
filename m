From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v3 1/3] libahci: Implement the capability to override the
 generic ahci interrupt handler.
Date: Fri, 5 Feb 2016 10:06:35 -0800
Message-ID: <CAOHikRDeuyjT_OOBhivZiqVKFgHJAvEXsdcTtqYvjV6PSW+ZLA@mail.gmail.com>
References: <1454620826-22554-1-git-send-email-stripathi@apm.com>
 <1454620826-22554-2-git-send-email-stripathi@apm.com>
 <20160205164122.GB4401@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160205164122.GB4401@htj.duckdns.org>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jon Masters <jcm@redhat.com>, patches <patches@apm.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

On Fri, Feb 5, 2016 at 8:41 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Fri, Feb 05, 2016 at 02:50:24AM +0530, suman Tripathi wrote:
> ...
>> @@ -2504,15 +2505,28 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
>>       struct ahci_host_priv *hpriv = host->private_data;
>>       int irq = hpriv->irq;
>>       int rc;
>> +     irqreturn_t (*ahci_irq_handler)(int irq, void *dev_instance);
>>
>> +     ahci_irq_handler = hpriv->ahci_irq_intr;
>> +
>> +     if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX)) {
>> +             if (!ahci_irq_handler)
>> +                     rc = ahci_host_activate_multi_irqs(host, sht);
>> +             else
>> +                     dev_warn(host->dev, "both AHCI_HFLAG_MULTI_MSI flag set \
>> +                              and custom irq handler implemented\n");
>> +
>> +     } else {
>> +             if (!ahci_irq_handler) {
>> +                     ahci_irq_handler = (hpriv->flags & AHCI_HFLAG_EDGE_IRQ ?
>> +                                         ahci_single_edge_irq_intr :
>> +                                         ahci_single_level_irq_intr);
>> +             }
>> +     }
>
> I wrote this before but can't we do this in save_initial_config the
> same way ->start_engine override is handled?

Sorry missed that out.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi
