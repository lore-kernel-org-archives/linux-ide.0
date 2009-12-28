From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCH 0/3] AHCI updates: Marvell AHCI PATA works; pata_marvell
 fate?
Date: Mon, 28 Dec 2009 00:19:28 -0500
Message-ID: <4B383FE0.3000701@fastmail.fm>
References: <20090417023949.GA14469@havoc.gtf.org> <loom.20091227T054252-842@post.gmane.org> <4B37D713.4070407@gmail.com> <4B37FB36.1040603@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49696 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751198AbZL1FTa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Dec 2009 00:19:30 -0500
In-Reply-To: <4B37FB36.1040603@fastmail.fm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On 12/27/2009 07:26 PM, Raman Gupta wrote:
> On 12/27/2009 04:52 PM, Robert Hancock wrote:
>> From your last post on the Bugzilla report, it looks like all 3 drives
>> basically stopped talking to the point they wouldn't respond to IDENTIFY
>> commands. That seems really strange to me. You mentioned you were doing
>> a surface scan at the time, which presumably would involve all disks
>> being accessed simultaneously.
>
> Yes, all drives were being access simultaneously, as they are part of a
> 4-disk md RAID-5 array.

Very interesting: I re-ran the fio test, but this time I configured 
the smartd and hddtemp daemons to ignore the drives attached to the 
Marvell controller. The test completed with no errors.

It certainly seems as if disk commands executed by the smartd or 
hddtemp daemons are causing the exception.

Cheers,
Raman
