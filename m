From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/4] libata: separate out rw ATA taskfile building into
 ata_build_tf()
Date: Tue, 14 Nov 2006 16:04:53 -0500
Message-ID: <455A2F75.6050003@rtr.ca>
References: <11635120302199-git-send-email-htejun@gmail.com> <4559EB3B.9050805@rtr.ca> <4559F3F7.4080509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2322 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S966321AbWKNVEz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 16:04:55 -0500
In-Reply-To: <4559F3F7.4080509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
>
> First of all, that function is moved verbatim from ata_scsi_rw_xlat(), 

Yeah, I knew that.

Don't mind me, I'm just have a bit of a scatterbrain day,
switching back and forth between reviewing patches,
and deep thinking about another task.

For some odd reason I thought "lba_48_ok" checked whether
or not a drive could do LBA48.. probably because I have a routine
by that exact name in several drivers of my own coding.

But of course it's different here:  it's just checking the requested
block against the LBA48 range.   But is this even necessary here?
Presumably we already checked the block number against the device
max before getting to this point?

Or did we?  I don't actually see that code nearby,
but perhaps the SCSI mid-layer did it for us?
If not, *where* do we have that check?

Anyway, it will all work as is.
I'm just wondering if we can nuke a few lines or not.

Cheers
