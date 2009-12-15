From: Tejun Heo <tj@kernel.org>
Subject: Re: storage fixup laptop model dependent ?
Date: Tue, 15 Dec 2009 13:39:26 +0900
Message-ID: <4B2712FE.10905@kernel.org>
References: <91752840912030533k18aa5595kbdd6bbf716ce5976@mail.gmail.com> <91752840912140429s22d3aa86jd625e4c6411eb125@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36957 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbZLOEhb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Dec 2009 23:37:31 -0500
In-Reply-To: <91752840912140429s22d3aa86jd625e4c6411eb125@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xavier <shiningxc@gmail.com>
Cc: linux-ide@vger.kernel.org, Kel Modderman <kel@otaku42.de>

Hello,

On 12/14/2009 09:29 PM, Xavier wrote:
>> I am just wondering : does it really matter in which laptop that disk
>> is used ? As laptop disk can be changed/replaced easily, this also
>> sounds strange to me, but there might be a good reason I am missing :)

OEMs sometimes load specialized firmwares to drives and BIOS may
configure APM differently according to drive model, so it kind of
matters.

> Was it the right place for this information ?
> I added the two people who committed to storage-fixup git, just in case.

storage-fixup is at best a stop-gap measure until something better and
more intelligent comes along.  It might be able to serve as
documentation later on too.  I don't think it would be wise to
configure APM to certain value after matching only the drive model.
That's too wide.  A good solution would be...

* Build database of load cycle limits and useable APM values on drive
  models.

* Monitor load cycle count by smart commands and if it continues to
  increase at an excessive rate, warn the user and configure higher
  APM value.

If you replaced the drive yourself, putting hdparm command in one of
boot scripts should do it for now.  :-(

Thanks.

-- 
tejun
