From: Jon K Hellan <hellan@acm.org>
Subject: Re: sata_sil.c, 3512 and SIL_QUIRK_MOD15WRITE
Date: Fri, 24 Feb 2006 19:07:19 +0100
Message-ID: <1140804439.24729.0.camel@localhost>
References: <loom.20060222T182150-518@post.gmane.org>
	 <43FD18F5.20002@gmail.com> <1140677987.11943.16.camel@localhost>
	 <20060223071921.GA24592@htj.dyndns.org>
	 <1140764920.15855.9.camel@localhost>  <43FEB413.7060800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tyholt.uninett.no ([158.38.60.10]:46814 "EHLO tyholt.uninett.no")
	by vger.kernel.org with ESMTP id S932410AbWBXSHg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2006 13:07:36 -0500
In-Reply-To: <43FEB413.7060800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

On Fri, 2006-02-24 at 16:21 +0900, Tejun Heo wrote:

> So, you're confirming that this workaround fixes your lockup on 3152 for
> both ST3200822AS and SP2504C, right?

I've now tested both disks, and can confirm that lockups are fixed for
both. Thanks.

Jon


