From: Hannes Reinecke <hare@suse.de>
Subject: Re: Possible Bug In ATA/SCSI Fixed Sense
Date: Mon, 31 Oct 2016 21:09:47 +0100
Message-ID: <24db42f0-b994-85ab-dffd-c741c8e96e5c@suse.de>
References: <CANSCoS8aVbdcb7ZCxcW57FrqKr_k+OuHt0ZFzPLNQRQMZj_Gww@mail.gmail.com>
 <20161031155840.GA24605@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S946269AbcJaUJv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 31 Oct 2016 16:09:51 -0400
In-Reply-To: <20161031155840.GA24605@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Charles Machalow <csm10495@gmail.com>
Cc: linux-ide@vger.kernel.org

On 10/31/2016 04:58 PM, Tejun Heo wrote:
> Hello,
>
> On Fri, Oct 28, 2016 at 11:34:22AM -0700, Charles Machalow wrote:
>> As of Linux commit 14970f204b1993af7459d5bd34aaff38dfee6670, In
>> drivers/ata/libata-scsi.c in ata_gen_passthru_sense() line 1087,
>> desc[0] is set to tf->feature. This makes sense to me however 4 lines
>> below the same item in the array is set to 0.
>>
>> One of these lines must be unintended as no matter what the field will
>> always be 0 though for a couple lines it is set to tf-feature.
>>
>> I think that line 1091 is at fault because if I send down a nop
>> command, feature (error in this case) should be set to 4 in the
>> returned current task file.
>
> This looks to be from 11093cb1ef56 ("libata-scsi: generate correct ATA
> pass-through sense").  Hannes?
>
Indeed, that's an error.
I wanted to set byte 7 to zero, indicating there is no additional sense 
data to be had.
Patch has been sent.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
