From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V3 2/2] pata_arasan_cf: Adding support for arasan compact
 flash host controller
Date: Tue, 22 Feb 2011 15:13:31 +0530
Message-ID: <4D638543.8020509@st.com>
References: <cover.1298358936.git.viresh.kumar@st.com> <53bc03306736e6069737aa6344d71d639cea4912.1298358936.git.viresh.kumar@st.com> <20110222091449.GS31267@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:33201 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753302Ab1BVJny (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Feb 2011 04:43:54 -0500
In-Reply-To: <20110222091449.GS31267@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, amitgoel <amit.goel@st.com>, Armando VISCONTI <armando.visconti@st.com>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>

On 02/22/2011 02:44 PM, Tejun Heo wrote:
> On Tue, Feb 22, 2011 at 02:32:39PM +0530, Viresh Kumar wrote:
>> +static inline void dma_complete(struct arasan_cf_dev *acdev)
>> +{
>> +	struct ata_queued_cmd *qc = acdev->qc;
>> +
>> +	acdev->qc = NULL;
>> +	ata_sff_interrupt(acdev->irq, acdev->host);
>> +
>> +	if (unlikely(qc->err_mask) && ata_is_dma(qc->tf.protocol))
>> +		ata_ehi_push_desc(&qc->ap->link.eh_info, "DMA Failed: Timeout");
>> +}
> 
> ata_ehi_push_desc() needs to be called under host lock.  In case I
> missed other places, all functions which modify port/host states need
> to be called under host lock.  Please make sure they are.
> 

Ok. Will do that. I have checked other places, lock was missing only at this place.

>> +void arasan_cf_error_handler(struct ata_port *ap)
>> +{
>> +	struct arasan_cf_dev *acdev = ap->host->private_data;
>> +
>> +	cancel_work_sync(&acdev->work);
>> +	cancel_delayed_work_sync(&acdev->dwork);
>> +	return ata_sff_error_handler(ap);
>> +}
> 
> Please add some comments explaining what's going on with DMA
> processing as this driver is quite unusual.  Here and in the issue
> path.
> 

Will do that.

>> +static int __devinit arasan_cf_probe(struct platform_device *pdev)
>> +{
> ...
>> +	ap->flags |= ATA_FLAG_PIO_POLLING;
> 
> Maybe ATA_FLAG_NO_ATAPI too?
> 

Yes.

-- 
viresh
