From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream] libata: blacklist NCQ on Seagate Barracuda
 ST380817AS
Date: Thu, 04 Oct 2007 21:32:55 +0900
Message-ID: <4704DD77.6070609@gmail.com>
References: <20071004020656.GA12186@htj.dyndns.org> <20071004125436.1ae8dbe8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:59208 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756432AbXJDMdD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 08:33:03 -0400
Received: by el-out-1112.google.com with SMTP id v27so30615ele
        for <linux-ide@vger.kernel.org>; Thu, 04 Oct 2007 05:33:02 -0700 (PDT)
In-Reply-To: <20071004125436.1ae8dbe8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, ornati@fastwebnet.it

Alan Cox wrote:
> On Thu, 4 Oct 2007 11:06:56 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> From: Paolo Ornati <ornati@fastwebnet.it>
>>
>> Seagate Barracuda ST380817AS has troubles with NCQ. For example,
>> unpacking a tarball on an XFS filesystem gives this:
>>
>> ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
>> ata1.00: cmd 61/40:00:29:a3:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 32768 out
>>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> 
> Looking at this and our NCQ code I don't see any provision for drive
> unfairness in our code. If we continue to issue commands to the drive I'm
> not seeing where we guarantee a given command will ever complete rather
> than being deferred forever by a dumb drive - which some SCSI drives also
> will do...

After several such timeouts, libata will turn off NCQ which should solve
the problem.

-- 
tejun
