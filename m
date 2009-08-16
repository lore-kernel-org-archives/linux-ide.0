From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] dmi: fix date handling in dmi_get_year()
Date: Sun, 16 Aug 2009 08:11:28 -0400
Message-ID: <4A87F770.7060008@pobox.com>
References: <4A87F512.3080802@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41832 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094AbZHPMLk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Aug 2009 08:11:40 -0400
In-Reply-To: <4A87F512.3080802@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Sandor Bodo-Merle <sbodomerle@gmail.com>, "Huang, Shane" <Shane.Huang@amd.com>, ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Year parsing in dmi_get_year() had the following two bugs.
> 
> * "00" is treated as invalid instead of 2000 because zero return from
>   simple_strtoul() is treated as error.
> 
> * "0N" where N >= 8 is treated as invalid of 200N because the leading
>   0 is considered to specify octal.
> 
> Fix the above two bugs by using endptr to detect invalid number and
> forcing decimal.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> While trying to implement dmi_get_date(), spotted two bugs in the
> current dmi_get_year().  Tricky date strings.  ;-P
> 
> I think it would be safer to postpone this and the next patch for the
> next merge window.  There's no reported case of these bugs causing
> problems yet, so no reason to risk behavior change at this stage.  If
> nobody objects, it would be easiest to push this through
> libata-dev#upstream.
> 
> Thanks.
> 
>  drivers/firmware/dmi_scan.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patchset looks good to me...   To make life easy, I would prefer to 
carry patches 1-2 in libata-dev#upstream, as well as patches 3-4.  If 
there are objections to that plan from anyone, speak now...  :)


	Jeff




