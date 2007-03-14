From: Tejun Heo <htejun@gmail.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP	drive
Date: Wed, 14 Mar 2007 22:48:03 +0900
Message-ID: <45F7FD13.2070907@gmail.com>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <45F7E34B.6020206@gmail.com> <45F7F90B.6070709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:36258 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965424AbXCNNsK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 09:48:10 -0400
Received: by nz-out-0506.google.com with SMTP id s1so99558nze
        for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 06:48:09 -0700 (PDT)
In-Reply-To: <45F7F90B.6070709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Stanislav Brabec <sbrabec@novell.com>, albertl@mail.com, jeff@garzik.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun wrote:
>> If that's the case, libata should work too as long as the HSM problem is
>> fixed.
> 
> Really?  I didn't notice when libata gained ATAPI-disk support.
> 
> Are you *sure* about that??

Not sure sure but almost sure.  :-)  What ide-scsi does is borrowing
SCSI mid and high level drivers while using ide as SCSI low level
driver.  To SCSI, libata and ide-scsi aren't very different except that
libata also exports SBC device to it.  So, if SCSI could handle ATAPI
disk via ide-scsi, I don't think there is any reason it can't with libata.

Thanks.

-- 
tejun
