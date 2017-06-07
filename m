From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: ZBC_IN command translation
Date: Wed, 7 Jun 2017 18:11:33 +0900
Message-ID: <f9d14e79-fffd-1398-4767-ffe527bf9ee6@wdc.com>
References: <4b12630e-1add-6a4e-51ab-52417e60d4b2@wdc.com>
 <20170607090751.GA29487@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21027 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbdFGJLk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jun 2017 05:11:40 -0400
In-Reply-To: <20170607090751.GA29487@infradead.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>

Christoph,

On 6/7/17 18:07, Christoph Hellwig wrote:
> On Wed, Jun 07, 2017 at 06:03:52PM +0900, Damien Le Moal wrote:
>> Tejun, Hannes,
>>
>> Currently, in libata-scsi.c, the function ata_scsi_zbc_in_xlat
>> translating ZBC REPORT ZONES into the ZAC version returns an error if
>> the scsi command buffer length is not aligned on 512. This is possible
>> since the ZBC version allows report zones buffer as a multiple of 64B,
>> while the ZAC version of the same command requires 512B size alignment
>> of the command buffer.
>>
>> However, SAT-4, in section 9.13.3 says:
>>
>> "The SATL shall send the ATA REPORT ZONES EXT command with the ATA
>> RETURN PAGE COUNT field set to INT((ALLOCATION LENGTH + 511)/512)."
>>
>> So clearly, instead of returning an error, we need to bounce the scsi
>> command buffer to a bigger 512B size aligned temporary buffer for the
>> ZAC report zones. I do not see any code ready to use to do so easily,
>> but I may be missing it. Is there something that can be used to do so or
>> do I need to cook something ?
> 
> Just like for TRIM we should reject any ZBC_IN/OUT command that doesn't
> come from the block layer, and then we can tightly control what input
> we get.

Sure, that is one solution. However, not a ideal one as that would
prevent ZBC/ZAC drives working with target/iscsi.
There are a few problems there that I am fixing right now, but that
translation error is stopping all effort.

-- 
Damien Le Moal,
Western Digital
