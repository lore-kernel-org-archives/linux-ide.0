From: Tejun Heo <htejun@gmail.com>
Subject: Re: storage fixup laptop model dependent ?
Date: Mon, 11 Jan 2010 17:11:46 +0900
Message-ID: <4B4ADD42.60604@gmail.com>
References: <91752840912030533k18aa5595kbdd6bbf716ce5976@mail.gmail.com>	 <91752840912140429s22d3aa86jd625e4c6411eb125@mail.gmail.com>	 <4B2712FE.10905@kernel.org> <91752840912180522h32077795yba6180d6b839af64@mail.gmail.com> <4B2EFAE9.3080406@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:35091 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab0AKIGG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2010 03:06:06 -0500
Received: by gxk3 with SMTP id 3so10138806gxk.1
        for <linux-ide@vger.kernel.org>; Mon, 11 Jan 2010 00:06:04 -0800 (PST)
In-Reply-To: <4B2EFAE9.3080406@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xavier <shiningxc@gmail.com>
Cc: linux-ide@vger.kernel.org, Kel Modderman <kel@otaku42.de>, mzxreary@0pointer.de, Kay Sievers <kay.sievers@vrfy.org>

Hello,

On 12/21/2009 01:34 PM, Tejun Heo wrote:
> (cc'ing Kay and Lennart.  Hello.)
> 
> A proper solution would be....
> 
> * Build database of load cycle limits and useable APM values on drive
>   models.  The former shouldn't be difficult.  Each vendor carries
>   only a few product lines at any given time and publish datasheets on
>   the webpage.  Plus, all the mobile drives I've seen are rated for
>   600,000 cycles.  The latter may be a bit more tricky.  Depending on
>   drive model, certain APM values simply don't work (e.g. 255 means
>   max power by spec but some firmwares wrap the value and recognize it
>   as min power), some values overheats the device and so on.  In most
>   cases the value 254 seems safe tho.  storage-fixup.conf should be
>   useable as the source for useable values, I think.
> 
> * Monitor load cycle count by smart commands and if it continues to
>   increase at an excessive rate (e.g. such that it reduces uptime to
>   under a year), warn the user and configure higher APM value.
> 
> As this problem mostly happens on laptops, I think it's probably best
> to handle this from the new desktop disk management thing so that the
> user can be warned.  Do you think it's feasible to handle this from
> devkit?

Lennart, any thought on this?

Thanks.

-- 
tejun
