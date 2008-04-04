From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] pata_scc: fix compile warning
Date: Fri, 04 Apr 2008 03:40:28 -0400
Message-ID: <47F5DB6C.8060801@garzik.org>
References: <20080327151331.e11d3665.sfr@canb.auug.org.au> <47EB7A88.6090004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40101 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbYDDHkb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 03:40:31 -0400
In-Reply-To: <47EB7A88.6090004@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Missed one during mass conversion (dc14c0c5).  Fix it.  Spotted by
> Stephen Rothwell.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
> Stephen Rothwell wrote:
>> Hi Jeff, Tejun (Heo?  I am sorry if I chose the wrong name),
> 
> Yeap, Tejun is fine.
> 
>> Today's build of linux-next produces this warning:
>>
>> drivers/ata/pata_scc.c:1002: warning: initialization discards 
>> qualifiers from pointer target type
>>
>> Presumably caused by commit dc14c0c5012855bfc9a5f76056b92f198d52834c
>> ("libata: implement and use ops inheritance").
> 
> Thanks for spotting this.  I couldn't compile test platform specific
> ones.  Hmm... pata_scc doesn't seem to have platform dependencies,
> maybe we can drop PPC_CELLEB dependency.
> 
> drivers/ata/pata_scc.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
> index 07f2d7a..f6a6ce1 100644
> --- a/drivers/ata/pata_scc.c
> +++ b/drivers/ata/pata_scc.c
> @@ -960,7 +960,7 @@ static struct scsi_host_template scc_sht = {
>     ATA_BMDMA_SHT(DRV_NAME),
> };
> 
> -static const struct ata_port_operations scc_pata_ops = {
> +static struct ata_port_operations scc_pata_ops = {
>     .inherits        = &ata_bmdma_port_ops,
> 

applied


