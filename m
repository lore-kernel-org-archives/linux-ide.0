From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: no DRQ after issuing MULTWRITE_EXT ?
Date: Thu, 1 Feb 2007 02:25:11 -0700
Message-ID: <311601c90702010125k788a681fv2ec27de98ab05a72@mail.gmail.com>
References: <45C1B079.3080704@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:52746 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422704AbXBAJZP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 04:25:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so413073uga
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 01:25:13 -0800 (PST)
In-Reply-To: <45C1B079.3080704@imc-berlin.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

On 2/1/07, Steven Scholz <steven.scholz@imc-berlin.de> wrote:
> Hi all,
>
> I am seeing kernel messages like
>
> [ 1284.480000] hda: status timeout: status=0xd0 { Busy }
> [ 1284.480000] ide: failed opcode was: unknown
> [ 1284.480000] hda: no DRQ after issuing MULTWRITE_EXT
> [ 1284.490000] ide0: unexpected interrupt, status=0x80, count=1
> [ 1284.830000] ide0: reset: success
>
> with a 2.5" Seagate ST940813AM on my embedded ARM system (linux 2.6.14, no
> IDE controller. HDD registers just memory mapped).
>
> HDD is used in PIO4 with MultSect=16.
>
> What exactly does that mean? Only that the HDD is to slow to answer this
> request with 100ms (WAIT_DRQ=(HZ/10))?
>
> And will the request issued again after the reset of the drive?
>
> Some old posting mentions that disabling "multi sector write" would help.
> But I did not find any references to why this would solve the problem.
> Is it a bug of this special HDD? Or a kernel problem?

Do you see this on every multiblock PIO write?  Or just occasionally?
