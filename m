From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hitachi 7K1000 1tb drives and sata_sil 3114 chipset
Date: Sat, 02 Feb 2008 16:34:52 +0900
Message-ID: <47A41D1C.9090209@gmail.com>
References: <76366b180801310013k48a8929ei2eb939b1cf449acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:55276 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727AbYBBHe7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 02:34:59 -0500
Received: by rv-out-0910.google.com with SMTP id k20so987057rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 23:34:59 -0800 (PST)
In-Reply-To: <76366b180801310013k48a8929ei2eb939b1cf449acb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: linux-ide@vger.kernel.org

Andrew Paprocki wrote:
> I've been encountering many, many problems with Hitachi 1tb drives
> under a Sil3114 chipset and I'm wondering if there could be something
> wrong with the driver/chipset in relation to these drives.
> Statistically, I've had 6 out of 7 drives exhibit very strange failure
> conditions while being used under this controller.
> 
> Some symptoms:
> - Clicking noises while in operation
> - What appears to sound/feel like the drive spins down quickly and
> back up again with no console output

This most definitely is a power problem.

> - SMART reporting seek read errors which mysteriously appear/disappear
> completely
> - Failed I/O requests

And you'll lose data and corrupt filesystems too.

Buy a new cheap single lane PSU.  Power it up and connect half of the
drives to the new PSU.

-- 
tejun
