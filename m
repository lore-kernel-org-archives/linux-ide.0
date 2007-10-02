From: "Jonathan Bell" <doggs.lay.eggs@googlemail.com>
Subject: Re: Strange arbitrary port resets on ICH9R with Seagate drives
Date: Tue, 02 Oct 2007 02:17:38 +0100
Message-ID: <op.tzjpvoqnxci36i@akima.lan>
References: <op.tzhs1xqexci36i@akima.lan>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:30356 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbXJBBRd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 21:17:33 -0400
Received: by ug-out-1314.google.com with SMTP id z38so2009099ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 18:17:31 -0700 (PDT)
In-Reply-To: <op.tzhs1xqexci36i@akima.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, 01 Oct 2007 01:30:59 +0100, Jonathan Bell  
<doggs.lay.eggs@googlemail.com> wrote:

> Hello
>
> I've just purchased a brand spanking new G33/ICH9R based system for use  
> as a home fileserver with 4x ST3750840AS Seagate SATA drives as the main  
> grunt drives.
>
> The problem is that all of the seagate drives keep resetting, as this  
> dmesg excerpt shows:

Oops. Hardware problem. Insufficient power applied to the hotswap caddy  
resulted in the drives bugging out when all 4 were accessed, hence cat/dd  
on an individual drive caused no problems.

Now running these drives quite successfully in raid-5 with NCQ and 3.0Gbps  
links.

Regards
Jonathan
