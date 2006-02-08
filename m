From: Brian King <brking@us.ibm.com>
Subject: Re: [patch 08/15] libata: Add ability to prevent PRD from being allocated
Date: Wed, 08 Feb 2006 08:28:41 -0600
Message-ID: <43EA0019.9020806@us.ibm.com>
References: <200602061542.k16FgXXX015889@d03av03.boulder.ibm.com> <43E9D236.2080207@gmail.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <43E9D236.2080207@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Brian.
> 
> brking@us.ibm.com wrote:
>> For some HBAs, particularly SAS HBAs, there is no reason to
>> allocate a PRD buffer, since it is not used. Add a flag
>> to prevent its allocation.
>>
> 
> I think it's better done with ata_sas_port_start/stop rather than with
> ATA_FLAG_NO_PRD.  All sata low level drivers which don't use PRD table
> implement their own port_start/stop (ahci.c, sata_sil24.c for example).

Sounds good to me. I'll go ahead and drop this patch and add
ata_sas_port_start/stop.

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
