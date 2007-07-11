From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 15/16] libata-link: update hotplug to handle PMP links
Date: Wed, 11 Jul 2007 11:45:13 +0900
Message-ID: <46944439.5050005@gmail.com>
References: <11832843613281-git-send-email-htejun@gmail.com> <46943978.4070207@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:52020 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbXGKCqf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 22:46:35 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1222621nze
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 19:46:35 -0700 (PDT)
In-Reply-To: <46943978.4070207@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Update hotplug to handle PMP links.  When PMP is attached, the PMP
>> number corresponds to I of SCSI C:H:I:L.
> 
> That doesn't sound right.  'I' == ID == SCSI concept of a target.  'I'
> needs to be the end device, with 'L' (LUN) being normally zero, but
> sometimes otherwise -- in the case of multi-LUN ATAPI devices.  Also,
> you have the order wrong, it's HCIL (host/channel/id/lun).

Yeah, that's from CHS.  :-)

> Since libata uses one SCSI host per port, HCIL translates to
> (port/link/id/lun) I should think.

Alright, will change.

-- 
tejun
